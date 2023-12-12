import 'package:flutter/material.dart';
import 'package:time_tracker/core/app_colors.dart';

class CustomTextField extends StatefulWidget {

  final TextEditingController textEditingController ;
  final String hinText;

  const CustomTextField({super.key, required this.textEditingController, required this.hinText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if(value == null || value.isEmpty){
          return 'This field is required';
        }
        return null;
      },
      style: const TextStyle(color: violetDashboard),
      decoration: InputDecoration(
        hintText: widget.hinText,
        hintStyle: const TextStyle(color: violetDashboard),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: violetDashboard),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: violetDashboard),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
