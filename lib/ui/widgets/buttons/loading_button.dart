import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String text;
  final Future<void> Function() onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double paddingVertical;
  final double paddingHorizontal;
  final double borderRadius;
  final bool disableWhileLoading;

  const LoadingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.paddingVertical = 15,
    this.paddingHorizontal = 40,
    this.borderRadius = 10,
    this.disableWhileLoading = true,
  });

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePress() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      await widget.onPressed();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.disableWhileLoading && _isLoading ? null : _handlePress,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.textColor,
        padding: EdgeInsets.symmetric(
            vertical: widget.paddingVertical,
            horizontal: widget.paddingHorizontal),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        textStyle:
            TextStyle(fontSize: widget.fontSize, fontWeight: FontWeight.bold),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          if (_isLoading)
            Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
          Text(widget.text),
        ],
      ),
    );
  }
}
