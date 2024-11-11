import 'package:eventify/core/theme/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

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
      ),
      body: SafeArea(
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
                  style: AppFontStyles.headline3
                      .copyWith(color: Theme.of(context).colorScheme.primary),
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
                    style: AppFontStyles.body1Regular
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                    cursorColor: Theme.of(context).colorScheme.primary,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.mail,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      hintText: "Email Address",
                      hintStyle: AppFontStyles.body1Regular.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary)),
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
                    style: AppFontStyles.body1Regular
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                    cursorColor: Theme.of(context).colorScheme.primary,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: AppFontStyles.body1Regular.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary)),
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
                        formKey.currentState!.validate();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
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
                            color: Theme.of(context).colorScheme.secondary),
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
      )),
    );
  }
}
