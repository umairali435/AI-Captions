import 'package:aicaptions/models/generated_captions_model.dart';
import 'package:aicaptions/res/app_colors.dart';
import 'package:aicaptions/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:aicaptions/screens/home_screen.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GeneratedHashTagsScreen extends StatefulWidget {
  final GeneratedCaptionModel model;
  const GeneratedHashTagsScreen({super.key, required this.model});

  @override
  State<GeneratedHashTagsScreen> createState() =>
      _GeneratedHashTagsScreenState();
}

class _GeneratedHashTagsScreenState extends State<GeneratedHashTagsScreen> {
  int _selectedIndex = 0;
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      _selectedIndex = 0;
                      setState(() {});
                    },
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0
                            ? AppColors.primaryColor
                            : AppColors.blackColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Gap(20.0),
                          Text(
                            "Hashtags",
                            style: TextStyle(
                              color: _selectedIndex == 0
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                              fontSize: 16.0,
                            ),
                          ),
                          const Gap(20.0),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _selectedIndex = 1;
                      setState(() {});
                    },
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.blackColor,
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Gap(20.0),
                          Text(
                            "Captions",
                            style: TextStyle(
                              color: _selectedIndex == 1
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                              fontSize: 16.0,
                            ),
                          ),
                          const Gap(20.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14.0),
                children: [
                  _selectedIndex == 0
                      ? Column(
                          children: widget.model.choices?.first.message?.content
                                  ?.hashtags
                                  ?.map((hashtags) {
                                return HashtagsContainer(
                                  hashtags: hashtags,
                                );
                              }).toList() ??
                              [],
                        )
                      : Column(
                          children: widget.model.choices?.first.message?.content
                                  ?.captions
                                  ?.map((cap) {
                                return CaptionContainer(
                                  caption: cap.captions.toString(),
                                );
                              }).toList() ??
                              [],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
