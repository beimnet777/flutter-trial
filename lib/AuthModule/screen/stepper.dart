import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_px/AuthModule/Miscellaneous/dropdown_options.dart';
import 'package:flutter_px/AuthModule/bloc/profile%20bloc/datacollector_bloc.dart';
import 'package:flutter_px/AuthModule/bloc/profile%20bloc/datacollector_event.dart';
import 'package:flutter_px/AuthModule/bloc/profile%20bloc/datacollector_state.dart';
import 'package:flutter_px/AuthModule/screen/dropdown.dart';
import 'package:flutter_px/Common/button.dart';
import 'package:flutter_px/Common/footer.dart';
import 'package:flutter_px/Common/gradient.dart';
import 'package:go_router/go_router.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({Key? key}) : super(key: key);

  @override
  _NewProfilePageState createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
// Here we have created list of steps that
// are required to complete the form

  int _activeCurrentStep = 0;
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _addressInfoFormKey = GlobalKey<FormState>();
  final _profileInfoFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController =
      TextEditingController(); // Form key for validation.

  bool _isObscured = true; //for password obscuration

  // Store data separately for address and user info
  final Map<String, dynamic> _userData = {'user_type': 'data_collector'};
  final Map<String, dynamic> _addressData = {};
  final Map<String, dynamic> _profileData = {};
  final Map<String, dynamic> _support = {};

  List<Step> stepList() => [
        Step(
            title: const Text('Account'),
            state:
                _activeCurrentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: _activeCurrentStep >= 0,
            content: Form(
              key: _basicInfoFormKey,
              child: Column(
                children: [
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
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email';
                                }
                                final RegExp emailRegex =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                if (!emailRegex.hasMatch(value)) {
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
                                  dataLabel: 'first_name'),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildTextField(
                                  label: 'Last Name',
                                  hint: '',
                                  dataMap: _userData,
                                  dataLabel: 'last_name'),
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
                                if (value == null || value.isEmpty) {
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
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                } else if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              })
                        ],
                      )),
                ],
              ),
            )),
        Step(
            title: Text('Address'),
            state:
                _activeCurrentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: _activeCurrentStep >= 1,
            content: Form(
              key: _addressInfoFormKey,
              child: Column(
                children: [
                  _buildDivider("Address Information"),
                  const SizedBox(
                    height: 16,
                  ),
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
                  ),
                ],
              ),
            )),
        Step(
            title: const Text('Profile'),
            isActive: _activeCurrentStep >= 2,
            content: Form(
              key: _profileInfoFormKey,
              child: Column(
                children: [
                  _buildDivider("Profile Information"),
                  const SizedBox(
                    height: 16,
                  ),
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
                              hint: 'YYYY-MM-DD',
                              dataMap: _profileData,
                              dataLabel: 'date_of_birth',
                              boardType: 'Date',
                              validator: (value) {
                                if (value == null) {
                                  return "Please enter date of birth";
                                }
                                final RegExp dateRegex = RegExp(
                                    r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$');

                                if (!dateRegex.hasMatch(value)) {
                                  return "Must be YYYY-MM-DD";
                                }
                                return null;
                              })),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DropdownInputField(
                            validation: true,
                            options: gender,
                            data: _profileData,
                            defaultValue: "Male",
                            lable: "Sex",
                            dataKey: "gender",
                            errorMessage: "Please select an option",
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
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DropdownInputField(
                            validation: true,
                            options: educationLevelStrings,
                            data: _profileData,
                            defaultValue: "Primary",
                            lable: "Education Level",
                            dataKey: "education_level",
                            errorMessage: "Please select an option",
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DropdownInputField(
                            validation: true,
                            options: maritialStatus,
                            data: _profileData,
                            defaultValue: "Single",
                            lable: "Maritial Status",
                            dataKey: "marriage_status",
                            errorMessage: "Please select an option",
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
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DropdownInputField(
                            validation: true,
                            options: idType,
                            data: _profileData,
                            defaultValue: "National Id",
                            lable: "Id Type",
                            dataKey: "id_type",
                            errorMessage: "Please select an option",
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
                ],
              ),
            ))
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Please tell us a little about ', // The green part
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Bold text.
                  ),
                ),
                TextSpan(
                  text: 'yourself', // The red part
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Bold text.
                    color: Colors.blue, // Blue color.
                  ),
                ),
              ],
            ),
          ),
        ),

        // Here we have initialized the stepper widget
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
          child: Builder(builder: (context) {
            return Container(
              color: Colors.white,
              child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(255, 96, 169, 222),
                )),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: GradientBackgroundPainter(
                            alignment: Alignment.bottomLeft),
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Stepper(
                            type: StepperType.horizontal,
                            connectorThickness: 2,
                            currentStep: _activeCurrentStep,
                            steps: stepList(),
                            onStepContinue: () {
                              //not at the last page
                              bool validated = false;
                              switch (_activeCurrentStep) {
                                case 0:
                                  {
                                    if (_basicInfoFormKey.currentState
                                            ?.validate() ??
                                        false) {
                                      validated = true;
                                    }
                                    break;
                                  }
                                case 1:
                                  {
                                    if (_addressInfoFormKey.currentState
                                            ?.validate() ??
                                        false) {
                                      validated = true;
                                    }
                                  }
                              }
                              if (_activeCurrentStep <
                                  (stepList().length - 1)) {
                                if (validated) {
                                  setState(() {
                                    _activeCurrentStep += 1;
                                  });
                                }
                              } else {
                                _basicInfoFormKey.currentState?.save();
                                _addressInfoFormKey.currentState?.save();
                                _profileData['user'] = _userData;
                                _profileData['user_address'] = _addressData;
                                _profileData['latitude'] = .1;
                                _profileData['longitude'] = .21;

                                if (_profileInfoFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  _profileInfoFormKey.currentState?.save();
                                  // Emit the event to submit the form
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(CreateProfile(_profileData));
                                }
                              }
                            },
                            onStepCancel: () {
                              if (_activeCurrentStep == 0) {
                                return;
                              }

                              setState(() {
                                _activeCurrentStep -= 1;
                              });
                            },
                            controlsBuilder: (BuildContext context,
                                ControlsDetails details) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      text: "Next",
                                      onPressed:
                                          details.onStepContinue ?? () {},
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (_activeCurrentStep != 0)
                                    Expanded(
                                      child: CustomButton(
                                          text: "Back",
                                          onPressed:
                                              details.onStepCancel ?? () {}),
                                    )
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        const CutsomFooter()
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ));
  }

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
        validator: validator ??
            (value) {
              if (boardType == "Number" &&
                  value != null &&
                  !RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Please enter numbers only';
              } else if (boardType != "Number" &&
                  value != null &&
                  !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                return 'Please enter letters only';
              }
              return null;
            },
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
