import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double? width;
  final double height;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.width,
    this.height = 48,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == ButtonType.primary ? Colors.white : AppConstants.primaryColor,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: AppConstants.spacingS),
          Text(text, style: _getTextStyle()),
        ],
      );
    }

    return Text(text, style: _getTextStyle());
  }

  ButtonStyle _getButtonStyle() {
    final defaultBorderRadius = BorderRadius.circular(AppConstants.radiusM);
    const defaultPadding = EdgeInsets.symmetric(
      horizontal: AppConstants.spacingL,
      vertical: AppConstants.spacingM,
    );

    switch (type) {
      case ButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppConstants.primaryColor,
          foregroundColor: textColor ?? Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? defaultBorderRadius,
          ),
          padding: padding ?? defaultPadding,
        );

      case ButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppConstants.accentColor,
          foregroundColor: textColor ?? Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? defaultBorderRadius,
          ),
          padding: padding ?? defaultPadding,
        );

      case ButtonType.outline:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: textColor ?? AppConstants.primaryColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          side: BorderSide(
            color: borderColor ?? AppConstants.primaryColor,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? defaultBorderRadius,
          ),
          padding: padding ?? defaultPadding,
        );

      case ButtonType.text:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: textColor ?? AppConstants.primaryColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? defaultBorderRadius,
          ),
          padding: padding ?? defaultPadding,
        );
    }
  }

  TextStyle _getTextStyle() {
    if (textStyle != null) return textStyle!;

    final baseStyle = AppConstants.button.copyWith(
      color: textColor,
    );

    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
        return baseStyle.copyWith(color: Colors.white);
      case ButtonType.outline:
      case ButtonType.text:
        return baseStyle.copyWith(
          color: textColor ?? AppConstants.primaryColor,
        );
    }
  }
} 