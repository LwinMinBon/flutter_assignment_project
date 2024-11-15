import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/utils/show_snackbar.dart';
import '../../../../core/common/widgets/loading_indicator.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  @override
  void dispose() {
    emailTextEditingController.dispose();
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
                            "Hey, Welcome Back!",
                            style: AppFontStyles.headline3.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                          ).animate().fade().slideY()),
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
                                contentPadding: const EdgeInsets.all(20),
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Email Address is missing.";
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
                                contentPadding: const EdgeInsets.all(20),
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Password is missing.";
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
                                    context.read<AuthBloc>().add(
                                      AuthSignIn(
                                        email: email,
                                        password: password,
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
                                child: const Text("Sign in"),
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
                                  "Don't have an account?",
                                  style: AppFontStyles.body2Regular.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.replaceNamed("/sign_up");
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor:
                                          Theme.of(context).colorScheme.tertiary),
                                  child: const Text("Sign up"),
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
