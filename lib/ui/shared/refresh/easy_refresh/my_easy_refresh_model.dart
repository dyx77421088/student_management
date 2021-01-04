import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_management/ui/shared/progress/progress_utils.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';

/// 自定义的下拉刷新的模型
class DYXEasyRefreshModel extends StatefulWidget {
  /// 控制器
  final EasyRefreshController controller;

  /// 刷新回调(null为不开启刷新)
  final OnRefreshCallback onRefresh;

  /// 加载回调(null为不开启加载)
  final OnLoadCallback onLoad;

  /// 是否开启控制结束刷新
  final bool enableControlFinishRefresh;

  /// 是否开启控制结束加载
  final bool enableControlFinishLoad;

  /// 任务独立(刷新和加载状态独立)
  final bool taskIndependence;

  /// Header
  final Header header;
  final int headerIndex;

  /// Footer
  final Footer footer;

  /// 子组件构造器
  final EasyRefreshChildBuilder builder;

  /// 子组件
  final Widget child;

  /// 首次刷新
  final bool firstRefresh;

  /// 首次刷新组件
  /// 不设置时使用header
  final Widget firstRefreshWidget;

  /// Slivers集合
  final List<Widget> slivers;

  DYXEasyRefreshModel(
      {this.controller,
      this.onRefresh,
      this.onLoad,
      this.enableControlFinishRefresh,
      this.enableControlFinishLoad,
      this.taskIndependence,
      this.header,
      this.headerIndex,
      this.footer,
      this.builder,
      this.child,
      this.firstRefresh,
      this.firstRefreshWidget,
      this.slivers});

  @override
  _DYXEasyRefreshModelState createState() => _DYXEasyRefreshModelState();
}

class _DYXEasyRefreshModelState extends State<DYXEasyRefreshModel> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
        header: widget.header ?? BezierHourGlassHeader(backgroundColor: DYXColors.blue[50], color: DYXColors.blue),
        firstRefresh: true,
        firstRefreshWidget: buildFirstRefreshWidget(context),
        onRefresh: ()async{
          // await Future.delayed(Duration(seconds: 2));
          if(widget.onRefresh != null) {
            await widget.onRefresh();
          }
        },
        onLoad: widget.onLoad,
        footer: widget.footer ?? BezierBounceFooter(backgroundColor: DYXColors.blue[50], color: DYXColors.blue),
        slivers: widget.slivers
    );
  }

  /// 首次加载的界面
  Widget buildFirstRefreshWidget(BuildContext context) {
    return DYXProgressDialog.progressDialog(context: context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
          child: SizedBox(
            height: 200.0,
            width: 300.0,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    height: 50.0,
                    child: SpinKitFadingCube(
                      color: Theme.of(context).primaryColor,
                      size: 25.0,
                    ),
                  ),
                  Container(
                    child: Text("正在加载..."),
                  )
                ],
              ),
            ),
          )),
    );
  }
}


// /// 二楼视图
// class SecondFloorWidget extends StatefulWidget {
//   // Header连接通知器
//   final LinkHeaderNotifier linkNotifier;
//   // 二楼开启状态
//   final ValueNotifier<bool> secondFloorOpen;
//
//   const SecondFloorWidget(this.linkNotifier, this.secondFloorOpen, {Key key})
//       : super(key: key);
//
//   @override
//   SecondFloorWidgetState createState() {
//     return SecondFloorWidgetState();
//   }
// }
//
// class SecondFloorWidgetState extends State<SecondFloorWidget> {
//   // 触发二楼高度
//   final double _openSecondFloorExtent = 100.0;
//   // 指示器值
//   double _indicatorValue = 0.0;
//
//   // 二楼高度
//   double _secondFloor = 0.0;
//   // 显示展开收起动画
//   bool _toggleAnimation = false;
//   Duration _toggleAnimationDuration = Duration(milliseconds: 300);
//   // 二楼是否打开
//   bool _isOpen = false;
//
//   RefreshMode get _refreshState => widget.linkNotifier.refreshState;
//   double get _pulledExtent => widget.linkNotifier.pulledExtent;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.linkNotifier.addListener(onLinkNotify);
//   }
//
//   void onLinkNotify() {
//     setState(() {
//       if (_refreshState == RefreshMode.armed ||
//           _refreshState == RefreshMode.refresh) {
//         _indicatorValue = null;
//         // 判断是否到展开二楼
//         if (widget.secondFloorOpen.value && !_toggleAnimation) {
//           _isOpen = true;
//           _secondFloor = MediaQuery.of(context).size.height;
//           _toggleAnimation = true;
//           Future.delayed(_toggleAnimationDuration, () {
//             if (mounted) {
//               setState(() {
//                 _toggleAnimation = false;
//               });
//             }
//           });
//         }
//       } else if (_refreshState == RefreshMode.refreshed ||
//           _refreshState == RefreshMode.done) {
//         _indicatorValue = 1.0;
//       } else {
//         if (_refreshState == RefreshMode.inactive) {
//           _indicatorValue = 0.0;
//           _toggleAnimation = true;
//           Future.delayed(_toggleAnimationDuration, () {
//             if (mounted) {
//               setState(() {
//                 _toggleAnimation = false;
//               });
//             }
//           });
//         } else {
//           double indicatorValue = _pulledExtent / 70.0 * 0.8;
//           _indicatorValue = indicatorValue < 0.8 ? indicatorValue : 0.8;
//           // 判断是否到达打开二楼高度
//           if (_refreshState == RefreshMode.drag) {
//             if (_pulledExtent >= _openSecondFloorExtent) {
//               widget.secondFloorOpen.value = true;
//             } else {
//               widget.secondFloorOpen.value = false;
//             }
//           }
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         if (_isOpen) {
//           setState(() {
//             _isOpen = false;
//             _toggleAnimation = true;
//             Future.delayed(_toggleAnimationDuration, () {
//               if (mounted) {
//                 setState(() {
//                   _toggleAnimation = false;
//                 });
//               }
//             });
//           });
//           return Future.value(false);
//         }
//         return Future.value(true);
//       },
//       child: AnimatedContainer(
//         height: _isOpen
//             ? _secondFloor
//             : _refreshState == RefreshMode.inactive
//             ? 0.0
//             : _pulledExtent,
//         color: Colors.white,
//         duration: _toggleAnimation
//             ? _toggleAnimationDuration
//             : Duration(milliseconds: 1),
//         child: Stack(
//           children: <Widget>[
//             Positioned(
//               bottom: 0.0,
//               left: 0.0,
//               right: 0.0,
//               child: Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: double.infinity,
//                 child: Image.asset(
//                   'assets/images/xzdl.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             _isOpen
//                 ? AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0.0,
//             )
//                 : Container(),
//             Positioned(
//               bottom: 0.0,
//               left: 0.0,
//               right: 0.0,
//               child: AnimatedCrossFade(
//                 firstChild: Center(
//                   child: Container(
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.only(
//                       bottom: 20.0,
//                       top: 10.0,
//                     ),
//                     width: 24.0,
//                     height: 24.0,
//                     child: Offstage(
//                       offstage: widget.secondFloorOpen.value,
//                       child: CircularProgressIndicator(
//                         value: _indicatorValue,
//                         valueColor: AlwaysStoppedAnimation(Colors.blue),
//                         strokeWidth: 2.4,
//                       ),
//                     ),
//                   ),
//                 ),
//                 secondChild: Center(
//                   child: Container(
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.only(
//                       bottom: 20.0,
//                       top: 10.0,
//                     ),
//                     child: Offstage(
//                       offstage: !widget.secondFloorOpen.value,
//                       child: Text(
//                         "欢迎来到二楼",
//                         style: TextStyle(fontSize: 18.0, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 crossFadeState: widget.secondFloorOpen.value
//                     ? CrossFadeState.showSecond
//                     : CrossFadeState.showFirst,
//                 duration: Duration(milliseconds: 300),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }