import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/home/domain/entities/movie_entity.dart';
import 'package:movix/features/home/presentation/widgets/movie_card_widget.dart';
import 'package:movix/features/movies/domain/entities/movieDetails_entity.dart';
import 'package:movix/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:movix/features/movies/presentation/cubit/movies_state.dart';
import 'package:movix/features/movies/presentation/widgets/castCard.dart';
import 'package:movix/features/movies/presentation/widgets/movieBanner.dart';
import 'package:movix/features/movies/presentation/widgets/screenShots.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../widgets/statCard.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsEntity? movieDetail;
  int? movieId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (movieId == null) {
      movieId = ModalRoute.of(context)?.settings.arguments as int?;
      if (movieId != null) {
        context.read<MoviesCubit>().loadMovieDetails(movieId!);
        context.read<ProfileCubit>().addMovieToHistory(movieId!);
      }
    }
  }

  Future<void> _playVideo(String? ytTrailerCode) async {
    if (ytTrailerCode == null || ytTrailerCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Video not available for now")),
      );
      return;
    }

    final videoID = ytTrailerCode.trim();
    final url = Uri.parse("https://www.youtube.com/watch?v=$videoID");
    
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open YouTube")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open YouTube")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<MoviesCubit, MoviesState>(
        listener: (context, state) {
          if (state is MovieDetailsLoaded) {
            setState(() {
              movieDetail = state.movie;
            });
          }
        },
        builder: (context, state) {
          if (state is MovieDetailsLoading || movieId == null) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.yellowAccent));
          } else if (state is MovieDetailsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 60),
                    const SizedBox(height: 16),
                    const Text(
                      "Something went wrong while loading movie details. Please try again later.",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Go Back"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (movieDetail == null) return const SizedBox();

          return SingleChildScrollView(
            child: Column(
              children: [
                ///image banner
                MovieBanner(
                  movie: movieDetail!,
                  movieId: movieId!,
                  onPlayVideo: () => _playVideo(movieDetail!.ytTrailerCode),
                ),

                ///Watch button
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () => _playVideo(movieDetail!.ytTrailerCode),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: const Text(
                      "Watch",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                ///Data buttons (Horizontal)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatCard(
                        icon: Icons.favorite,
                        statName: movieDetail!.likeCount.toString()),
                    StatCard(
                        icon: Icons.access_time_filled,
                        statName: "${movieDetail!.filmTime}"),
                    StatCard(
                        icon: Icons.star,
                        statName: movieDetail!.rating.toString()),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                ///Screenshots
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Screenshots",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        movieDetail!.screenshots.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: movieDetail!.screenshots.length,
                                itemBuilder: (context, index) {
                                  return ScreenShots(
                                      image: movieDetail!.screenshots[index]);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                              )
                            : const Center(
                                child: Text("No Screenshots available", style: TextStyle(color: Colors.grey))),
                      ],
                    )),

                ///Similar Movies
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Similar",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      movieDetail!.similarMovies.isNotEmpty
                          ? GridView.builder(
                              itemCount: movieDetail!.similarMovies.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20.0,
                                crossAxisSpacing: 20.0,
                                childAspectRatio: 189 / 279,
                              ),
                              itemBuilder: (context, index) {
                                MovieEntity movie = MovieEntity(
                                    id: movieDetail!.similarMovies[index].id,
                                    title: "",
                                    rating: movieDetail!
                                        .similarMovies[index].rating,
                                    backgroundImage: movieDetail!
                                        .similarMovies[index].coverImg,
                                    coverImage: movieDetail!
                                        .similarMovies[index].coverImg,
                                    mpaRating: "",
                                    genres: []);
                                return MovieCardWidget(movie: movie);
                              })
                          : const Center(
                              child: Text(
                                "Not Available for now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                    ],
                  ),
                ),

                ///Summary
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Summary",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        movieDetail!.summary,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),

                ///Cast
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Cast",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      movieDetail!.cast.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: movieDetail!.cast.length,
                              itemBuilder: (context, index) {
                                return CastCard(cast: movieDetail!.cast[index]);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            )
                          : const Center(
                              child: Text("No Cast available", style: TextStyle(color: Colors.grey))),
                    ],
                  ),
                ),

                ///Genres
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Genres",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      movieDetail!.genres.isNotEmpty
                          ? GridView.builder(
                              itemCount: movieDetail!.genres.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 20.0,
                                childAspectRatio: 122 / 36,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 122,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusGeometry.circular(8),
                                    color: Colors.grey[800],
                                  ),
                                  child: Center(
                                      child: Text(
                                    movieDetail!.genres[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                                );
                              })
                          : const Center(
                              child: Text(
                                "Not Available for now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
