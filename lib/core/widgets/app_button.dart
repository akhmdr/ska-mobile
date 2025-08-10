import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;
  final bool text;
  final bool small;
  final bool large;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.text = false,
    this.small = false,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = (text || outlined) ? AppTheme.primaryColor : Colors.white;
    final fontSize = small ? 14.0 : (large ? 18.0 : 16.0);

    final textStyle = TextStyle(
      color: textColor,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
    );

    final padding = EdgeInsets.symmetric(
      vertical: small ? 10 : (large ? 16 : 14),
      horizontal: small ? 14 : (large ? 24 : 20),
    );

    if (outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppTheme.primaryColor),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          overlayColor: AppTheme.primaryColor.withOpacity(0.08),
        ),
        child: Text(label, style: textStyle),
      );
    } else if (text) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.primaryColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          overlayColor: AppTheme.primaryColor.withOpacity(0.08),
        ),
        child: Text(label, style: textStyle),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          overlayColor: AppTheme.onPrimaryColor.withOpacity(0.12),
        ),
        child: Text(label, style: textStyle),
      );
    }
  }
}
