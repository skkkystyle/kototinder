import 'package:flutter/material.dart';

class ScalingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ScalingButton({super.key, required this.onPressed, required this.child});

  @override
  State<ScalingButton> createState() => _ScalingButtonState();
}

class _ScalingButtonState extends State<ScalingButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 1.2;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut,
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
