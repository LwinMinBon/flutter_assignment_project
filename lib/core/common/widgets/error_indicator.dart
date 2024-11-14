import 'package:flutter/material.dart';

import '../../theme/app_font_styles.dart';

class ErrorIndicator extends StatelessWidget {
  final String errorMessage;

  const ErrorIndicator({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 40,
          color: Theme.of(context).colorScheme.error,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          errorMessage,
          style: AppFontStyles.body2SemiBold.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
