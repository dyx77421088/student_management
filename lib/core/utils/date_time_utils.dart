import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';

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
  static int getNowTimeStamp({DateTime now}) {
    return ((now??DateTime.now()).millisecondsSinceEpoch / 1000).round();
  }

  /// 获得当前的日期
  static String getNowDate({int timeStamp}) {
    return timeStampFormatToStr(timeStamp??getNowTimeStamp(), [yyyy, '-', mm, '-', dd]);
  }

  /// 获得当前的时间
  static String getNowTime({int timeStamp}) {
    return timeStampFormatToStr(timeStamp??getNowTimeStamp(), [HH, ':', nn]);
  }
  
  /// dateTime 转换成字符串（日期）
  static String dateTimeToDateStr(
      DateTime dateTime,
      {List<String> format = const [yyyy, '-', mm, '-', dd]}
    ) {
    return formatDate(dateTime, format);
  }

  /// dateTime 转换成字符串 （时间）
  static String dateTimeToTimeStr(
      DateTime dateTime, 
      {List<String> format = const [HH, ':', nn]}
    ) {
    return formatDate(dateTime, format);
  }

  /// 获得时间戳
  static int getTimeStamp(DateTime dateTime) {
    return (dateTime.millisecondsSinceEpoch / 1000).round();
  }

  /// 向下取整获得时间 (返回当前时间的 yyyy年hh月dd日 0:0:0) 传秒
  static int floorTime({int timeStamp}) {
    DateTime now = timeStamp != null ? DateTime.fromMillisecondsSinceEpoch(timeStamp*1000)
        : DateTime.now();
    return getTimeStamp(DateTime(now.year, now.month, now.day));
  }
  /// 向上取整获得当前时间 (返回当前时间的 yyyy年hh月dd+1日 0:0:0)
  static int ceilTime({int timeStamp}) {
    DateTime now = timeStamp != null ? DateTime.fromMillisecondsSinceEpoch(timeStamp*1000)
        : DateTime.now();
    return getTimeStamp(DateTime(now.year, now.month, now.day+1));
  }

  static int toTime({int time}) {
    DateTime t = time == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(time*1000);
    DateTime t1 = DateTime(0, 0, 0, t.hour, t.minute, t.second, t.millisecond, t.microsecond);
    return t1.millisecondsSinceEpoch;
  }

  /// 判断当前时间是否在一个范围内
  static bool onTime({@required int startTime, @required int endTime}) {
    int now = toTime();
    int start = toTime(time: startTime);
    int end = toTime(time: endTime);
    return start <= now && now <= end;
  }

  /// 今天在这周里面吗
  static bool onWeek(List<int> week) {
    int weekday = DateTime.now().weekday;
    print(weekday);
    return week.contains(weekday);
  }

  /// 日期和时间相结合返回时间戳(秒)
  static int dateTimeToTimeStamp({@required DateTime date, @required DateTime time}) {
    DateTime now = new DateTime(date.year, date.month, date.day, time.hour, time.minute, time.second);
    return now.millisecondsSinceEpoch ~/ 1000;
  }

  /// 日期和时间相结合返回时间(yyyy年MM月dd日 HH:mm)
  static String dateTimeToDate({@required int timeStamp}) {
    return timeStampFormatToStr(
      timeStamp,
      [yyyy, '年', mm, '月', dd, '日 ', HH, '时', nn, '分']
    );
  }

  /// 时间戳转换成dateTime类型（秒）
  static DateTime timeStampToDateTime({@required int timeStamp}) =>
      DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
}
