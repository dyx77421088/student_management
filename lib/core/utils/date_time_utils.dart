import 'package:date_format/date_format.dart';

class DYXDateTimeUtils {
  /// 时间戳（秒）转换成时间，自定义格式
  static String timeStampFormatToStr(int timeStamp, List<String> format) {
    return formatDate(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000), format);
  }

  /// 时间戳（秒）转换成时间
  static String timeStampToStr(int timeStamp) {
    return timeStampFormatToStr(timeStamp, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
  }

  /// 获得当前的时间戳(秒)
  static int getNowTimeStamp() {
    return (DateTime.now().millisecondsSinceEpoch / 1000).round();
  }

  /// 获得时间戳
  static int getTimeStamp(DateTime dateTime) {
    return (dateTime.millisecondsSinceEpoch / 1000).round();
  }
}
