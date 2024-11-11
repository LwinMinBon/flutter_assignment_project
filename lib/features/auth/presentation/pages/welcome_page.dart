import 'package:eventify/core/theme/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SvgPicture.asset(
                    Theme.of(context).brightness == Brightness.dark ?
                      "assets/images/welcome_dark.svg" : "assets/images/welcome_light.svg",
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ).animate()
                      .fade()
                      ,
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Eventify",
                    style: AppFontStyles.headline3.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 40),
                    textAlign: TextAlign.center,
                  ).animate()
                    .fade()
                    .scale(),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "An event management solution for event organizers.",
                    style: AppFontStyles.body1Regular
                        .copyWith(color: Theme.of(context).colorScheme.onSurface),
                    textAlign: TextAlign.center,
                  ).animate()
                    .fade()
                    .slideY(),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SegmentedButtonSlide(
                  selectedEntry: selectedOption,
                  onChange: (selected) {
                    setState(() => selectedOption = selected);
                    if (selectedOption == 0) {
                      context.pushNamed("/sign_in");
                    } else {
                      context.pushNamed("/sign_up");
                    }
                  },
                  entries: const [
                    SegmentedButtonSlideEntry(
                      label: "Login",
                    ),
                    SegmentedButtonSlideEntry(
                      label: "Signup",
                    ),
                  ],
                  colors: SegmentedButtonSlideColors(
                    barColor: Theme.of(context)
                        .colorScheme
                        .surfaceContainer,
                    backgroundSelectedColor:
                    Theme.of(context).colorScheme.primary,
                  ),
                  height: 60,
                  borderRadius: BorderRadius.circular(100),
                  selectedTextStyle: AppFontStyles.buttonLarge.copyWith(
                      color: Theme.of(context).colorScheme.surface
                  ),
                  unselectedTextStyle: AppFontStyles.buttonLarge.copyWith(
                      color: Theme.of(context).colorScheme.primary
                  )
              ),
            ).animate()
              .fade()
              .slideY(),
            const Spacer(),
            Text(
                "@2024 Lwin Min Bhone",
              style: AppFontStyles.footnoteSemibold.copyWith(
                color: Theme.of(context).colorScheme.secondary
              ),
            ).animate()
              .fade()
              .scale(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}