import 'dart:io';

import 'package:bogo_ambiental_app_movil/src/services/user_service.dart';
import 'package:bogo_ambiental_app_movil/src/utils/dialogs.dart';
import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/widgets/menu_drawer_widget.dart';
import 'package:bogo_ambiental_app_movil/src/widgets/sign_out_button_widget.dart';
import 'package:bogo_ambiental_app_movil/src/shared_preferences/user_preferences.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _prefs = new UserPreferences();
  File _imageUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          SignOutButtonWidget()
        ],
        title: Text('Inicio'),
        backgroundColor: Color.fromRGBO(63, 200, 156, 1.0)),
      drawer: MenuDrawerWidget(),
      body: ListView(
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () => _settingModalBottomSheet(context),
            child: FadeInImage(
              image: NetworkImage(_getUserImage()),
              placeholder: AssetImage('assets/image-loading.gif'),
              height: 250.0,
              fadeInDuration: Duration(milliseconds: 200),
              fit: BoxFit.cover
            ),
          ),
          SizedBox(height: 20.0),
          ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            title: Text('#SelfieBogoAmbiental'),
            subtitle: Text('Enterate de las ultimas fotos que han subido de los humedales'),
            leading: Icon(Icons.camera_alt, color: Colors.black54, size: 40.0,),
            trailing: Icon(Icons.arrow_forward, color: Colors.black54)
          ),
          SizedBox(height: 20.0),
          ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            title: Text('Humedal mas cercano'),
            subtitle: Text('Busca el humedal que prefieras visitar'),
            leading: Icon(Icons.map, color: Colors.black54, size: 40.0,),
            trailing: Icon(Icons.arrow_forward, color: Colors.black54)
          ),
          SizedBox(height: 20.0),
          ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            title: Text('Humedales'),
            subtitle: Text('Detalle de cada uno de los humedales, Conocelos'),
            leading: Icon(Icons.local_florist, color: Colors.black54, size: 40.0,),
            trailing: Icon(Icons.arrow_forward, color: Colors.black54)
          ),
          SizedBox(height: 20.0),
          ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            title: Text('Investigaciones'),
            subtitle: Text('Documentos de información y estudios realizados '),
            leading: Icon(Icons.insert_drive_file, color: Colors.black54, size: 40.0,),
            trailing: Icon(Icons.arrow_forward, color: Colors.black54)
          ),
          SizedBox(height: 20.0),
          ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            title: Text('Incidencias'),
            subtitle: Text('Conoce información relevante que ha pasado'),
            leading: Icon(Icons.select_all, color: Colors.black54, size: 40.0,),
            trailing: Icon(Icons.arrow_forward, color: Colors.black54)
          ),
        ],
      )
    );
  }

  String _getUserImage() {
    String imgDefaultUrl = 'https://bogoambientalstorage.s3.amazonaws.com/no-image.png';
    return _prefs.image != '' ? _prefs.image : imgDefaultUrl;
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(title: Text('Selecciona tu imagen')),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title:  Text('Cámara'),
                onTap: () => _selectImageFromCamera()
              ),
              ListTile(
                leading: Icon(Icons.photo_size_select_actual),
                title: Text('Galería'),
                onTap: () => _selectImageFromGallery(context)          
              ),
            ],
          ),
        );
      }
    );
  }

  _selectImageFromGallery(BuildContext context) async {
    _uploadImage(ImageSource.gallery);
  }

  _selectImageFromCamera() async {
    _uploadImage(ImageSource.camera);
  }

  _uploadImage( ImageSource resource) async {
    _imageUser = await ImagePicker.pickImage(
      source: resource
    );
    if (_imageUser != null) {
      final response = await UserService().uploadAvatarImage(_imageUser);
      if (response['status']) {
        Navigator.of(context).pop();
      }else {
      showAlertExample(context, response['error']);
      }
    }
    setState(() {});
  }
}