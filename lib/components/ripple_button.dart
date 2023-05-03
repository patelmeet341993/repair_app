import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

import '../utils/dimensions.dart';

class RippleButton extends StatelessWidget {
  const RippleButton({Key? key, required this.onTap}) : super(key: key);
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
      ),
    );
  }
}




class MyRippleButton extends StatelessWidget {
  MyRippleButton({Key? key, required this.onTap,required this.child}) : super(key: key);
  final GestureTapCallback onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return  TouchRippleEffect(
      onTap: onTap,
      rippleColor: Colors.black26,
      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
      backgroundColor: Colors.white ,
      child: child,
    );
  }
}
