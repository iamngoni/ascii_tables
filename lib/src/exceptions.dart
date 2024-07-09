part of ascii_tables;

class WrongArgumentType implements Exception {
  const WrongArgumentType([this.msg]);
  final String? msg;

  String toString() => msg ?? 'Wrong Argument Type';
}
