import 'package:flutter/material.dart';
import 'package:flutter_px/Common/dropdown.dart';
import '../../Common/button.dart';
import '../../Common/gradient.dart';
// ignore: depend_on_referenced_packages
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _selectedLanguage = 'Amharic';
  final String _initiaLanguage = 'Amharic'; // Default selected language
  final List<String> _languages = ['Amharic', 'English', 'French', 'Spanish'];
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences(); // Initialize SharedPreferences on startup
  }

  // Initialize SharedPreferences and load the saved language
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _saveLanguage(_initiaLanguage);
  }

  // Save the selected language to SharedPreferences
  Future<void> _saveLanguage(String language) async {
    await _prefs.setString('language', language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter:
                  GradientBackgroundPainter(alignment: Alignment.bottomLeft),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Spacer(), // Push the logo to the top
                  Column(
                    children: [
                      // Logo and Text Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            width: 280,
                            height: 280,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // const Spacer(), // Push other elements downward

                  // Language Selection Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomDropdown(
                        initialValue: _initiaLanguage,
                        items: _languages,
                        onChanged: (String? newValue) {
                          // Handle language change here
                          _selectedLanguage = newValue!;
                        },
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 40), // Add some space between dropdown and button

                  // Get Started Button
                  CustomButton(
                    text: 'Get Started',
                    onPressed: () {
                      _saveLanguage(_selectedLanguage);
                      print(_prefs.getString('language'));
                      context.go('/onboarding');
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
