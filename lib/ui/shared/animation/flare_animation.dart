import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class DYXFlareAnimation extends StatelessWidget {
  final url;
  final animation;
  final height;
  final width;

  DYXFlareAnimation({@required this.url, @required this.animation, @required this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: FlareActor("assets/flr/$url.flr",
          alignment:Alignment.center,
          fit:BoxFit.contain,
          animation:animation
      ),
    );
  }

}
