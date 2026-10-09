import 'package:afridelight/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.height = 58,
    super.key,
  });

  final String label;
  final Future<void> Function() onPressed;
  final IconData? icon;
  final double height;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  var _pressed = false;

  Future<void> _handleTap() async {
    if (_pressed) {
      return;
    }
    setState(() => _pressed = true);
    try {
      await widget.onPressed();
    } finally {
      if (mounted) {
        setState(() => _pressed = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _pressed ? 0.985 : 1,
      duration: const Duration(milliseconds: 110),
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: _handleTap,
          icon: widget.icon == null ? const SizedBox.shrink() : Icon(widget.icon),
          label: Text(widget.label),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.deepOrange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
