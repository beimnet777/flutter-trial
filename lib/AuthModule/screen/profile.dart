import 'package:flutter/material.dart';
import 'package:flutter_px/AuthModule/Miscellaneous/dropdown_options.dart';
import 'package:flutter_px/AuthModule/bloc/profile%20bloc/datacollector_bloc.dart';
import 'package:flutter_px/AuthModule/bloc/profile%20bloc/datacollector_event.dart';
import 'package:flutter_px/AuthModule/bloc/profile%20bloc/datacollector_state.dart';
import 'package:flutter_px/AuthModule/screen/dropdown.dart';
import 'package:flutter_px/Common/button.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInformationForm extends StatefulWidget {
  @override
  _PersonalInformationFormState createState() =>
      _PersonalInformationFormState();
}

class _PersonalInformationFormState extends State<PersonalInformationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController =
      TextEditingController(); // Form key for validation.

  bool _isObscured = true; //for password obscuration

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
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Text("data"),
        //   backgroundColor: const Color.fromARGB(255, 112, 205, 249),
        //   flexibleSpace: Container(
        //       decoration: BoxDecoration(

        //     image: DecorationImage(

        //       image: AssetImage(

        //           'assets/PlatformX_logo.png'), // Replace with your image path
        //       fit: BoxFit.cover, // Cover the entire AppBar
        //     ),
        //   )),
        // ),
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100), // Rounded corners
                  ),
                  shadowColor: const Color.fromARGB(255, 92, 220, 243),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    // color: Colors.white,
                    // Set form background to white.
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
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'Please tell us a little about ', // The green part
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight:
                                                FontWeight.bold, // Bold text.
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'yourself', // The red part
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight:
                                                FontWeight.bold, // Bold text.
                                            color: Colors.blue, // Blue color.
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  _buildDivider("Basic Information"),

                                  const SizedBox(height: 16),
                                  Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
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
                                              boardType: 'Email',
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter an email';
                                                }
                                                final RegExp emailRegex = RegExp(
                                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                                if (!emailRegex
                                                    .hasMatch(value)) {
                                                  return 'Please enter a valid email';
                                                }
                                                return null;
                                              }),
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
                                              controller: _passwordController,
                                              obscureText: true,
                                              dataMap: _userData,
                                              dataLabel: 'password',
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter a password';
                                                } else if (value.length < 8) {
                                                  return 'Password must be at least 8 characters long';
                                                }
                                                return null;
                                              }),

                                          _buildTextField(
                                              label: 'confirm password',
                                              hint: '',
                                              obscureText: true,
                                              dataLabel: "confirm",
                                              dataMap: _support,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please confirm your password';
                                                } else if (value !=
                                                    _passwordController.text) {
                                                  return 'Passwords do not match';
                                                }
                                                return null;
                                              })
                                        ],
                                      )),
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
                                      dataLabel: 'woreda',
                                      boardType: 'Number'),
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
                                      dataLabel: 'address_line_2',
                                      validator: (value) => null),

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
                                              label: 'Date of Birth',
                                              hint: '',
                                              dataMap: _profileData,
                                              dataLabel: 'date_of_birth',
                                              boardType: 'Date')),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: DropdownInputField(
                                            validation: true,
                                            options: gender,
                                            data: _profileData,
                                            defaultValue: "Male",
                                            lable: "Sex",
                                            dataKey: "gender",
                                            errorMessage:
                                                "Please select an option",
                                          ),
                                        ),
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
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: DropdownInputField(
                                            validation: true,
                                            options: educationLevelStrings,
                                            data: _profileData,
                                            defaultValue: "Primary",
                                            lable: "Education Level",
                                            dataKey: "education_level",
                                            errorMessage:
                                                "Please select an option",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: DropdownInputField(
                                            validation: true,
                                            options: maritialStatus,
                                            data: _profileData,
                                            defaultValue: "Single",
                                            lable: "Maritial Status",
                                            dataKey: "marriage_status",
                                            errorMessage:
                                                "Please select an option",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 16),

                                  // Emergency Tin Number Contact Name and Phone
                                  _buildTextField(
                                      label: 'Tin Number',
                                      hint: '',
                                      dataMap: _profileData,
                                      dataLabel: 'tin_number',
                                      boardType: "Number"),
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: DropdownInputField(
                                            validation: true,
                                            options: idType,
                                            data: _profileData,
                                            defaultValue: "National Id",
                                            lable: "Id Type",
                                            dataKey: "id_type",
                                            errorMessage:
                                                "Please select an option",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
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
                                              _profileData['address'] =
                                                  _addressData;
                                              if (_formKey.currentState
                                                      ?.validate() ??
                                                  false) {
                                                _formKey.currentState?.save();
                                                // Emit the event to submit the form
                                                BlocProvider.of<ProfileBloc>(
                                                        context)
                                                    .add(CreateProfile(
                                                        _profileData));
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
                  ),
                ),
              );
            },
          ),
        ));
  }

// **************************** Form Builder Widget*************\\
  Widget _buildDivider(String text) {
    return Row(
      children: [
        const Expanded(
            child: Divider(
          color: Colors.lightBlue,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800, // Bold text.
              color: Colors.blue, // Blue color.
            ),
          ),
        ),
        const Expanded(
            child: Divider(
          color: Colors.lightBlue,
        )),
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
    TextEditingController? controller,
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
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: obscureText
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    // Toggle the password visibility
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  })
              : null,
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),

        keyboardType: keyboardType,
        validator: null,
        //  validator ??
        //     (value) {
        //       // use the custom validator or default one
        //       if (value == null || value.isEmpty) {
        //         return 'Please enter $label'; // default validation message
        //       }
        //       return null;
        //     },
        onSaved: (value) {
          dataMap?[dataLabel as String] = value;
        },
        obscureText: obscureText && _isObscured, // for password fields
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

Widget _buildDropDown(
    {required String selectedValue, required List<String> optionList}) {
  return DropdownButtonFormField<String>(
    value: selectedValue,
    decoration: const InputDecoration(
      labelText: 'Choose an option',
      border: OutlineInputBorder(),
    ),
    icon: const Icon(Icons.keyboard_arrow_down),
    style: const TextStyle(color: Colors.deepPurple),
    onChanged: null,
    items: optionList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}
