import 'dart:io';
import 'package:drag_drop_editor_poc/providers/slide_content_images.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends ConsumerStatefulWidget {
  final Color textColor;
  final String uid;

  const ImagePickerButton({
    required this.textColor,
    required this.uid,
    super.key,
  });

  @override
  ConsumerState<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends ConsumerState<ImagePickerButton> {
  late final ImagePicker picker;

  @override
  void initState() {
    picker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          try {
            final pickedImage =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedImage != null) {
              final uploadMediaFile = File(pickedImage.path);

              ref
                  .read(slideImageContentStateProvider(widget.uid).notifier)
                  .addInitialImageToStateList(imageUrl: uploadMediaFile.path);
            }
          } catch (error) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Unable to upload media'),
                ),
              );
            }
          }
        },
        child: Icon(
          Icons.photo,
          size: 30,
          color: widget.textColor,
        ));
  }
}
