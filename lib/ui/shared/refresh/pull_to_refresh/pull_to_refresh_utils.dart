import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';

/// 刷新工具类
class DYXPullToRefreshUtils {
  // RefreshController _refreshController = RefreshController(initialRefresh: false);
  static Widget smartRefresher ({
    RefreshController controller, // 控制器
    VoidCallback onRefresh, // 刷新
    VoidCallback onLoading, // 加载
    bool enablePullDown = true, // 启用下拉菜单
    bool enablePullUp = true, // 启用上拉菜单
    Widget child, // 孩子组件
    Widget footer, // 腿部
  }) => SmartRefresher (
    controller: controller,
    onRefresh: onRefresh,
    onLoading: onLoading,
    enablePullDown: enablePullDown,
    enablePullUp: enablePullUp,
    child: child,
    footer: footer,
  );
}