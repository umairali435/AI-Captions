import 'package:aicaptions/bloc/api_bloc.dart';
import 'package:aicaptions/models/hastags_catption_model.dart';
import 'package:aicaptions/res/app_colors.dart';
import 'package:aicaptions/res/app_constants.dart';
import 'package:aicaptions/screens/generated_hashtags.dart';
import 'package:aicaptions/services/url_launcher_service.dart';
import 'package:aicaptions/widgets/copy_button.dart';
import 'package:aicaptions/widgets/custom_button.dart';
import 'package:aicaptions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _statusMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Hashtags & Captions",
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        leading: PopupMenuButton<String>(
          icon: const Icon(
            LucideIcons.settings,
            color: AppColors.whiteColor,
          ),
          onSelected: (value) async {
            if (value == 'privacy_policy') {
              await UrlLauncherService.launchURL(
                  "https://aihashtaggenerator.blogspot.com/2024/02/ai-hashtag-generator.html");
            } else if (value == 'support') {
              await UrlLauncherService.launchURL(
                  "https://aihashtaggenerator.blogspot.com/2025/03/ai-caption-hashtags-support.html");
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'privacy_policy',
                child: Text('Privacy Policy'),
              ),
              const PopupMenuItem(
                value: 'support',
                child: Text('Support'),
              ),
            ];
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14.0),
                children: [
                  const Gap(20.0),
                  CustomTextField(
                    controller: _controller,
                    hintText: "Enter any category",
                  ),
                  const Gap(20.0),
                  CategoryList(
                    onCategorySelected: (value) => _controller.text = value,
                  ),
                  const Gap(20.0),
                  BlocConsumer<ApiBloc, ApiState>(
                    listener: (context, state) {
                      if (state is ApiError) {
                        setState(() {
                          _statusMessage = '';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
                      }
                      if (state is ApiLoaded) {
                        setState(() {
                          _statusMessage = '';
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GeneratedHashTagsScreen(
                              model: state.data,
                            ),
                          ),
                        );
                      }
                      if (state is ApiLoading) {
                        setState(() {
                          _statusMessage = 'Gathering information...';
                        });
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomButton(
                            isLoading: state is ApiLoading,
                            label: "Generate",
                            onTap: () {
                              context.read<ApiBloc>().add(
                                    FetchDataEvent(
                                      AppConstants.prompt(
                                        category: _controller.text.trim(),
                                      ),
                                    ),
                                  );
                            },
                          ),
                          const Gap(10.0),
                          if (_statusMessage.isNotEmpty)
                            Text(
                              _statusMessage,
                              style:
                                  const TextStyle(color: AppColors.whiteColor),
                            ),
                        ],
                      );
                    },
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

class CategoryList extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryList({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final categories = [
      '💪 Fitness',
      '🌅 Nature',
      '🍔 Food',
      '🏙️ City',
      '🏖️ Travel',
      '🐾 Pets',
      '📚 Books',
    ];

    return SizedBox(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                onCategorySelected(categories[index]);
              },
              child: Chip(
                color: const WidgetStatePropertyAll(AppColors.secondaryColor),
                label: Text(
                  categories[index],
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HashtagsContainer extends StatelessWidget {
  final Hashtags? hashtags;
  const HashtagsContainer({super.key, required this.hashtags});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          CopyButton(
            onTap: () async {
              Clipboard.setData(
                      ClipboardData(text: hashtags?.hashtags?.join(" ") ?? ""))
                  .then((_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                }
              });
            },
          ),
          const Gap(10.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: hashtags?.hashtags?.map((hashtags) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFF626060).withOpacity(0.5),
                    ),
                    child: Text(
                      hashtags,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 12.0,
                      ),
                    ),
                  );
                }).toList() ??
                [],
          ),
        ],
      ),
    );
  }
}

class CaptionContainer extends StatelessWidget {
  final String caption;
  const CaptionContainer({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          CopyButton(
            onTap: () {
              Clipboard.setData(ClipboardData(text: caption)).then((_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                }
              });
            },
          ),
          const Gap(10.0),
          Text(
            caption,
            style: const TextStyle(color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }
}
