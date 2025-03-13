import 'package:aicaptions/models/generated_captions_model.dart';
import 'package:aicaptions/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:aicaptions/screens/home_screen.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GeneratedHashTagsScreen extends StatelessWidget {
  final GeneratedCaptionModel model;
  const GeneratedHashTagsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              showTrailingIcon: false,
              leadingIcon: LucideIcons.arrowLeft,
              onPressedLeading: () {
                Navigator.pop(context);
              },
              onPressedTrailing: () {},
              title: "Hashtags & Captions",
              trailingIcon: LucideIcons.crown,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14.0),
                children: [
                  Column(
                    children: model.choices?.first.message?.content?.hashtags?.map((hashtags) {
                          return HashtagsContainer(
                            hashtags: hashtags,
                          );
                        }).toList() ??
                        [],
                  ),
                  const Gap(20.0),
                  const CaptionContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
