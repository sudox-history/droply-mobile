import 'package:droply/constants.dart';

String shortenBytes(int bytes) {
  final int absB = bytes == AppOther.minInt ? AppOther.maxInt : bytes.abs();

  if (absB < 1024) {
    return "$bytes B";
  }

  int value = absB;
  const String ci = "KMGTPE";
  int index = 0;

  for (int i = 40; i >= 0 && absB > 0xFFFCCCCCCCCCCCC >> i; i -= 10) {
    value >>= 10;
    index++;
  }

  value *= bytes.sign;

  return "${(value / 1024.0).toStringAsFixed(2)} ${ci[index]}b";
}
