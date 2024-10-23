import 'package:flutter/material.dart';
import 'package:flutter_px/Common/button.dart';
import 'package:flutter_px/Common/gradient.dart';
import 'package:go_router/go_router.dart';

class PersonalInformationForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // Form key for validation.

  // Store data separately for address and user info
  final Map<String, dynamic> _userData = {};
  final Map<String, dynamic> _addressData = {};
  final Map<String, dynamic> _profileData = {};
  final Map<String, dynamic> _support =
      {}; //to collect data that is not used in profile creation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          toolbarHeight: 10,
          shadowColor: Colors.white,
        ),
        body: Container(
          color: Colors.white, // Set form background to white.
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(children: [
            SingleChildScrollView(
              child: Form(
                  key: _formKey, // Assign the form key.
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // Header Text: "Please tell us a little about yourself"
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Please tell us a little about ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold, // Bold text.
                              ),
                            ),
                            Text(
                              'yourself',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold, // Bold text.
                                color: Colors.blue, // Blue color.
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Divider with "or"

                        const SizedBox(height: 16),

                        // First Name, Middle Name, National ID No.
                        _buildTextField(
                            label: 'User Name',
                            hint: '',
                            dataMap: _userData,
                            dataLabel: 'username'),
                        _buildTextField(
                            label: 'Email',
                            hint: '',
                            dataMap: _userData,
                            dataLabel: 'email'),
                        Row(children: [
                          Expanded(
                            child: _buildTextField(
                                label: 'First Name',
                                hint: '',
                                dataMap: _userData,
                                dataLabel: 'firstName'),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildTextField(
                                label: 'Last Name',
                                hint: '',
                                dataMap: _userData,
                                dataLabel: 'lastName'),
                          )
                        ]),

                        _buildTextField(
                            label: 'password',
                            hint: '',
                            obscureText: true,
                            dataMap: _userData,
                            dataLabel: 'password'),
                        _buildTextField(
                            label: 'confirm password',
                            hint: '',
                            obscureText: true,
                            dataLabel: "confirm",
                            dataMap: _support),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Address Information',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold, // Bold text.
                                  color: Colors.blue, // Blue color.
                                ),
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                  label: 'Country',
                                  hint: '',
                                  dataMap: _addressData,
                                  dataLabel: 'country'),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                                child: _buildTextField(
                                    label: 'Region',
                                    hint: '',
                                    dataMap: _addressData,
                                    dataLabel: 'region')),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                  label: 'City',
                                  hint: '',
                                  dataMap: _addressData,
                                  dataLabel: 'city'),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                                child: _buildTextField(
                                    label: 'zone or subcity ',
                                    hint: '',
                                    dataMap: _addressData,
                                    dataLabel: 'zone_or_subcity')),
                          ],
                        ),
                        _buildTextField(
                            label: 'woreda ',
                            hint: '',
                            dataMap: _addressData,
                            dataLabel: 'woreda'),
                        _buildTextField(
                            label: 'postal code ',
                            hint: '',
                            dataMap: _addressData,
                            dataLabel: 'postal_code'),
                        _buildTextField(
                            label: 'Address line 1 ',
                            hint: '',
                            dataMap: _addressData,
                            dataLabel: 'address_line_1'),
                        _buildTextField(
                            label: 'Address line 2',
                            hint: '',
                            dataMap: _addressData,
                            dataLabel: 'address_line_2'),

                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Profile Information',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold, // Bold text.
                                  color: Colors.blue, // Blue color.
                                ),
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),

                        const SizedBox(height: 16),

                        _buildTextField(
                            label: 'Nationality',
                            hint: '',
                            dataMap: _profileData,
                            dataLabel: 'nationality'),
                        // Date of Birth and Gender in one row.
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                  label: 'Date of Birth',
                                  hint: '',
                                  dataMap: _profileData,
                                  dataLabel: 'date_of_birth'),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildTextField(
                                  label: 'Gender',
                                  hint: '',
                                  dataMap: _profileData,
                                  dataLabel: 'gender'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        _buildTextField(
                            label: 'Phone Number',
                            hint: '',
                            dataMap: _profileData,
                            dataLabel: 'phone_number'),

                        // Education Level and Marital Status
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                  label: 'Education Level',
                                  hint: '',
                                  dataMap: _profileData,
                                  dataLabel: 'education_level'),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildTextField(
                                  label: 'Marital Status',
                                  hint: '',
                                  dataMap: _profileData,
                                  dataLabel: 'marriage_status'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Emergency Tin Number Contact Name and Phone
                        _buildTextField(
                            label: 'Tin Number',
                            hint: '',
                            dataMap: _profileData,
                            dataLabel: 'tin_number'),
                        _buildTextField(
                            label: 'Emergency Contact Name',
                            hint: '',
                            dataMap: _profileData,
                            dataLabel: 'emergency_contact_name'),
                        _buildTextField(
                            label: 'Emergency Contact Phone No.',
                            hint: '',
                            dataMap: _profileData,
                            dataLabel: 'emergency_contact_number'),

                        const SizedBox(height: 24),

                        // Next Button
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Next',
                            onPressed: () {
                              context.go('/document');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 10,
                        )
                      ])),
            ),
          ]),
        ));
  }

  // Method to build text fields.
  Widget _buildTextField({
    required String label,
    required String hint,
    FormFieldValidator<String>? validator,
    required Map<String, dynamic>? dataMap,
    required String? dataLabel,
    bool obscureText =
        false, // default to false, meaning not obscure by default
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: validator ??
            (value) {
              // use the custom validator or default one
              if (value == null || value.isEmpty) {
                return 'Please enter $label'; // default validation message
              }
              return null;
            },
        onSaved: (value) {
          dataMap?[dataLabel as String] = value;
        },
        obscureText: obscureText, // for password fields
      ),
    );
  }
}
