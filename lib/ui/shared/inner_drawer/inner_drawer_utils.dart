import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter/material.dart';

class DYXInnerDrawerUtils {
  GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();
  void cs(BuildContext context,) {
    buildInnerDrawer(context, scaffold: null);
    _innerDrawerKey.currentState.open();
  }
  static InnerDrawer buildInnerDrawer(BuildContext context, {
    GlobalKey key,
    Widget leftChild, // 左边的抽屉（左边或右边必须有一个）
    Widget rightChild, // 右边的抽屉（左边或右边必须有一个
    @required Widget scaffold, // 中间的组件（通用的脚手架）
    IDOffset offset = const IDOffset.horizontal(0.4), // 内部抽屉偏移宽度
    IDOffset scale = const IDOffset.horizontal(1), // scaffold（脚手架）缩放
    bool proportionalChildArea = true, // 如果为true，则根据所选的偏移量动态设置宽度，否则将使宽度保持在屏幕的100％
    double borderRadius = 0, // 设置scaffold（脚手架）的边框
    bool onTapClose = false, // 点击scaffold（脚手架）将其关闭
    bool tapScaffoldEnabled = false, // 即使在打开时也可以点击scaffold（脚手架）
    bool swipe = true, // 激活或停用滑动(左滑或右滑打开抽屉)
    bool swipeChild = false, // 激活或停用swipeChild
    Duration duration, // 动画的持续时间
    double velocity = 1, // 使用打开/关闭方法时，可以设置打开和关闭速度
    List<BoxShadow> boxShadow, // 	棚架的BoxShadow打开
    Color colorTransitionChild, // 滑动时更改child的背景颜色
    Color colorTransitionScaffold, // 滑动时更改scaffold（脚手架）的背景颜色
    InnerDrawerAnimation leftAnimationType = InnerDrawerAnimation.static, // left动画（静态/线性/二次）
    InnerDrawerAnimation rightAnimationType = InnerDrawerAnimation.static, // right动画（静态/线性/二次）
    Decoration backgroundDecoration, // 管理主要背景装饰的
    InnerDrawerCallback innerDrawerCallback, // 打开或关闭InnerDrawer时调用的可选回调
    InnerDragUpdateCallback onDragUpdate // 当指针与屏幕接触并向右或向左移动时 回调的方法
}) {
    return InnerDrawer(
      key: key,
      leftChild: leftChild,
      rightChild : rightChild,
      scaffold: scaffold,
      offset: offset,
      scale: scale,
      proportionalChildArea: proportionalChildArea,
      borderRadius: borderRadius,
      onTapClose: onTapClose,
      tapScaffoldEnabled: tapScaffoldEnabled,
      swipe: swipe,
      swipeChild: swipeChild,
      duration: duration,
      velocity: velocity,
      boxShadow: boxShadow,
      colorTransitionChild: colorTransitionChild,
      colorTransitionScaffold: colorTransitionScaffold,
      leftAnimationType: leftAnimationType,
      rightAnimationType: rightAnimationType,
      backgroundDecoration: backgroundDecoration,
      innerDrawerCallback: innerDrawerCallback,
    );
  }
}