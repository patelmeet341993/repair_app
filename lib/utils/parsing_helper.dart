// For Parsing Dynamic Values To Specific Type

import 'package:intl/intl.dart';


class ParsingHelper {
  static String parseStringMethod(dynamic value, {String defaultValue = ""}) {
    return value?.toString() ?? defaultValue;
  }

  static int parseIntMethod(dynamic value, {int defaultValue = 0}) {
    if(value == null) {
      return defaultValue;
    }
    else if(value is int) {
      return value;
    }
    else if(value is double) {
      return value.toInt();
    }
    else if(value is String) {
      return int.tryParse(value) ?? defaultValue;
    }
    else {
      return defaultValue;
    }
  }

  static double parseDoubleMethod(dynamic value, {double defaultValue = 0}) {
    if(value == null) {
      return defaultValue;
    }
    else if(value is int) {
      return value.toDouble();
    }
    else if(value is double) {
      return value;
    }
    else if(value is String) {
      return double.tryParse(value) ?? defaultValue;
    }
    else {
      return defaultValue;
    }
  }

  static bool parseBoolMethod(dynamic value, {bool defaultValue = false}) {
    if(value == null) {
      return defaultValue;
    }
    else if(value is bool) {
      return value;
    }
    else if(value is String) {
      if(value.toLowerCase() == "true") {
        return true;
      }
      else if(value.toLowerCase() == "false") {
        return false;
      }
      else {
        return defaultValue;
      }
    }
    else {
      return defaultValue;
    }
  }

  static List<T2> parseListMethod<T1, T2>(dynamic value, {List<T2>? defaultValue}) {
    defaultValue ??= <T2>[];

    if(value == null) {
      return defaultValue;
    }
    else if(value is List<T1>) {
      try {
        List<T2> newList = List.castFrom<T1, T2>(value);
        return newList;
      }
      catch(e) {
        return defaultValue;
      }
    }
    else if(value is List<dynamic>) {
      try {
        List<T2> newList = List.castFrom<dynamic, T2>(value);
        return newList;
      }
      catch(e) {
        return defaultValue;
      }
    }
    else {
      return defaultValue;
    }
  }

  static Map<K2, V2> parseMapMethod<K1, V1, K2, V2>(dynamic value, {Map<K2, V2>? defaultValue}) {
    defaultValue ??= <K2, V2>{};

    if(value == null) {
      return defaultValue;
    }
    else if(value is Map) {
      try {
        Map<K1, V1> newMap = Map.castFrom<dynamic, dynamic, K1, V1>(value);
        Map<K2, V2> newMap2 = Map.castFrom<K1, V1, K2, V2>(newMap);
        return newMap2;
      }
      catch(e) {
        return defaultValue;
      }
    }
    else {
      return defaultValue;
    }
  }

  // static DateTime? parseDateTimeMethod(dynamic value, {DateTime? defaultValue, String dateFormat = ""}) {
  //   if(value is DateTime) {
  //     return value;
  //   }
  //   else if(value is Timestamp) {
  //     return value.toDate();
  //   }
  //   else if(value is String) {
  //     DateTime? dateTime;
  //     print("DateTime Value:$value");
  //     if(dateFormat.isNotEmpty) {
  //       try {
  //         dateTime = DateFormat(dateFormat).parse(value);
  //       }
  //       catch(e, s) {
  //         print("Error in Converting from String to DateTime with Format '$dateFormat':$e");
  //         print(s);
  //       }
  //     }
  //
  //     if(dateTime == null) {
  //       int? intValue = int.tryParse(value);
  //       if(intValue != null) {
  //         try {
  //           dateTime = DateTime.fromMillisecondsSinceEpoch(intValue);
  //         }
  //         catch(e, s) {
  //           print("Error in Converting from String(int) to DateTime:$e");
  //           print(s);
  //         }
  //       }
  //     }
  //
  //     dateTime ??= DateTime.tryParse(value);
  //
  //     return dateTime ?? defaultValue;
  //   }
  //   else if(value is int) {
  //     DateTime? dateTime;
  //
  //     try {
  //       dateTime = DateTime.fromMillisecondsSinceEpoch(value);
  //     }
  //     catch(e, s) {
  //       print("Error in Converting from int to DateTime:$e");
  //       print(s);
  //     }
  //
  //     return dateTime ?? defaultValue;
  //   }
  //   else {
  //     return defaultValue;
  //   }
  // }

  static List<Map<K, V>> parseMapsListMethod<K, V>(dynamic value, {List<Map<K, V>>? defaultValue, bool isEmptyMapAllowed = false}) {
    defaultValue ??= <Map<K, V>>[];

    List list = ParsingHelper.parseListMethod(value);
    List<Map<K, V>> mapsList = <Map<K, V>>[];

    for (dynamic value in list) {
      Map<K, V> map = ParsingHelper.parseMapMethod<dynamic, dynamic, K, V>(value);

      if(isEmptyMapAllowed || map.isNotEmpty) {
        mapsList.add(map);
      }
    }

    return mapsList;
  }

  static String? parseStringNullableMethod(dynamic value, {String? defaultValue}) {
    return value?.toString() ?? defaultValue;
  }

  static int? parseIntNullableMethod(dynamic value, {int? defaultValue}) {
    if(value == null) {
      return defaultValue;
    }
    else if(value is int) {
      return value;
    }
    else if(value is double) {
      return value.toInt();
    }
    else if(value is String) {
      return int.tryParse(value) ?? defaultValue;
    }
    else {
      return defaultValue;
    }
  }

  static double? parseDoubleNullableMethod(dynamic value, {double? defaultValue}) {
    if(value == null) {
      return defaultValue;
    }
    else if(value is int) {
      return value.toDouble();
    }
    else if(value is double) {
      return value;
    }
    else if(value is String) {
      return double.tryParse(value) ?? defaultValue;
    }
    else {
      return defaultValue;
    }
  }

  static bool? parseBoolNullableMethod(dynamic value, {bool? defaultValue}) {
    if(value == null) {
      return defaultValue;
    }
    else if(value is bool) {
      return value;
    }
    else if(value is String) {
      if(value.toLowerCase() == "true") {
        return true;
      }
      else if(value.toLowerCase() == "false") {
        return false;
      }
      else {
        return defaultValue;
      }
    }
    else {
      return defaultValue;
    }
  }
}