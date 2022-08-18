import 'dart:math';

class Generate {
  final upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final lower = 'abcdefghijklmnopqrstuvwxyz';
  final numbers = '0123456789';
  final symbols = "!@#\$%^&*(){}[]=<>/,.";

  Random random = Random();
  String generateUpper() => upper[random.nextInt(upper.length)];

  String generateLower() => lower[random.nextInt(lower.length)];

  String generateNumber() => random.nextInt(10).toString();

  String generateSymbol() => symbols[random.nextInt(symbols.length)];

  String generatePassword() =>
      '${generateUpper()}${generateLower()}${generateNumber()}${generateSymbol()}';
}
