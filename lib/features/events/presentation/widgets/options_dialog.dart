import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_font_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import 'profile_dialog.dart';

class OptionsDialog extends StatelessWidget {
  const OptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: (){
                DialogNavigator.of(context).push(
                  FluidDialogPage(
                    builder: (context) => const ProfileDialog(),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: _optionItem(
                  context: context,
                  icon: Icons.person_rounded,
                  label: "Profile",
                ),
              ),
            ),
            GestureDetector(
              onTap: (){},
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: _optionItem(
                  context: context,
                  icon: Icons.info_rounded,
                  label: "About",
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(AuthSignOut());
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: _optionItem(
                  context: context,
                  icon: Icons.logout_rounded,
                  label: "Logout",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionItem({
    required BuildContext context,
    required IconData icon,
    required String label,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          label,
          style: AppFontStyles.body1Regular
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        )
      ],
    );
  }
}

