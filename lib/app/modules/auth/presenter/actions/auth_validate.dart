class AuthValidate {
  static String? call(String? registration, String? password) {
    if (registration == null || registration.length != 8) {
      return 'Mátricula inválida';
    } else if (password == null || password.length <= 6) {
      return 'Senha inválida';
    } else {
      return null;
    }
  }
}
