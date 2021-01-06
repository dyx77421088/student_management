import 'package:flutter/material.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/model/work/work_single.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/ui/pages/personal/single_work_look/single_work_look.dart';
import 'package:student_management/ui/shared/image/image_network.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
typedef void DYXWorkItemFunction<T>(T str);
class DYXWorkItem extends StatelessWidget {
  final DYXWorkSingleModel regularItem;
  final bool canUpdate;
  final DYXWorkItemFunction hui; // 回调

  DYXWorkItem({this.regularItem, this.canUpdate = false, this.hui});

  @override
  Widget build(BuildContext context) {
    return buildItem(regularItem: regularItem, context: context);
  }

  /// item
  Widget buildItem({
    @required DYXWorkSingleModel regularItem,
    @required BuildContext context,
  }) => GestureDetector(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5.px, horizontal: 10.px),
      child: Stack(
        children: [

          Card(
            // decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.px))),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
            // color: Colors.red,
            elevation: 5.px,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildAvatarImg(regularItem.userDetails.avatar),
                      SizedBox(height: 7.px,),
                      Text(regularItem.userDetails.name),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.only(left: 20.px),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(regularItem.title),
                        SizedBox(height: 20.px,),
                        Text(regularItem.content, maxLines: 1, overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                ),

              ],

            ),
          ),
          Positioned(
            top: 15.px,
            right: 10.px,
            child: Container(
              width: 100.px,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5.px, horizontal: 10.px),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(6.px)
              ),
              child: Text(DYXDateTimeUtils.getNowDate(timeStamp:regularItem.releaseTime),
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),),
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      Navigator.pushNamed(context,
          canUpdate? DYXSingleWorkLookPage.routeNameCanUpdate:DYXSingleWorkLookPage.routeName,
          arguments: regularItem
      ).then((value) { // 回调
        if(value != null) {
          print(value);
          // DYXToast.showToast("删除了$value");
          hui(value);
        }
      });
    },
  );

  /// 头像
  Widget buildAvatarImg(String avatar) {
    if (avatar != null) {
      return Container(
          width: 50.px,
          height: 50.px,
          margin: EdgeInsets.only(left: 10.px),
          child: DYXImageNetwork.avatarNetwork(url: avatar)
      );
    }
    return Container(
      width: 50.px,
      height: 50.px,
      margin: EdgeInsets.only(left: 10.px),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage("assets/images/avatar_unlogin.png"),
        backgroundColor: Colors.white,
      ),
    );
  }
}
