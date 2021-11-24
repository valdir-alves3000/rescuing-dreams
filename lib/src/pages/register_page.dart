import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rescuing_dreams/src/blocs/auth_bloc.dart';
import 'package:rescuing_dreams/src/resources/dialog/loading_dialog.dart';
import 'package:rescuing_dreams/src/resources/dialog/msg_dialog.dart';

class RegisterPage extends StatefulWidget {
  static const String idPage = '/register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthBloc authBloc = new AuthBloc();

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Image(
                image: AssetImage("assets/images/logo.png"),
                width: 390.0,
                height: 200.0,
                alignment: Alignment.center,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  "Bem vindo a bordo!",
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: StreamBuilder(
                      stream: authBloc.nameStream,
                      builder: (context, snapshot) => TextField(
                            controller: _nameController,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            decoration: InputDecoration(
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : null,
                                labelText: "Name",
                                prefixIcon: Container(
                                    width: 50,
                                    child: Image.asset(
                                        "assets/images/ic_user.png")),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCED0D2), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)))),
                          ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: StreamBuilder(
                    stream: authBloc.phoneStream,
                    builder: (context, snapshot) => TextField(
                          controller: _phoneController,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          decoration: InputDecoration(
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : null,
                              labelText: "Phone Number",
                              prefixIcon: Container(
                                  width: 50,
                                  child: Image.asset(
                                      "assets/images/ic_phone.png")),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                        )),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: StreamBuilder(
                      stream: authBloc.emailStream,
                      builder: (context, snapshot) => TextField(
                            controller: _emailController,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            decoration: InputDecoration(
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : null,
                                labelText: "Email",
                                prefixIcon: Container(
                                    width: 50,
                                    child:
                                        Image.asset("assets/images/email.png")),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCED0D2), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)))),
                          ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: StreamBuilder(
                    stream: authBloc.passStream,
                    builder: (context, snapshot) => TextField(
                          controller: _passController,
                          obscureText: true,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          decoration: InputDecoration(
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : null,
                              labelText: "Password",
                              prefixIcon: Container(
                                  width: 50,
                                  child:
                                      Image.asset("assets/images/ic_lock.png")),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onLongPress: null,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child: Text(
                        "Sign Up",
                        style:
                            TextStyle(fontFamily: "Brand Bold", fontSize: 18),
                      )),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo[300],
                        elevation: 3,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(24)),
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                    onPressed: _onSignUpClicked,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: RichText(
                  text: TextSpan(
                      text: "Já tenho usuário. ",
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/login');
                              },
                            text: "Logar agora",
                            style: TextStyle(
                                color: Colors.indigo[300], fontSize: 16))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSignUpClicked() {
    var isValid = authBloc.isValid(_nameController.text, _emailController.text,
        _passController.text, _phoneController.text);

    if (isValid) {
      // create user
      // loading dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc.signUp(_nameController.text, _emailController.text,
          _passController.text, _phoneController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pushNamed(context, '/login');
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign Up", msg);
        // show msg dialog
      });
    }
  }
}
