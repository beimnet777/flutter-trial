import 'package:flutter/material.dart';

class DropdownInputField extends StatefulWidget {
  final bool validation;
  final Map<String, dynamic> options;
  final String defaultValue;
  final String dataKey;
  final Map<String, dynamic> data;
  final String lable;
  final String? errorMessage;

  const DropdownInputField(
      {super.key,
      required this.validation,
      required this.options,
      required this.data,
      required this.dataKey,
      required this.defaultValue,
      required this.lable,
      required this.errorMessage});

  @override
  State<DropdownInputField> createState() => _DropdownInputFieldState();
}

class _DropdownInputFieldState extends State<DropdownInputField> {
  String? validateDropdown(String? value) {
    if (widget.validation && (value == null || value.isEmpty)) {
      return widget.errorMessage ?? 'Please select an option';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String? selectedValue = widget.defaultValue;
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return DropdownButtonFormField<String>(
      items: widget.options.keys.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          enabled: true,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      onSaved: (String? newValue) {
        widget.data[widget.dataKey] = widget.options[newValue];
      },
      validator: validateDropdown,
      style: null,
      decoration: InputDecoration(
        labelText: widget.lable,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey)),
      ),
    );
  }
}
