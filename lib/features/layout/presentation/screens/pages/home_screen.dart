import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movix/core/theme/app_colors.dart';
import 'package:movix/features/layout/presentation/screens/widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<MovieCardWidget> _mockMovies = [
    MovieCardWidget(
      imagePath: 'assets/images/onboarding_image1.png',
      rating: '7.7',
    ),
    MovieCardWidget(
      imagePath: 'assets/images/onboarding_image2.png',
      rating: '8.2',
    ),
    MovieCardWidget(
      imagePath: 'assets/images/onboarding_image3.png',
      rating: '9.0',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/onboarding_image1.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xaa121312),
                      Color(0xff121312),
                      Color(0xff121312)
                    ],
                    stops: [0.0, 0.5, 0.91, 1.0],
                  )),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Image.asset(
                        'assets/images/Available Now.png',
                        width: 260,
                        height: 90,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 280,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.5,
                        ),
                        items: _mockMovies, // Direct and clean!
                      ),
                      SizedBox(height: 10),
                      Image.asset(
                        'assets/images/Watch Now.png',
                        width: 265,
                        height: 90,
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Action',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'See More',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.yellow,
                                  size: 15,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 280,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.5,
                        ),
                        items: _mockMovies,
                      ),
                    ],
                  ))),
        ));
  }
}
