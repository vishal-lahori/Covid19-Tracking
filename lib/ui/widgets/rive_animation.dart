import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:rive/rive.dart';

class RiveAnimation extends StatefulWidget {
  final String animation;

  RiveAnimation({this.animation});
  @override
  _RiveAnimationState createState() => _RiveAnimationState();
}

class _RiveAnimationState extends State<RiveAnimation> {
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/rive/barrier-gate.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation(widget.animation));
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: _riveArtboard == null
          ? const SizedBox()
          : Rive(
              artboard: _riveArtboard,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
    );
  }
}
