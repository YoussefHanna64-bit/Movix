import 'package:flutter/material.dart';
import 'package:movix/core/routes/app_routes.dart';
import 'package:movix/features/home/domain/entities/movie_entity.dart';
import 'package:movix/core/theme/app_colors.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieEntity movie;

  const MovieCardWidget({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.movieDetails,
          arguments: movie.id,
        );
      },
      child: Container(

        width: 180,
        height: 280,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            image: NetworkImage(movie.coverImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 65,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: AppColors.black.withValues(alpha: 0.71),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: AppColors.yellow,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 65,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: AppColors.black.withValues(alpha: 0.71),
                ),
                child: Center(child: Text(movie.year.toString())),
              ),
            )
          ],
        ),
      ),
    );
  }
}
