import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_strength/password_strength.dart';

import '../../../../core/common/utils/show_snackbar.dart';
import '../../../../core/common/widgets/loading_indicator.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../bloc/auth_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailTextEditingController = TextEditingController();
  final usernameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();

  @override
  void dispose() {
    emailTextEditingController.dispose();
    usernameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: LoadingIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Let's Get Started",
                          style: AppFontStyles.headline3.copyWith(
                              color: Theme.of(context).colorScheme.primary),
                        ).animate().fade().slideY(),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailTextEditingController,
                              style: AppFontStyles.body1Regular.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                              cursorColor: Theme.of(context).colorScheme.primary,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(
                                      Icons.mail,
                                      color:
                                      Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                  hintText: "Email Address",
                                  hintStyle: AppFontStyles.body1Regular.copyWith(
                                      color:
                                      Theme.of(context).colorScheme.secondary),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer)),
                                  contentPadding: const EdgeInsets.all(20)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email address is missing.";
                                } else if (value.length < 10) {
                                  return "Email address can't be less than 10 characters long.";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: passwordTextEditingController,
                              style: AppFontStyles.body1Regular.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                              cursorColor: Theme.of(context).colorScheme.primary,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(
                                      Icons.lock,
                                      color:
                                      Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                  hintText: "Password",
                                  hintStyle: AppFontStyles.body1Regular.copyWith(
                                      color:
                                      Theme.of(context).colorScheme.secondary),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer)),
                                  contentPadding: const EdgeInsets.all(20)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password is missing.";
                                } else {
                                  double strength = estimatePasswordStrength(value);
                                  if (strength < 0.3) {
                                    return "Password is weak.";
                                  }
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: usernameTextEditingController,
                              style: AppFontStyles.body1Regular.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                              cursorColor: Theme.of(context).colorScheme.primary,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(
                                      Icons.person,
                                      color:
                                      Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                  hintText: "Username",
                                  hintStyle: AppFontStyles.body1Regular.copyWith(
                                      color:
                                      Theme.of(context).colorScheme.secondary),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .errorContainer)),
                                  contentPadding: const EdgeInsets.all(20)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Username is missing.";
                                } else if (value.length < 3) {
                                  return "Username can't be less than 3 characters long.";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: phoneNumberTextEditingController,
                              style: AppFontStyles.body1Regular.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                              cursorColor: Theme.of(context).colorScheme.primary,
                              obscureText: true,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Icon(
                                    Icons.phone,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                hintText: "Phone Number",
                                hintStyle: AppFontStyles.body1Regular.copyWith(
                                    color: Theme.of(context).colorScheme.secondary),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .errorContainer)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .errorContainer)),
                                contentPadding: const EdgeInsets.all(20),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Phone Number is missing.";
                                } else if (value.length < 8) {
                                  return "Phone number can't be less than 8 numbers long.";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ).animate().fade().slideY(),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    final email =
                                    emailTextEditingController.text.trim();
                                    final password =
                                    passwordTextEditingController.text.trim();
                                    final userName =
                                    usernameTextEditingController.text.trim();
                                    final phoneNumber =
                                    phoneNumberTextEditingController.text
                                        .trim();
                                    context.read<AuthBloc>().add(
                                      AuthSignUp(
                                        email: email,
                                        password: password,
                                        userName: userName,
                                        phoneNumber: phoneNumber,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
                                  foregroundColor:
                                  Theme.of(context).colorScheme.onTertiary,
                                  textStyle: AppFontStyles.buttonMedium,
                                ),
                                child: const Text("Sign up"),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: AppFontStyles.body2Regular.copyWith(
                                      color:
                                      Theme.of(context).colorScheme.secondary),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.replaceNamed("/sign_in");
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor:
                                      Theme.of(context).colorScheme.tertiary),
                                  child: const Text("Sign in"),
                                )
                              ],
                            )
                          ],
                        ).animate().fade().slideY(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
