// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:student_management/ui/shared/theme/my_colors.dart';
// /// 通知的类别
// class DYXChannelKey {
//   static const basicChannel = "basic_channel"; // 基础通知
//   static const clock = "clock"; // 闹钟
// }
// /// 通知
// class DYXAwesomeNotificationsUtils {
//   /// 初始化(使用至少一 个本机图标和一个通道在main.dart上初始化插件)
//   static void init() {
//     AwesomeNotifications().initialize(
//         'resource://drawable/app_icon',
//         [
//           NotificationChannel(
//             icon: "resource://drawable/app_icon",
//             channelKey: DYXChannelKey.basicChannel,
//             channelName: '我是基本通知',
//             channelDescription: '基本测试通知通道',
//             defaultColor: DYXColors.blue,
//             soundSource: 'resource://raw/notifications1',
//             ledColor: Colors.white,
//
//           ),
//           NotificationChannel(
//             icon: "resource://drawable/schedule_icon",
//             channelKey: DYXChannelKey.clock,
//             channelName: '我是闹钟',
//             channelDescription: '闹钟测试通知通道',
//             defaultColor: DYXColors.blue,
//             soundSource: 'resource://raw/notifications2',
//             ledColor: Colors.white,
//             vibrationPattern: lowVibrationPattern
//           ),
//         ]
//     );
//   }
//
//   /// 发送通知
//   static void sendNotifications({@required int id, String title, String body}) {
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       } else {
//         AwesomeNotifications().createNotification(
//             content: NotificationContent(
//                 id: id,
//                 channelKey: DYXChannelKey.clock,
//                 title: title ?? '基本通知',
//                 body: body ?? '这是主题'
//             )
//         );
//       }
//     });
//   }
// }