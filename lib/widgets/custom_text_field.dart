import 'package:aicaptions/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final bool? isShowCursor;
  final bool readOnly;
  final Color? hintColor, fillColor, borderColor;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const CustomTextField({
    super.key,
    this.validator,
    required this.hintText,
    this.borderColor,
    this.keyboardType,
    this.onTap,
    this.isShowCursor,
    this.hintColor,
    this.fillColor,
    this.onChanged,
    this.readOnly = false,
    this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;
  bool get hasError => errorText != null;
  void _onChanged(String value) {
    if (widget.onChanged != null) {
      _runValidator(value);
      widget.onChanged!(value);
    }
  }

  String? _runValidator(String? value) {
    if (widget.validator != null) {
      final error = widget.validator!(value!.trim());
      setState(() {
        errorText = error;
      });
      return error;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
            color: widget.fillColor ?? AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: widget.borderColor ?? AppColors.secondaryColor,
            ),
          ),
          child: TextFormField(
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            controller: widget.controller,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onChanged: _onChanged,
            autovalidateMode: AutovalidateMode.disabled,
            validator: _runValidator,
            onTap: widget.onTap,
            showCursor: widget.isShowCursor,
            readOnly: widget.readOnly,
            keyboardType: widget.keyboardType,
            cursorColor: AppColors.whiteColor,
            style: const TextStyle(
              color: AppColors.whiteColor,
            ),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              suffixIcon: const Icon(
                LucideIcons.search,
                color: Color(0xFF928A8A),
              ),
              errorText: null,
              fillColor: widget.fillColor,
              errorStyle: const TextStyle(height: -1, fontSize: 0.0),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              hintText: widget.hintText,
              isDense: true,
              hintStyle: TextStyle(
                color: widget.hintColor ?? const Color(0xFF928A8A),
                fontSize: 14.0,
              ),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 2),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorText!,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.redColor,
              ),
            ),
          ),
        ]
      ],
    );
  }
}
