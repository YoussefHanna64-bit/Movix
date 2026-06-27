import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/theme/app_colors.dart';
import 'package:movix/core/widgets/custom_error_widget.dart';
import 'package:movix/features/home/presentation/widgets/movie_card_widget.dart';
import 'package:movix/features/home/presentation/cubit/home_cubit.dart';
import 'package:movix/features/home/presentation/cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _currentBgImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeError) {
            return CustomErrorWidget(
                errorMessage: state.errorMessage,
                onRetry: () => context.read<HomeCubit>().loadHome());
          } else if (state is HomeLoaded) {
            final allMovies = state.movies;
            final actionMovies = state.actionMovies;
            if (_currentBgImage == null && allMovies.isNotEmpty) {
              _currentBgImage = allMovies[0].coverImage;
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: _currentBgImage != null && _currentBgImage!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(_currentBgImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
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
                    children: [
                      Image.asset(
                        'assets/images/Available Now.png',
                        width: 260,
                        height: 80,
                      ),
                      const SizedBox(height: 16),
                      if (allMovies.isNotEmpty)
                        CarouselSlider.builder(
                          itemCount: allMovies.length,
                          options: CarouselOptions(
                            height: 280,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.5,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentBgImage = allMovies[index].coverImage;
                              });
                            },
                          ),
                          itemBuilder: (context, index, realIndex) {
                            return MovieCardWidget(movie: allMovies[index]);
                          },
                        ),
                      Image.asset(
                        'assets/images/Watch Now.png',
                        height: 90,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Text(
                              'Action',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
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
                                const Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.yellow,
                                  size: 15,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (actionMovies.isNotEmpty)
                        CarouselSlider.builder(
                          itemCount: actionMovies.length,
                          options: CarouselOptions(
                            height: 280,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.5,
                          ),
                          itemBuilder: (context, index, realIndex) {
                            return MovieCardWidget(movie: actionMovies[index]);
                          },
                        ),
                      const SizedBox(height: 40),
                    ],
                  )),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
