import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final String title;
  final String desc;
  final String image;
  final String buttonText;
  final VoidCallback onButtonTap;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonTap;
  final Gradient gradient;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.desc,
    required this.image,
    required this.buttonText,
    required this.onButtonTap,
    this.secondaryButtonText,
    this.onSecondaryButtonTap,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          left: 24.0,
                          right: 24.0,
                          top: 48.0,
                          bottom: 48.0,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: SafeArea(
                          top: false,
                          bottom: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 16),
                              if (desc.isNotEmpty) ...[
                                Text(
                                  desc,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: onButtonTap,
                                child: Text(buttonText),
                              ),
                              if (secondaryButtonText != null) ...[
                                const SizedBox(height: 16),
                                OutlinedButton(
                                  onPressed: onSecondaryButtonTap,
                                  child: Text(secondaryButtonText!),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
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
