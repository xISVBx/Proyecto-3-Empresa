import 'package:flutter/material.dart';
import 'package:col_moda_empresa/ui/config/app_colors.dart';

enum CustomTextFieldStyle {
  filled,
  outlined,
  underline,
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final CustomTextFieldStyle style;
  final Color? fillColor;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final bool hasShadow;
  final String? errorText; // <-- Nueva propiedad para manejar errores

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.style = CustomTextFieldStyle.filled,
    this.fillColor,
    this.iconColor,
    this.iconBackgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.focusNode,
    this.onEditingComplete,
    this.hasShadow = true,
    this.errorText, // <-- Se agrega para permitir mostrar errores
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Color fillColor = widget.fillColor ?? AppColors.backgroundColor;
    Color iconColor = widget.iconColor ?? AppColors.primary;
    Color iconBackgroundColor =
        widget.iconBackgroundColor ?? AppColors.backgroundColor;
    Color borderColor = widget.borderColor ?? AppColors.backgroundColor;
    Color focusedBorderColor =
        widget.focusedBorderColor ?? AppColors.backgroundColor;

    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: borderColor, width: 1.2),
    );

    InputBorder? inputBorder;
    switch (widget.style) {
      case CustomTextFieldStyle.filled:
        inputBorder = InputBorder.none;
        break;
      case CustomTextFieldStyle.outlined:
        inputBorder = border;
        break;
      case CustomTextFieldStyle.underline:
        inputBorder =
            UnderlineInputBorder(borderSide: BorderSide(color: borderColor));
        fillColor = Colors.transparent;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: widget.style == CustomTextFieldStyle.outlined
              ? BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: widget.hasShadow
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                )
              : null,
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            onEditingComplete: widget.onEditingComplete,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword ? _obscureText : false,
            decoration: InputDecoration(
              prefixIcon: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(widget.icon, color: iconColor),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey.shade600),
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder.copyWith(
                borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
              ),
              filled: true,
              fillColor: fillColor,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
        if (widget.errorText != null) // Muestra error si existe
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
