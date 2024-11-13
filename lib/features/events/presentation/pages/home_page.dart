import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/utils/show_dialog.dart';
import '../../../../core/common/utils/show_snackbar.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../widgets/options_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        leading: IconButton(
          onPressed: () {
            showCustomDialog(
              context: context,
              alignment: Alignment.topLeft,
              content: const OptionsDialog(),
            );
          },
          icon: const Icon(Icons.more_vert_rounded),
        ),
        centerTitle: true,
        title: const Text(
          "Eventify",
          style: AppFontStyles.headline4,
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showSnackBar(context, "Signing out from the account...");
          }
          if (state is AuthSignOutSuccess) {
            showSnackBar(context, "Successfully signed out from the account.");
          }
          if (state is AuthFailure) {
            showSnackBar(context, state.errorMessage);
          }
        },
        child: const Column(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          bottom: 20,
        ),
        child: FloatingActionButton(
          onPressed: () {
            context.pushNamed("/create_event");
          },
          foregroundColor: Theme.of(context).colorScheme.onTertiary,
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          child: const Icon(
            Icons.add_rounded,
          ),
        ),
      ),
    );
  }
}
