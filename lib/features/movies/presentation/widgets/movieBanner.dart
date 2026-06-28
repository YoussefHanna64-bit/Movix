import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/movies/domain/entities/movieDetails_entity.dart';
import 'package:movix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:movix/features/profile/presentation/cubit/profile_state.dart';

class MovieBanner extends StatelessWidget {
  final MovieDetailsEntity movie;
  final int movieId;
  final VoidCallback onPlayVideo;

  const MovieBanner({
    super.key, 
    required this.movie, 
    required this.movieId, 
    required this.onPlayVideo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movie.coverImage,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black,
                ],
                stops: const [0.02, 0.25, 0.55, 0.85],
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: onPlayVideo,
              child: Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(width: 5, color: Colors.yellow)),
                child: Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC107),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 40,
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final isBookmarked = context.read<ProfileCubit>().isInWishlist(movieId);
                return IconButton(
                  onPressed: () {
                    context.read<ProfileCubit>().toggleWishlist(movieId);
                  },
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked ? Colors.yellow : Colors.white,
                    size: 40,
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 10,
            top: 40,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 35),
            ),
          ),
          Positioned(
            bottom: 35,
            right: 0,
            left: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  movie.year.toString(),
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}