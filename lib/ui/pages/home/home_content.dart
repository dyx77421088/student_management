import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/animation/flare_status.dart';
import 'package:student_management/ui/widgets/shield_score.dart';
import 'package:student_management/core/extension/int_extension.dart';
class DYXHomeContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildFlare(),
      ],
    );
  }

  Widget buildFlare() {
    return Container(
      height: 180,
      child: FlareActor("assets/flr/Guss.flr",
          alignment:Alignment.center,
          fit:BoxFit.contain,
          animation:DYXGuss.idle
      ),
    );
  }
}
