import 'package:flutter/material.dart';
import 'package:flutter_px/Common/footer.dart';
import '../../Common/button.dart';
import '../../Common/gradient.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreatePasswordScreen(),
    );
  }
}

class CreatePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Platform Logo and Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/PlatformX_logo.png', // Ensure the logo is added to assets
                        width: 160,
                        height: 160,
                      ),
                    ],
                  ),
                  // const SizedBox(height: 40),

                  // Title
                  const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'This password is used when you log in for the second time',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Fields
                  const PasswordField(hintText: 'Password'),
                  const SizedBox(height: 16),
                  const PasswordField(hintText: 'Confirm Password'),
                  const SizedBox(height: 20),

                  // Continue Button
                  CustomButton(
                    text: "Continue",
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {
                      context.go('/profile');
                    },
                  ),
                  const SizedBox(height: 10,),
                   Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: [ const Text(
                      'Don\'t have an account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                     GestureDetector(
                      onTap: () => {
                        context.go('/profile')
                      },
                       child: const Text(
                        'Create New Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color:Color.fromARGB(255, 96, 169, 222),
                        ),
                                           ),
                     ),
                    ],
                    ),
                  ),
                 
                  const Spacer(),

                  // Powered by Text
                  const CutsomFooter()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final String hintText;
  const PasswordField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }
}
