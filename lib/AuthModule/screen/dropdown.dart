import 'package:flutter/material.dart';
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _userData = {}; // Store form data

  // Dropdown options
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  String? _selectedGender; // Store selected gender

  Widget _buildDropdownField({
    required String label,
    required String dataLabel,
    required List<String> items,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: _selectedGender, // Initial value
      icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender = newValue; // Update selected value
        });
      },
      onSaved: (value) {
        _userData[dataLabel] = value; // Save the selected value
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a valid option';
        }
        return null;
      },
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownField(
            label: 'Gender',
            dataLabel: 'gender',
            items: _genderOptions,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save(); // Save all form data
                print(_userData); // Log the form data
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
