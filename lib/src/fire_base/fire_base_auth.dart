import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  void signUp(String name, String email, String pass, String phone,
      Function onSuccess, Function(String) onRegisterError) async {
    final firebaseUser = (await _fireBaseAuth
            .createUserWithEmailAndPassword(
      email: email,
      password: pass,
    )
            .catchError((err) {
      _onSignUpErr(err.code, onRegisterError);
    }))
        .user;

    if (firebaseUser != null) {
      _createUser(firebaseUser.uid, email, pass, name, phone, onSuccess,
          onRegisterError);
      onSuccess();
    }
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
        print('email: '+email+
        'n\ password: '+ pass);
    _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onSignInError("Usuário/senha incorreto!");
    });
  }

  _createUser(String userId, String email, String pass, String name,
      String phone, Function onSuccess, Function(String) onRegisterError) {
    var user = Map<String, String>();
    user["name"] = name;
    user["email"] = email;
    user["phone"] = phone;
    user["password"] = pass;

    var userRef = FirebaseDatabase.instance.reference().child("users");
    Map userDataMap = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": pass,
    };

    userRef.child(userId).set(userDataMap);
  }

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "invalid-email":
      case "invalid_credential":
        onRegisterError("Invalid email");
        break;
      case "email-already-in-use":
        onRegisterError("Email já existe!");
        break;
      case "weak_password":
        onRegisterError("A senha não é forte o suficiente!");
        break;
      default:
        onRegisterError("Falha no registro, tente novamente!" + code);
        break;
    }
  }

  Future<void> signOut() async {
    print("signOut");
    return _fireBaseAuth.signOut();
  }
}
