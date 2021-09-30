import 'package:fluttertoast/fluttertoast.dart';

class AuthValidate {
  static bool call(String? auth, String? password) {
    if (auth == null || auth.length != 8) {
      Fluttertoast.showToast(msg: 'Mátricula inválida');
      return false;
    } else if (password == null) {
      Fluttertoast.showToast(msg: 'Senha inválida');
      return false;
    } else {
      return true;
    }
  }
}
