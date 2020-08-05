import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class DYXFlareAnimation extends StatelessWidget {
  final url;
  final animation;
  final height;

  DYXFlareAnimation({@required this.url, @required this.animation, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: FlareActor("assets/flr/$url.flr",
          alignment:Alignment.center,
          fit:BoxFit.contain,
          animation:animation
      ),
    );
  }

}
