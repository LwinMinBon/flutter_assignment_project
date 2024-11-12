import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';

void showCustomDialog({
  required BuildContext context,
  required Alignment alignment,
  required Widget content,
}) {
  showDialog(
    context: context,
    builder: (context) => FluidDialog(
      rootPage: FluidDialogPage(
        alignment: alignment,
        builder: (context) => content,
      ),
    ),
  );
}
