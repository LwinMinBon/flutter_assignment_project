import 'package:flutter/material.dart';

import '../../theme/app_font_styles.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        content: Text(
          message,
          style: AppFontStyles.body2SemiBold
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
}
