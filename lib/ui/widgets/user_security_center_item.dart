import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/icon/icons.dart';

/// 左边图片的类型
enum DYXUserSecurityCenterItemLeadingType {
  checkOk,
  warning
}
class DYXUserSecurityCenterItem extends StatelessWidget {
  final DYXUserSecurityCenterItemLeadingType leadingType;
  /// 一级标题
  final Widget title;
  /// 二级标题
  final Widget subtitle;
  /// 显示右边的图标
  final bool showTrailing;
  /// 点击监听
  final Function onTap;


  DYXUserSecurityCenterItem({
    this.leadingType = DYXUserSecurityCenterItemLeadingType.warning,
    this.title,
    this.subtitle,
    this.showTrailing = true,
    this.onTap
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    child: ListTile(
      title: title,
      subtitle: subtitle,
      leading: getIcon(),
      trailing: showTrailing ? Icon(DYXIcons.chevron_right) : null,
    ),
    onTap: onTap,
  );

  /// 根据传过来的类型返回icon
  Icon getIcon() {
    if(leadingType == DYXUserSecurityCenterItemLeadingType.checkOk) {
      return Icon(DYXIcons.check_ok, color: Color.fromARGB(255, 72, 189, 134),);
    } else if(leadingType == DYXUserSecurityCenterItemLeadingType.warning) {
      return Icon(DYXIcons.warning, color: Color.fromARGB(255, 240, 169, 87),);
    }
    return Icon(DYXIcons.warning, color: Color.fromARGB(255, 240, 169, 87),);
  }
}
