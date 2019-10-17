import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/blocs/provider.dart';
import 'package:bogo_ambiental_app_movil/src/services/user_service.dart';
import 'package:bogo_ambiental_app_movil/src/utils/dialogs.dart';

class RegisterView extends StatelessWidget {

  final _styleName = TextStyle(color: Colors.white, fontSize: 40.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context)
      ],),
    );
  }

  Widget _createBackground(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.4,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
               colors: <Color> [
                 Color.fromRGBO(63, 200, 156, 1.0),
                 Color.fromRGBO(90, 180, 178, 1.0),
               ]
            )
          ),
        ),
        Positioned(child: _circleBackground(),top: 90.0,left: 30.0),
        Positioned(child: _circleBackground(),top: -40.0,right: -30.0),
        _createBackgroundTitle(),
        _registerForm(size, context)
      ],
    );

  }

  Widget _registerForm(Size size, BuildContext context) {

    final bloc = Provider.of(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(height: 190.0,),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0,5.0)
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Crear cuenta', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _createEmailInput(bloc),
                SizedBox(height: 30.0),
                _createNameInput(bloc),
                SizedBox(height: 20.0),
                _createLastNameInput(bloc),
                SizedBox(height: 20.0),
                _createPasswordInput(bloc),
                SizedBox(height: 30.0),
                _createButtonRegister(bloc, context)
              ],
            ),
          ),
          FlatButton(
            onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
            child: Text('¿Ya tienes cuenta? Ingresa'),
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _createBackgroundTitle() {
    return Column(
        children: <Widget>[
          SizedBox(width: double.infinity, height: 90.0,),
          Text('Bogotá',style: _styleName),
            Text('Ambiental',style: _styleName)
        ],
      );
  }

  Widget _circleBackground() {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }

  Widget _createEmailInput(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.only(right: 20.0, left: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo Electrónico',
              suffixIcon: Icon(Icons.alternate_email),
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );

    
  }

  Widget _createPasswordInput(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.only(right: 20.0, left: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Contraseña',
              suffixIcon: Icon(Icons.lock_outline),
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _createNameInput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.only(right: 20.0, left: 20.0),
          child: TextField(
            maxLength: 20,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre',
              suffixIcon: Icon(Icons.person),
              errorText: snapshot.error
            ),
            onChanged: bloc.changeName,
          ),
        );
      },
    );
  }

    Widget _createLastNameInput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.lastNameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.only(right: 20.0, left: 20.0),
          child: TextField(
            maxLength: 20,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Apellido',
              suffixIcon: Icon(Icons.accessibility),
              errorText: snapshot.error
            ),
            onChanged: bloc.changeLastName,
          ),
        );
      },
    );
  }

  Widget _createButtonRegister(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.forRegisterValidStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Color.fromRGBO(90, 180, 178, 1.0),
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _createUser(bloc, context) : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Crear cuenta', style: TextStyle(fontSize: 17.0),)
          ),
        
        );
      },
    );
  }

  Future _createUser(LoginBloc bloc, BuildContext context) async {
    final response = await UserService().createRegister(
      bloc.email,
      bloc.name,
      bloc.lastName,
      bloc.password
      );
    if (response['status']) {
      Navigator.pushReplacementNamed(context, 'home');
    }else{
      showAlertExample(context, response['error']);
    }
  }
}