import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:flutter/material.dart';

class CustomCheckBoxFormField extends FormField<bool> {
  CustomCheckBoxFormField({
    super.key,
    required BuildContext context,
    required bool initialValue,
    required ValueChanged<bool?> onChanged,
    required Widget suffixContent,
    super.validator,
  }) : super(
         initialValue: initialValue,
         builder: (FormFieldState<bool> field) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 children: [
                   Theme(
                     data: ThemeData(
                       checkboxTheme: CheckboxThemeData(
                         visualDensity: VisualDensity.compact,
                         materialTapTargetSize:
                             MaterialTapTargetSize.shrinkWrap,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(4.0),
                         ),
                       ),
                     ),
                     child: Checkbox(
                       value: field.value ?? false,
                       activeColor: CustomColorTheme.primaryDarkColor,
                       checkColor: CustomColorTheme.backgroundLightColor,
                       side: BorderSide(
                         width: 1,
                         color: CustomColorTheme.primaryTextColor,
                       ),
                       onChanged: (value) {
                         field.didChange(value);
                         onChanged(value);
                       },
                     ),
                   ),
                   const SizedBox(width: 5),
                   suffixContent,
                 ],
               ),
               if (field.hasError)
                 Padding(
                   padding: const EdgeInsets.only(left: 8.0),
                   child: Text(
                     field.errorText!,
                     style: TextStyle(color: Colors.red[900], fontSize: 12),
                   ),
                 ),
             ],
           );
         },
       );
}
