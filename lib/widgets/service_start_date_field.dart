import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceStartDateField extends StatelessWidget {
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;

  const ServiceStartDateField({
    Key? key,
    required this.controller,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Service Start Date'),
      readOnly: true,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          onDateSelected(pickedDate);
        }
      },
    );
  }
}
