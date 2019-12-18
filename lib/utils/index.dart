import 'package:hive/hive.dart';

class Utils {
  static unicomBox() async {
    var box = await Hive.openBox('unicomBox');
    return box;
  }
}
