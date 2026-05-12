import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

class DateFormField extends FormField<DateTime> {
  DateFormField({
    super.key,
    required BuildContext context,
    required ValueChanged<DateTime?> onChanged,
    Duration? subtractDuration,
    String? label,
    super.initialValue,
    super.validator,
  }) : super(
         builder: (FormFieldState<DateTime> field) {
           final value = field.value;

           return InkWell(
             onTap: () async {
               final dateTime = DateTime.now().subtract(
                 subtractDuration ?? Duration.zero,
               );
               final value = await showDatePicker(
                 context: context,
                 firstDate: dateTime.copyWith(year: 2000),
                 lastDate: DateTime.now(),
                 initialDate: initialValue ?? dateTime,
                 builder: (context, child) => Theme(
                   data: Theme.of(context).copyWith(
                     colorScheme: ColorScheme.light(
                       primary: CustomColorTheme.primaryColor,
                       onPrimary: Colors.white, // cor do texto dentro do dial
                       onSurface: Colors.black,
                     ),
                     textButtonTheme: TextButtonThemeData(
                       style: TextButton.styleFrom(
                         foregroundColor: CustomColorTheme.primaryColor,
                       ),
                     ),
                   ),
                   child: child!,
                 ),
               );
               field.didChange(value);
               onChanged(value);
             },
             child: Container(
               height: 40,
               padding: const EdgeInsets.symmetric(horizontal: 10),
               decoration: BoxDecoration(
                 color: CustomColorTheme.backgroundColor,
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 10),
                     child: Center(
                       child: Text(
                         value != null
                             ? '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}'
                             : label ?? 'Selecione a data',
                         style: CustomTextStyle.bodyStyleText,
                       ),
                     ),
                   ),
                   const Icon(Icons.keyboard_arrow_down_sharp),
                 ],
               ),
             ),
           );
         },
       );
}
