import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_px/AuthModule/bloc/login%20bloc/login_bloc.dart';
import 'package:flutter_px/AuthModule/bloc/login%20bloc/login_event.dart';
import 'package:flutter_px/AuthModule/bloc/login%20bloc/login_state.dart';
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
      home: LogInScreen(),
    );
  }
}

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreen createState() => _LogInScreen();
}

class _LogInScreen extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _loginData = {};
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
        if (state is Logged) {
          // Navigate to the next page when submission is successful
          context.go('/');
        } else if (state is LoggingFailed) {
          // Show an error message if submission fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      }, child: Builder(builder: (context) {
        return Stack(
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
                child: Form(
                  key: _formKey,
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
                        'Please enter your username and password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password Fields
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "User Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          // use the custom validator or default one
                          if (value == null || value.isEmpty) {
                            return 'Please enter Username'; // default validation message
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _loginData["username"] = value as String;
                        }, // for password fields
                      ),

                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                // Toggle the password visibility
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          // use the custom validator or default one
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password'; // default validation message
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _loginData['password'] = value as String;
                        },
                        obscureText: _isObscure, // for password fields
                      ),

                      const SizedBox(height: 20),

                      // Continue Button
                      BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                        if (state is Logging) {
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
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _formKey.currentState?.save();
                                    // Emit the event to submit the form
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(Login(_loginData));
                                  }
                                }),
                          );
                        }
                        // to return some widget incase all the above fails
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child: Row(
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => {context.go('/profile')},
                              child: const Text(
                                'Create New Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 96, 169, 222),
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
            ),
          ],
        );
      })),
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
