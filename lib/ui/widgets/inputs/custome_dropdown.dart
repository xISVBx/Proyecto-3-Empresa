import 'package:flutter/material.dart';
import 'package:col_moda_empresa/ui/config/app_colors.dart';

/// Clase genérica para representar un ítem del dropdown
class DropdownItem<T> {
  final String label;
  final T value;

  DropdownItem({required this.label, required this.value});
}

class CustomDropdown<T> extends StatelessWidget {
  final String hint;
  final IconData icon;
  final List<DropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final Color? fillColor;
  final Color? iconColor;
  final Color? borderColor;
  final bool hasShadow;
  final double? menuMaxHeight;
  final double? menuMaxWidth;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final String? errorText; // <-- Nueva propiedad para mostrar errores

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.value,
    this.fillColor,
    this.iconColor,
    this.borderColor,
    this.hasShadow = true,
    this.menuMaxHeight,
    this.menuMaxWidth,
    this.focusNode,
    this.onTap,
    this.errorText, // <-- Se agrega para manejar errores
  });

  @override
  Widget build(BuildContext context) {
    Color effectiveFillColor = fillColor ?? AppColors.backgroundColor;
    Color effectiveIconColor = iconColor ?? AppColors.primary;
    Color effectiveBorderColor = borderColor ?? AppColors.backgroundColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: effectiveFillColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: effectiveBorderColor,
                width: 1.2,
              ),
              boxShadow: hasShadow
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isExpanded: true,
                focusNode: focusNode,
                menuMaxHeight: menuMaxHeight,
                menuWidth: menuMaxWidth,
                hint: Row(
                  children: [
                    Icon(icon, color: effectiveIconColor),
                    const SizedBox(width: 10),
                    Text(hint, style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
                items: items.map((DropdownItem<T> item) {
                  return DropdownMenuItem<T>(
                    value: item.value,
                    child: Text(item.label, style: const TextStyle(fontSize: 16)),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
        if (errorText != null) // Muestra el error si existe
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
