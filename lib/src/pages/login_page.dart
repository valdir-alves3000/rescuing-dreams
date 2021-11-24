import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rescuing_dreams/src/blocs/auth_bloc.dart';
import 'package:rescuing_dreams/src/resources/dialog/loading_dialog.dart';
import 'package:rescuing_dreams/src/resources/dialog/msg_dialog.dart';

class LoginPage extends StatefulWidget {
  static const String idPage = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthBloc authBloc = new AuthBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 1.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 6),
                child: Text(
                  "Rescuing Dreams!",
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              Text(
                "Faça login e peça seu resgate.",
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: StreamBuilder(
                    stream: authBloc.emailStream,
                    builder: (context, snapshot) => TextField(
                          controller: _emailController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
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
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: StreamBuilder(
                  stream: authBloc.passStream,
                  builder: (context, snapshot) => TextField(
                    controller: _passController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: "Password",
                      prefixIcon: Container(
                          width: 50,
                          child: Image.asset("assets/images/ic_lock.png")),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onLongPress: null,
                    child: Container(
                      height: 50,
                      child: Center(
                          child: Text(
                        "Login",
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
                    onPressed: _onLoginClick,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RichText(
                  text: TextSpan(
                      text: "Não tem conta? ",
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/register');
                              },
                            text: "Registre-se agora",
                            style: TextStyle(
                                color: Colors.indigo[300], fontSize: 16))
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginClick() {
    String email = _emailController.text;
    String pass = _passController.text;

    var isValid = authBloc.isValid(
        'login', _emailController.text, _passController.text, 'login');

    if (isValid) {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      authBloc.signIn(email, pass, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pushNamed(context, '/mapPage');
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign In", msg);
      });
    }
  }
}
