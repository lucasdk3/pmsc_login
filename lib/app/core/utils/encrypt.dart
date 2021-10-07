// coverage:ignore-file
class Encrypt {
  Encrypt({this.cryptoKey = 'PMSC'});

  final String cryptoKey;

  String to(String data) {
    var charCount = data.length;
    var encrypted = [];
    var kp = 0;
    var kl = cryptoKey.length - 1;

    for (var i = 0; i < charCount; i++) {
      var other = data[i].codeUnits[0] ^ cryptoKey[kp].codeUnits[0];
      encrypted.insert(i, other);
      kp = (kp < kl) ? (++kp) : (0);
    }
    return dataToString(encrypted);
  }

  String from(String? data) {
    return data == null ? '' : to(data);
  }

  String dataToString(data) {
    var s = '';
    for (var i = 0; i < data.length; i++) {
      s += String.fromCharCode(data[i]);
    }
    return s;
  }
}
