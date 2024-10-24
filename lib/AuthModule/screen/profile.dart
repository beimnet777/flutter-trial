import 'package:flutter/material.dart';
import 'package:flutter_px/AuthModule/bloc/datacollector_bloc.dart';
import 'package:flutter_px/AuthModule/bloc/datacollector_event.dart';
import 'package:flutter_px/AuthModule/bloc/datacollector_state.dart';
import 'package:flutter_px/Common/button.dart';
import 'package:flutter_px/Common/gradient.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
        body: BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileCreated) {
          // Navigate to the next page when submission is successful
          context.go('/document');
        } else if (state is ProfileCreationFailed) {
          // Show an error message if submission fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Builder(
        builder: (context) {
          // final profileBloc = context.read<ProfileBloc>();
          return Stack(children: [
            SizedBox(
              height: screenHeight * 0.4,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFB3E5FC), // Light Blue
                      Color(0xFFFFFFFF), // White
                    ],
                  ),
                ),
              ),
            ),
            Container(
              // color: Colors.white, // Set form background to white.
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

                            _buildDivider("Basic Information"),

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
                                dataLabel: 'email',
                                boardType: 'Email'),
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
                            _buildDivider("Address Information"),

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
                                dataLabel: 'postal_code',
                                boardType: 'Number'),
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

                            _buildDivider("Profile Information"),

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
                                        label: 'Nationality',
                                        hint: '',
                                        dataMap: _profileData,
                                        dataLabel: 'nationality',
                                        boardType: 'Date')),
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
                                dataLabel: 'phone_number',
                                boardType: "Phone"),

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
                            _buildTextField(
                                label: 'Id type',
                                hint: '',
                                dataMap: _profileData,
                                dataLabel: 'id_type'),
                            _buildTextField(
                                label: 'Selected Id No.',
                                hint: '',
                                dataMap: _profileData,
                                dataLabel: 'id_number'),

                            const SizedBox(height: 24),

                            // Next Button *************************************
                            BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                              if (state is ProfileCreating) {
                                return const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ]);
                              } else {
                                return SizedBox(
                                  width: double.infinity,
                                  child: CustomButton(
                                      text: 'Next',
                                      onPressed: () {
                                        _profileData['user'] = _userData;
                                        _profileData['address'] = _addressData;
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          _formKey.currentState?.save();
                                          // Emit the event to submit the form
                                          BlocProvider.of<ProfileBloc>(context)
                                              .add(CreateProfile(_profileData));
                                        }
                                      }),
                                );
                              }
                              // to return some widget incase all the above fails
                            }),
                            const SizedBox(
                              height: 10,
                            )
                          ])),
                ),
              ]),
            )
          ]);
        },
      ),
    ));
  }

// **************************** Form Builder Widget*************\\
  Widget _buildDivider(String text) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold, // Bold text.
              color: Colors.blue, // Blue color.
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  // Method to build text fields.
  Widget _buildTextField({
    required String label,
    required String hint,
    FormFieldValidator<String>? validator,
    required Map<String, dynamic>? dataMap,
    required String? dataLabel,
    String boardType = "Text",
    bool obscureText =
        false, // default to false, meaning not obscure by default
  }) {
    final TextInputType keyboardType;
    switch (boardType) {
      case 'Text':
        keyboardType = TextInputType.text;
        break;
      case 'Number':
        keyboardType = TextInputType.number;
      case 'Date':
        keyboardType = TextInputType.datetime;
        break;
      case 'Phone':
        keyboardType = TextInputType.phone;
        break;
      case 'Email':
        keyboardType = TextInputType.emailAddress;
        break;
      default:
        keyboardType = TextInputType.text;
    }
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
        keyboardType: keyboardType,
        validator: validator ??
            (value) {
              // use the custom validator or default one
              // if (value == null || value.isEmpty) {
              //   return 'Please enter $label'; // default validation message
              // }
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

Widget _buildDatePickerField({
  required String label,
  required BuildContext context,
  required Map<String, dynamic> dataMap,
  required String dataLabel,
}) {
  DateTime? selectedDate;

  return TextFormField(
    readOnly: true, // Prevents manual input.
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: Icon(Icons.calendar_today),
    ),
    onTap: () async {
      // Show the date picker
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050),
      );
      if (picked != null) {
        selectedDate = picked; // Store the selected date locally
        // Manually trigger form state update
        (context as Element).markNeedsBuild();
      }
    },
    onSaved: (value) {
      // Store the selected date in the dataMap
      if (selectedDate != null) {
        dataMap[dataLabel] = selectedDate;
      }
    },
    validator: (value) {
      // Ensure a date is selected
      if (selectedDate == null) {
        return 'Please select a valid date';
      }
      return null;
    },
    // Show the selected date if available
    // ignore: unnecessary_null_comparison
    initialValue: selectedDate != null
        ? "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}"
        : '',
  );
}
