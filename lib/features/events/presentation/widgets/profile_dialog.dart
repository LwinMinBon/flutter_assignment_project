import 'package:eventify/core/common/cubits/app_user_cubit.dart';
import 'package:eventify/core/common/widgets/loading_indicator.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_font_styles.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<AppUserCubit, AppUserState>(
              builder: (context, state) {
                if (state is AppUserSignedIn) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.appUserEntity.username,
                        style: AppFontStyles.headline4
                            .copyWith(color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        state.appUserEntity.email,
                        style: AppFontStyles.body1Regular.copyWith(
                          color: Theme.of(context).colorScheme.secondary
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        state.appUserEntity.phoneNumber,
                        style: AppFontStyles.body1Regular.copyWith(
                            color: Theme.of(context).colorScheme.secondary
                        ),
                      )
                    ],
                  );
                }
                return const LoadingIndicator();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    foregroundColor: Theme.of(context).colorScheme.onTertiary,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Edit",
                    style: AppFontStyles.buttonMedium,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () => DialogNavigator.of(context).pop(),
                  child: const Text(
                    "Back",
                    style: AppFontStyles.buttonMedium,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
