// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/Networks/models/login_model.dart';
import 'package:new_project/blocs/login_bloc/login_event.dart';
import 'package:new_project/screens/first_time_login.dart';
import 'package:new_project/screens/home_screen.dart';
import 'package:new_project/screens/signup_screen.dart';

import '../blocs/login_bloc/login_bloc.dart';
import '../blocs/login_bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusnode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool check = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    emailFocusnode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(249, 250, 251, 1),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/circle.png',
                        // height: 478,
                        // width: 689,
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 15,
                      child: Image.asset(
                        'assets/logos/logo.png',
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log In',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      Text(
                        'Welcome back! Please enter your details',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(71, 84, 103, 1)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Username',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(2, 64, 84, 1)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                color: Color.fromRGBO(16, 24, 40, 0.05),
                                spreadRadius: 1,
                              )
                            ]),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: emailFocusnode,
                          decoration: InputDecoration(
                            constraints: BoxConstraints(
                              maxHeight: 55,
                            ),
                            hintText: 'Enter Your Username',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color.fromRGBO(102, 112, 133, 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(208, 213, 221, 1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(208, 213, 221, 1))),
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(2, 64, 84, 1)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                color: Color.fromRGBO(16, 24, 40, 0.05),
                                spreadRadius: 1,
                              )
                            ]),
                        child: TextFormField(
                          controller: _passwordController,
                          focusNode: passwordFocusNode,
                          obscureText: true,
                          obscuringCharacter: '•',
                          decoration: InputDecoration(
                              constraints: BoxConstraints(
                                maxHeight: 55,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(208, 213, 221, 1))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(208, 213, 221, 1)))),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: check,
                          onChanged: (val) {
                            setState(() {
                              check = val!;
                            });
                          },
                          side: BorderSide(
                            color: Color.fromRGBO(208, 213, 221, 1),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Remember for 30 days',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color.fromRGBO(52, 64, 84, 1)),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FirstTimeLogin()));
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: Color.fromRGBO(89, 37, 220, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: InkWell(
                    onTap: () {
                      context.read<LoginBloc>().add(LoginStartedEvent(
                          LoginModel(_emailController.text.trim(),
                              _passwordController.text.trim(), check))); 
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(105, 56, 239, 1),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Color.fromRGBO(71, 84, 103, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      SizedBox(width: 4),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Color.fromRGBO(89, 37, 220, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
