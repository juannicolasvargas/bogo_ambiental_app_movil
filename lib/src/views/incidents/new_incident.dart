import 'package:flutter/material.dart';
import 'dart:io';

import 'package:bogo_ambiental_app_movil/src/blocs/provider.dart';
import 'package:bogo_ambiental_app_movil/src/services/incident_service.dart';
import 'package:bogo_ambiental_app_movil/src/utils/dialogs.dart';
import 'package:bogo_ambiental_app_movil/src/widgets/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';

class NewIncident extends StatefulWidget {
  @override
  _NewIncidentState createState() => _NewIncidentState();
}

class _NewIncidentState extends State<NewIncident> {

  File _image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final incidentBloc = Provider.incidentBloc(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Agregar incidencia'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _imageIncident(context, incidentBloc),
                  Container(
                    padding: EdgeInsets.only(top: 19.0),
                    width: size.width * 0.60,
                    child: _titleInput(incidentBloc)
                  )
                ]
              ),
              SizedBox(height: 20.0),
              _textAreaDescriptionInput(incidentBloc),
              _createSaveButton(incidentBloc, context)
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder _textAreaDescriptionInput(IncidentBloc bloc) {
    return StreamBuilder(
      stream: bloc.descriptionStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return TextField(
          maxLines: null,
          maxLength: 200,
          minLines: 8,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Descripción',
            hintText: "Ingresa tu texto aqui",
            errorText: snapshot.error
          ),
          onChanged: bloc.changeDescription,
        );
      },
    );
  }

  StreamBuilder _titleInput(IncidentBloc bloc) {
    return StreamBuilder(
      stream: bloc.titleStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return TextField(
          maxLength: 40,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Titulo',
            suffixIcon: Icon(Icons.title),
            errorText: snapshot.error
          ),
          onChanged: bloc.changeTitle,
        );
      },
    );
  }

  Widget _createSaveButton(IncidentBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.forValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          label: Text('Guardar'),
          icon: Icon(Icons.save),
          textColor: Colors.white,
          color: Color.fromRGBO(90, 180, 178, 1.0),
          onPressed: snapshot.hasData ? ()=> _creatingIncident(bloc, context) : null,
        );
      },
    );
  }

  Future _creatingIncident(IncidentBloc bloc, BuildContext context) async {
    onLoading(context, 'incidencia');
    final response = await IncidentService().createIncident(bloc.title, bloc.description, _image);
    if (response['status']) {
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, 'incidents');
    }else {
      Navigator.of(context).pop();
      showAlertExample(context, response['error']);
    }
  }

  Widget _imageIncident(BuildContext context, IncidentBloc bloc) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _settingModalBottomSheet(context, bloc),
      child: Image(
        width: size.width * 0.30,
        image: AssetImage(_image?.path ?? 'assets/placeholder-image.jpg'),
        height: size.height * 0.08,
      )
    );
  }

  void _settingModalBottomSheet(context, IncidentBloc bloc) {
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
                onTap: () => _selectImageFromCamera(bloc)
              ),
              ListTile(
                leading: Icon(Icons.photo_size_select_actual),
                title: Text('Galería'),
                onTap: () => _selectImageFromGallery(bloc)          
              ),
            ],
          ),
        );
      }
    );
  }

  _selectImageFromGallery(IncidentBloc bloc) async {
    _uploadImage(ImageSource.gallery, bloc);
  }

  _selectImageFromCamera(IncidentBloc bloc) async {
    _uploadImage(ImageSource.camera, bloc);
  }

  _uploadImage( ImageSource resource, IncidentBloc bloc) async {
    Navigator.of(context).pop();
    _image = await ImagePicker.pickImage(
      imageQuality: 40,
      source: resource
    );
    if (_image != null) {
      bloc.changeimage(_image.path);
    }
    setState(() {});
  }
}