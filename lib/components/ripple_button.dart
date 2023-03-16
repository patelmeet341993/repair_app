import 'package:flutter/material.dart';

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
    return  Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        child: child,
      ),
    );
  }
}

