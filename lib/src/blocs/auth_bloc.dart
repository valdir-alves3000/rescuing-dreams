import 'dart:async';
import 'package:rescuing_dreams/src/fire_base/fire_base_auth.dart';

class AuthBloc {
  var _firAuth = FirAuth();

  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _phoneController = new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get phoneStream => _phoneController.stream;

  bool isValid(String name, String email, String pass, String phone) {
    if (name.length < 3) {
      _nameController.sink.addError(("Insira um nome"));
      return false;
    }
    _nameController.sink.add("");
    if (phone.length == 0) {
      _phoneController.sink.addError("Digite seu número de telefone");
      return false;
    }
    _phoneController.sink.add("");
    if (email.length == 0 || !email.contains("@")) {
      _emailController.sink.addError("Endereço de email inválido!");
      return false;
    }
    _emailController.sink.add("");

    if (pass.length < 6) {
      _passController.sink.addError("A senha deve ter mais de 5 caracteres");
      return false;
    }
    _passController.sink.add("");

    return true;
  }

  void signUp(String name, String email, String pass, String phone,
      Function onSuccess, Function(String) onError) {
    _firAuth.signUp(name, email, pass, phone, onSuccess, onError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _phoneController.close();
  }
}
