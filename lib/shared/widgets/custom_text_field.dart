import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_constants.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;
  final EdgeInsets? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Color? fillColor;
  final bool filled;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? errorStyle;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.fillColor,
    this.filled = false,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.errorStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      inputFormatters: widget.inputFormatters,
      autofocus: widget.autofocus,
      style: widget.textStyle ?? AppConstants.body1,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _buildSuffixIcon(),
        contentPadding: widget.contentPadding ?? const EdgeInsets.all(AppConstants.spacingM),
        border: widget.border ?? _getDefaultBorder(),
        enabledBorder: widget.enabledBorder ?? _getDefaultBorder(),
        focusedBorder: widget.focusedBorder ?? _getFocusedBorder(),
        errorBorder: widget.errorBorder ?? _getErrorBorder(),
        focusedErrorBorder: widget.focusedErrorBorder ?? _getErrorBorder(),
        filled: widget.filled,
        fillColor: widget.fillColor ?? AppConstants.surfaceColor,
        labelStyle: widget.labelStyle ?? AppConstants.body2.copyWith(
          color: AppConstants.textSecondary,
        ),
        hintStyle: widget.hintStyle ?? AppConstants.body2.copyWith(
          color: AppConstants.textTertiary,
        ),
        errorStyle: widget.errorStyle ?? AppConstants.caption.copyWith(
          color: AppConstants.errorColor,
        ),
        counterText: '',
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: AppConstants.textSecondary,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffixIcon;
  }

  InputBorder _getDefaultBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      borderSide: BorderSide(
        color: AppConstants.textTertiary.withOpacity(0.3),
        width: 1,
      ),
    );
  }

  InputBorder _getFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      borderSide: const BorderSide(
        color: AppConstants.primaryColor,
        width: 2,
      ),
    );
  }

  InputBorder _getErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      borderSide: const BorderSide(
        color: AppConstants.errorColor,
        width: 1,
      ),
    );
  }
} 