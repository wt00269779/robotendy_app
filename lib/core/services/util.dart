import 'dart:io';

class Util {
  static DateTime covertGwtToDateTime(String date) {
    return HttpDate.parse(date);
  }
}