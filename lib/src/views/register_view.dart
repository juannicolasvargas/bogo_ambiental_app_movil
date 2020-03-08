import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/widgets/loading_dialog.dart';
import 'package:bogo_ambiental_app_movil/src/blocs/provider.dart';
import 'package:bogo_ambiental_app_movil/src/services/user_service.dart';
import 'package:bogo_ambiental_app_movil/src/utils/dialogs.dart';

class RegisterView extends StatelessWidget {

  bool _validData = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _background(context),
          _scrollView(size, context)
        ],
      )
    );
  }

  Widget _background(BuildContext context) {    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Image.asset("assets/image_01.png"),
        ),
        Expanded(
          child: Container(),
        ),
        Image.asset("assets/image_02.png")
      ],
    );
  }

  Widget _scrollView(Size size, BuildContext context) {

    final bloc = Provider.of(context);
    
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
        child: Column(
          children: <Widget>[
            _backgroundText(),
              SizedBox(height: 100),
            _registerForm(bloc),
            SizedBox(height: 40),
            _createButtonRegister(bloc, context),
            SizedBox(height: 40),
            _newUSer(context),            
            SizedBox(height: 70.0)
          ],
        ),
      ),
    );
  }

  Container _registerForm(LoginBloc bloc) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 15.0),
            blurRadius: 15.0),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, -10.0),
            blurRadius: 10.0
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Registrarse',
            style: TextStyle(
              fontSize: 23.0,
              fontFamily: "Poppins-Bold",
              letterSpacing: .6,
              fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 30.0),
            _createEmailInput(bloc),
            SizedBox(height: 30.0),
            _createNameInput(bloc),
            SizedBox(height: 20.0),
            _createLastNameInput(bloc),
            SizedBox(height: 20.0),
            _createPasswordInput(bloc),
          ],
        ),
      ),
    );
  }

  Row _backgroundText() {
    return Row(
      children: <Widget>[
        Image.asset(
          "assets/logo.png",
          width: 40,
          height: 40,
        ),
        Text(
          "Bogotá Ambiental",
          style: TextStyle(
            fontFamily: "Poppins-Bold",
            fontSize: 20.0,
            letterSpacing: .6,
            fontWeight: FontWeight.bold
          )
        )
      ],
    );
  }

  BoxDecoration boxDecorationNone() {
    return BoxDecoration(
      gradient: LinearGradient(colors: [
        Colors.grey,
        Colors.grey
      ]),
      borderRadius: BorderRadius.circular(6.0)
    );
  }

  BoxDecoration boxDecorationButtonLogin() {
    return BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xFF17ead9),
        Color(0xFF6078ea)
      ]),
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF6078ea).withOpacity(.3),
          offset: Offset(0.0, 8.0),
          blurRadius: 8.0)
      ]
    );
  }

  Widget _newUSer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Ya tienes cuenta? ",
          style: TextStyle(fontFamily: "Poppins-Medium"),
        ),
        InkWell(
          onTap: () => Navigator.pushReplacementNamed(context, 'login'),
          child: Text(
            "Inicia sesión",
            style: TextStyle(
              color: Color(0xFF5d74e3),
              fontFamily: "Poppins-Bold"
            )
          ),
        )
      ],
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
      stream: bloc.forRegisterValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
          _validData = snapshot.hasData ? true : false;
        return InkWell(
          child: Container(
            width: 250,
            height: 55,
            decoration: _validData ? boxDecorationButtonLogin() : boxDecorationNone(),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: snapshot.hasData ? ()=> _createUser(bloc, context) : null,
                child: Center(
                  child: Text("Registrarse",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins-Bold",
                          fontSize: 18,
                          letterSpacing: 1.0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future _createUser(LoginBloc bloc, BuildContext context) async {
    onLoading(context, 'perfil');
    final response = await UserService().createRegister(
      bloc.email,
      bloc.name,
      bloc.lastName,
      bloc.password
      );
    if (response['status']) {
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, 'home');
    }else{
      Navigator.of(context).pop();
      showAlertExample(context, response['error']);
    }
  }
}