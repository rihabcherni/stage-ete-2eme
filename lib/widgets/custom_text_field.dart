import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.obscureText = false,
    this.onSaved,
    this.onChanged,
    this.trailingIcon,
    this.validator,
  });

  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final bool obscureText;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final IconData? trailingIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 241, 240, 240).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: FormField<String>(
        validator: validator,
        builder: (FormFieldState<String> field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller,
                onChanged: (value) {
                  field.didChange(value);
                  if (onChanged != null) {
                    onChanged!(value);
                  }
                },
                onSaved: onSaved,
                cursorColor: kPrimaryColor,
                maxLines: maxLines,
                obscureText: obscureText,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 20.0),
                  hintText: hint,
                  border: buildBorder(),
                  enabledBorder: buildBorder(),
                  focusedBorder: buildBorder(kPrimaryColor),
                  suffixIcon: trailingIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(
                            trailingIcon,
                            color: kPrimaryColor,
                          ),
                        )
                      : null,
                  errorText: field.errorText,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  OutlineInputBorder buildBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: color ?? kInputColor,
      ),
    );
  }
}
