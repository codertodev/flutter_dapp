import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:rational/rational.dart';
import 'package:web3dart/web3dart.dart';

class ConvertUtils {
  static BigInt toBigInt(double value, int decimal) {
    return BigInt.from(value * pow(10, decimal));
  }

  static Rational toDouble(BigInt value, int decimal) {
    return Decimal.fromBigInt(value) / Decimal.fromInt(pow(10, decimal));
  }

  static String convertToString(BigInt value, int decimal) {
    return (Decimal.fromBigInt(value) / Decimal.fromInt(pow(10, decimal))).toDecimal().toStringAsFixed(20);
  }
}
