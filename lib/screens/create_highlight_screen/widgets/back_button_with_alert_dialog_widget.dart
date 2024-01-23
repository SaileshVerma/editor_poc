import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class BackButtonWithOnClickAlertDialog extends ConsumerWidget {
  final Color textColor;

  const BackButtonWithOnClickAlertDialog({
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(
        Icons.crop_square_sharp,
        color: textColor,
      ),
      onPressed: () {},
    );
  }
}
