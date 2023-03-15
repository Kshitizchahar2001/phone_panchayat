// ignore_for_file: file_names

import 'dart:math';

/// Function that converts large numbers to humanized form \
/// Returns same if number < 1000 \
/// Else Returns rounded number with appropriate suffix \
/// Eg: \
/// \
/// 234        ->   234 \
/// 1000       ->   1K \
/// 1234       ->   1.2K  \
/// 12340      ->   12K   \
/// 123400     ->   123K    \
/// 1234000    ->   1.2M    \
/// ....
String humanizeInt(int n) {
  if (n == null) return '0';

  // < 1000
  if (n < 1000) return n.toString();

  // 1,000s
  if (n < 10000) {
    final s = (n / 1000).toStringAsFixed(1);
    if (s[s.length - 1] == '0') {
      return s.substring(0, s.length - 2) + "K";
    }
    return s + "K";
  }
  if (n < 1000000) {
    return (n / 1000).toStringAsFixed(0) + "K";
  }

  // 1,000,000s
  if (n < 10000000) {
    final s = (n / pow(1000, 2)).toStringAsFixed(1);
    if (s[s.length - 1] == '0') {
      return s.substring(0, s.length - 2) + "M";
    }
    return s + "M";
  }
  if (n < 1000000000) {
    return (n / pow(1000, 2)).toStringAsFixed(0) + "M";
  }

  // 1,000,000,000s
  if (n < 10000000000) {
    final s = (n / pow(1000, 3)).toStringAsFixed(1);
    if (s[s.length - 1] == '0') {
      return s.substring(0, s.length - 2) + "B";
    }
    return s + "B";
  }
  if (n < 1000000000000) {
    return (n / pow(1000, 3)).toStringAsFixed(0) + "B";
  }

  // 1,000,000,000,000s
  if (n < 10000000000000) {
    final s = (n / pow(1000, 4)).toStringAsFixed(1);
    if (s[s.length - 1] == '0') {
      return s.substring(0, s.length - 2) + "T";
    }
    return s + "T";
  }
  if (n < 1000000000000000) {
    return (n / pow(1000, 4)).toStringAsFixed(0) + "T";
  }

  // >= 1,000,000,000,000,000s

  return (n / pow(1000, 5)).toStringAsFixed(0) + "Q";
}

/// Function that converts large numbers to humanized form \
/// Returns same if number < 1000 \
/// Else Returns rounded number with appropriate suffix in Indian numbering system (Thousand, Lakhs and Crores)\
/// Eg: \
/// \
/// 234        ->   234 \
/// 1000       ->   1K \
/// 1234       ->   1.2K  \
/// 12340      ->   12K   \
/// 1234000    ->   12L    \
/// 12340000   ->   1.2Cr
/// ....
String humanizeIntInd(int n) {
  if (n == null) return '0';
  // < 1000
  if (n < 1000) return n.toString();

  // 1,000s
  if (n < 10000) {
    final s = (n / 1000).toStringAsFixed(1);
    if (s[s.length - 1] == '0') {
      return s.substring(0, s.length - 2) + "K";
    }
    return s + "K";
  }
  if (n < 100000) {
    return (n / 1000).toStringAsFixed(0) + "K";
  }

  // 1,00,000s
  if (n < 1000000) {
    final s = (n / 100000).toStringAsFixed(1);
    if (s[s.length - 1] == '0') {
      return s.substring(0, s.length - 2) + "L";
    }
    return s + "L";
  }
  if (n < 10000000) {
    return (n / 100000).toStringAsFixed(0) + "L";
  }

  // 1,00,00,000s
  if (n < 100000000) {
    final s = (n / 10000000).toStringAsFixed(1);
    if (s[s.length - 1] == '0') {
      return s.substring(0, s.length - 2) + "Cr";
    }
    return s + "Cr";
  }
  if (n < 1000000000) {
    return (n / 10000000).toStringAsFixed(0) + "Cr";
  }

  // >= 100,00,00,000s

  return (n / 10000000).toStringAsFixed(0) + "Cr";
}
