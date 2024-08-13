// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:new_project/Networks/models/register_model.dart';
import 'package:new_project/blocs/register_bloc/register_event.dart';
import 'package:new_project/resources/routes.dart';
import 'package:new_project/resources/ui_utils.dart';
import 'package:new_project/screens/login_screen.dart';

import '../blocs/register_bloc/register_bloc.dart';
import '../blocs/register_bloc/register_state.dart';
import '../resources/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showSuccessMessage(state.successMessage);
          context.go(Routes.login);
        }
        if (state is RegisterFailed) {
          showErrorMessage(state.message);
        }
      },
      builder: (context, state) {
        final bloc = context.read<RegisterBloc>();

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
                        'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      Text(
                        'Email*',
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
                          controller: bloc.emailController,
                          onChanged: (value) {
                            bloc.add(RegisterTextFieldChangedEvent());
                          },
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
                                    color: Color.fromRGBO(208, 213, 221, 1))),
                          ),
                        ),
                      ),
                      (state is RegisterEmailErrorState)
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: RegularText(state.message, 15, kRed600),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Password*',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(2, 64, 84, 1)),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
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
                    controller: bloc.passwordController,
                    onChanged: (value) {
                      bloc.add(RegisterTextFieldChangedEvent());
                    },
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
                              color: Color.fromRGBO(208, 213, 221, 1))),
                    ),
                  ),
                ),
                (state is RegisterPasswordErrorState)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: RegularText(state.message, 15, kRed600),
                      )
                    : SizedBox.shrink(),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: (state is RegisterLoading)
                      ? Center(child: CircularProgressIndicator())
                      : InkWell(
                          onTap: () {
                            context.read<RegisterBloc>().add(
                                RegisterStartedEvent(RegisterModel(
                                    bloc.emailController.text.trim(),
                                    bloc.passwordController.text)));
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kPrimary600,
                            ),
                            child: Center(
                              child: Text(
                                'Sign Up',
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
                        "Already have an account?",
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
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Login',
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
