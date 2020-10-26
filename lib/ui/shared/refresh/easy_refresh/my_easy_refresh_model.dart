import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        footer: widget.footer ?? BezierBounceFooter(backgroundColor: DYXColors.blue[50], color: DYXColors.blue),
        firstRefresh: true,
        firstRefreshWidget: buildFirstRefreshWidget(context),
        onRefresh: widget.onRefresh ?? ()async{await Future.delayed(Duration(seconds: 2));},
        onLoad: widget.onLoad ?? ()async{await Future.delayed(Duration(seconds: 2));},
        slivers: widget.slivers
    );
  }
  
  /// 首次加载的界面
  Widget buildFirstRefreshWidget(BuildContext context) {
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
