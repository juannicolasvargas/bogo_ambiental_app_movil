import 'package:bogo_ambiental_app_movil/src/services/user_service.dart';
import 'package:bogo_ambiental_app_movil/src/utils/dialogs.dart';
import 'package:flutter/material.dart';

class SignOutButtonWidget extends StatelessWidget {
  const SignOutButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: ()=> showDialogOut(context),
      ),
    );
  }

  void showDialogOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text('Seguro que desea salir?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.black54),),
              onPressed: ()=> Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Aceptar'),
              onPressed: ()=> _signOutUser(context),
            )
          ],
        );
      }
    );
  }

  void _signOutUser(BuildContext context) async {
    var response = await UserService().signOut();
    if (response['status']) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, 'login');
    }else{
      showAlertExample(context, response['error']);
    }
  }
}