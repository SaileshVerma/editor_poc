import 'package:drag_drop_editor_poc/providers/slides.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/create_highlight_screen.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteSlideButtonWidget extends ConsumerWidget {
  final int slidesLength;
  final String slideTempUniqueId;
  final PageController pageController;
  final Color textColor;

  const DeleteSlideButtonWidget({
    required this.slidesLength,
    required this.slideTempUniqueId,
    required this.pageController,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        if (slidesLength <= 1) {
          return;
        }

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete slide'),
            content: const Text('Are you sure, you want to remove this slide?'),
            actionsPadding: const EdgeInsets.symmetric(vertical: 12.0),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    ref.read(createSlideProvider.notifier).deleteSlideFromState(
                          index: ref.read(currentCarouselIndex),
                          slideTempUniqueId: slideTempUniqueId,
                        );

                    //To close the alert dialog box

                    //TODO: update the current Carousel accordingly
                    if (!(ref.read(currentCarouselIndex) == 0)) {
                      ref.read(currentCarouselIndex.notifier).state--;
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    'Remove',
                    style: TextStyle(color: CustomColors.orange400),
                  ))
            ],
          ),
        );
      },
      child: Icon(
        Icons.delete,
        color: textColor,
        size: 30,
      ),
    );
  }
}
