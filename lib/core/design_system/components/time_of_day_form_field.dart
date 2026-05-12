import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter/material.dart';

class TimeOfDayFormField extends FormField<TimeOfDay> {
  TimeOfDayFormField({
    super.key,
    required BuildContext context,
    required ValueChanged<TimeOfDay?> onChanged,
    Duration? subtractDuration,
    String? label,
    super.initialValue,
    super.validator,
  }) : super(
         builder: (FormFieldState<TimeOfDay> field) {
           final value = field.value;

           return InkWell(
             onTap: () async {
               final dateTime = DateTime.now().subtract(
                 subtractDuration ?? Duration.zero,
               );
               final timeOfDay = TimeOfDay(
                 hour: dateTime.hour,
                 minute: dateTime.minute,
               );
               final value = await showTimePicker(
                 context: context,
                 initialTime: initialValue ?? timeOfDay,
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
                     padding: const EdgeInsets.only(left: 5),
                     child: Center(
                       child: Text(
                         value != null
                             ? '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}'
                             : label ?? 'horário',
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
