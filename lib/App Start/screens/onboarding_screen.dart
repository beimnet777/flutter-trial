import 'package:flutter/material.dart';
import 'package:flutter_px/Common/footer.dart';
// ignore: depend_on_referenced_packages
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/button.dart';

class MyNewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  SharedPreferences? _prefs;

  @override
  void initState() {
    _initSharedPreferences();
    super.initState();
    // Initialize SharedPreferences on startup
  }

  // Initialize SharedPreferences and load the saved language
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveVariable(String name, String value) async {
    await _prefs?.setString(name, value);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                buildPage(
                  image: 'assets/Onboarding 2.png',
                  title: "Empower Yourself with Digital Tasks",
                  subtitle:
                      "Join a community of contributors and earn supplemental income by completing simple digital tasks.",
                ),
                buildPage(
                  image: 'assets/Onboarding 2.png',
                  title: "Simple Tasks, Real Rewards",
                  subtitle:
                      "Complete tasks using your smartphone at your convenience",
                ),
                buildPage(
                  image: 'assets/Onboarding 2.png',
                  title: "Get Ready to Start Earning",
                  subtitle:
                      "Set up your profile, verify your identity, and choose the types of tasks you want to complete. You're just a few steps away from earning your first income",
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: _currentPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              );
            }),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              CustomButton(
                text: "Get Started",
                backgroundColor: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  _saveVariable("status", "completed");
                  context.go('/login'); // Navigate to login screen
                },
              ),
              const SizedBox(height: 10),
              if (_currentPage < 2)
                TextButton(
                  onPressed: () {
                    _pageController.jumpToPage(2);
                  },
                  child: const Text("Skip", style: TextStyle(fontSize: 16)),
                ),
              const SizedBox(height: 10),
              const CutsomFooter()
            ],
          ),

          // stack children ends here
        ],
      ),
    );
  }

  Widget buildPage(
      {required String image,
      required String title,
      required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 250),
            const SizedBox(height: 40),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
