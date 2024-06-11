import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final String? errorText;
  final Function? onChanged;
  final EdgeInsetsGeometry? padding;

  const MyTextField(
      {super.key,
      this.controller,
      this.onChanged,
      this.errorText,
      this.padding,
      this.hint = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          onChanged?.call(value);
        },
        decoration: InputDecoration(
            errorStyle: const TextStyle(color: Colors.red),
            filled: true,
            errorText: errorText,
            hintText: hint,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
