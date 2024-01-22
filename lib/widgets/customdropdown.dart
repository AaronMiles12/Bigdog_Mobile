import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDropdownWidget extends StatelessWidget {
  final List<String> options;
  final String selectedValue;
  final Function(String) onChanged;

  const MyDropdownWidget({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: DropdownButtonFormField<String>(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 21.h, horizontal: 13.w),
          hintText: selectedValue,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
        ),
        value: selectedValue,
        items: options
            .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        onChanged: (s) => onChanged(s!),
      ),
    );
  }
}
