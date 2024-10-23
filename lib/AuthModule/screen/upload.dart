import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:flutter_px/Common/button.dart';

class UploadDocumentsScreen extends StatefulWidget {
  @override
  _UploadDocumentsScreenState createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  // Variables to track the selected files for each field
  int? idPassportFile;
  int? credentialsFile;
  int? tradeLicenseFile;

  // Progress tracking (0, 1, 2, or 3)
  int completedSteps = 0;

  // Method to handle file picking
  Future<void> _pickFile(String field) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      print("Suiiiiii");
      setState(() {
        switch (field) {
          case 'idPassport':
            idPassportFile = result.files.single.bytes?.length;
            break;
          case 'credentials':
            credentialsFile = result.files.single.bytes?.length;
            break;
          case 'tradeLicense':
            tradeLicenseFile = result.files.single.bytes?.length;
            break;
        }
        _updateProgress();
      });
    }
  }

  // Update progress based on selected files
  void _updateProgress() {
    int count = 0;
    if (idPassportFile != null) count++;
    if (credentialsFile != null) count++;
    if (tradeLicenseFile != null) count++;

    setState(() {
      completedSteps = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload documents',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'All documents shall not exceed 10MB',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              _buildProgressIndicator(),
              const SizedBox(height: 24),
              _buildUploadField('ID / Passport', idPassportFile, 'idPassport'),
              _buildUploadField('Credentials', credentialsFile, 'credentials'),
              _buildUploadField(
                  'Renewed trade license', tradeLicenseFile, 'tradeLicense'),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    text: 'Back',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomButton(
                    text: 'Next',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
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
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        // child: ListTile(
        //   leading: const Icon(Icons.browse_gallery),
        //   title: Text(label),
        //   subtitle: Text(file != null
        //       ? "Wow $file"
        //       : 'Upload your file here'),
        //   trailing: file != null
        //       ? const Icon(Icons.check, color: Colors.green)
        //       : null,
        // ),
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
                  Icon(Icons.photo),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(file != null ? "Wow $file" : 'Upload your file here'),
                  Spacer(),
                  file != null ?  const Icon(Icons.check, color: Colors.green):  const SizedBox(),
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
        _buildStep(1, 'Business Info'),
        const Expanded(child: Divider()),
        _buildStep(2, 'Business Address'),
        const Expanded(child: Divider()),
        _buildStep(3, 'Upload Document'),
      ],
    );
  }

  // Step widget for the progress indicator
  Widget _buildStep(int step, String label) {
    bool isActive = completedSteps >= step;
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
