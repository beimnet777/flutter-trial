import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_px/AuthModule/bloc/profile%20bloc/datacollector_bloc.dart';
import 'package:flutter_px/AuthModule/bloc/profile%20bloc/datacollector_event.dart';
import 'package:flutter_px/AuthModule/bloc/profile%20bloc/datacollector_state.dart';
import 'dart:io';

import 'package:flutter_px/Common/button.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  _UploadDocumentsScreenState createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  // Variables to track the selected files for each field
  int? idImage;
  int? profileImage;
  int? credentialImage;

  Map<String, File>? fileData = {};
  Map<String, String> fieldMap = {
    'credentialImage': 'credential_image',
    'profileImage': 'profile_picture',
    'idImage': 'id_image'
  };

  // Progress tracking (0, 1, 2, or 3)
  List completedSteps = [];

  SharedPreferences? _preferences;
  String? profileId;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _loadStoredValue();
  }

  void _loadStoredValue() {
    setState(() {
      profileId = _preferences!.getString('profile_id');
    });
  }

  // Method to handle file picking
  Future<void> _pickFile(String field) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      try {
        File file = File(result.files.single.path!);
        fileData?[fieldMap[field]!] = file;
      } catch (e) {
        print(e);
        print("Currently in web mod, please use mobile version");
      }
      setState(() {
        switch (field) {
          case 'idImage':
            idImage = result.files.single.bytes?.length;
            break;
          case 'profileImage':
            profileImage = result.files.single.bytes?.length;
            break;
          case 'credentialImage':
            credentialImage = result.files.single.bytes?.length;
            break;
        }
        _updateProgress();
      });
    }
  }

  // Update progress based on selected files
  void _updateProgress() {
    List steps = [];
    if (idImage != null) steps.add(1);
    if (profileImage != null) steps.add(2);
    if (credentialImage != null) steps.add(3);

    setState(() {
      completedSteps = steps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) async {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text("Profile Files Uploaded")),
            );
            await Future.delayed(const Duration(seconds: 3));
            // Navigate to the next page when submission is successful
            context.go('/');
          } else if (state is ProfileUpdateFailed) {
            // Show an error message if submission fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 8,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upload documents',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'All documents shall not exceed 10MB',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      _buildProgressIndicator(),
                      const SizedBox(height: 24),
                      _buildUploadField('ID Image', idImage, 'idImage'),
                      _buildUploadField(
                          'Profile Picture', profileImage, 'profileImage'),
                      _buildUploadField('Education Crediential Image',
                          credentialImage, 'credentialImage'),
                      const Spacer(),
                      BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                        if (state is ProfileUpdating) {
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
                                  profileId = profileId ??
                                      '8d4fa07c-5cfd-43da-bb16-d63e4aba0e91';
                                  BlocProvider.of<ProfileBloc>(context).add(
                                      UpdateProfile(profileId!, {},
                                          files: fileData));
                                }),
                          );
                        }
                        // to return some widget incase all the above fails
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Widget for the upload fields
  Widget _buildUploadField(String label, int? file, String field) {
    return GestureDetector(
      onTap: () => _pickFile(field),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 126, 126, 126)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  const Icon(Icons.photo),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(file != null
                      ? "File length is $file"
                      : 'Upload your file here'),
                  const Spacer(),
                  file != null
                      ? const Icon(Icons.check, color: Colors.green)
                      : const SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Progress Indicator Widget
  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStep(1, 'Id Image'),
        const Expanded(child: Divider()),
        _buildStep(2, 'Profile Picture'),
        const Expanded(child: Divider()),
        _buildStep(3, 'Credential Image'),
      ],
    );
  }

  // Step widget for the progress indicator
  Widget _buildStep(int step, String label) {
    bool isActive = completedSteps.contains(step);
    return Column(
      children: [
        CircleAvatar(
            backgroundColor: Colors.blue,
            child: !isActive
                ? Text(step.toString(),
                    style: const TextStyle(color: Colors.white))
                : const Icon(
                    Icons.check,
                  )),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
