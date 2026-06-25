import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../models/onboarding_model.dart';
import '../widgets/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingModel> _onboardingPages = const [
    OnboardingModel(
      title: 'Find Your Next Favorite Movie Here',
      desc:
          'Get access to a huge library of movies to suit all tastes. You will surely like it.',
      img: 'assets/images/onboarding_image1.png',
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Color(0xcc121312),
          Color(0xff121312),
          Color(0xff121312)
        ],
        stops: [0.0, 0.5, 0.8, 1.0],
      ),
    ),
    OnboardingModel(
      title: 'Discover Movies',
      desc:
          'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      img: 'assets/images/onboarding_image2.png',
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Color(0xcc084250), Color(0xff084250)],
        stops: [0.0, 0.6, 1.0],
      ),
    ),
    OnboardingModel(
      title: 'Explore All Genres',
      desc:
          'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      img: 'assets/images/onboarding_image3.png',
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Color(0xcc85210E), Color(0xff85210E)],
        stops: [0.0, 0.6, 1.0],
      ),
    ),
    OnboardingModel(
      title: 'Create Watchlists',
      desc:
          'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      img: 'assets/images/onboarding_image4.png',
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Color(0xcc4C2471), Color(0xff4C2471)],
        stops: [0.0, 0.6, 1.0],
      ),
    ),
    OnboardingModel(
      title: 'Rate, Review, and Learn',
      desc:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      img: 'assets/images/onboarding_image5.png',
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Color(0xcc601321), Color(0xff601321)],
        stops: [0.0, 0.6, 1.0],
      ),
    ),
    OnboardingModel(
      title: 'Start Watching Now',
      desc: '',
      img: 'assets/images/onboarding_image6.png',
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Color(0xcc2A2C30), Color(0xff2A2C30)],
        stops: [0.0, 0.6, 1.0],
      ),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemCount: _onboardingPages.length,
        itemBuilder: (context, index) {
          final isFirstPage = index == 0;
          final isLastPage = index == _onboardingPages.length - 1;
          final pageData = _onboardingPages[index];

          String primaryText = 'Next';
          if (isFirstPage) {
            primaryText = 'Explore Now';
          } else if (isLastPage) {
            primaryText = 'Finish';
          }

          // Passing the strongly-typed properties directly to your reusable widget
          return OnboardingContent(
            title: pageData.title,
            desc: pageData.desc,
            image: pageData.img,
            gradient: pageData.gradient,
            buttonText: primaryText,
            onButtonTap: () {
              if (isLastPage) {
                Navigator.pushReplacementNamed(context, AppRoutes.layout);
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            },
            secondaryButtonText: isFirstPage ? null : 'Back',
            onSecondaryButtonTap: isFirstPage ? null : () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
          );
        },
      ),
    );
  }
}
