import 'package:flutter/material.dart';
import 'package:movix/features/home/domain/entities/movie_entity.dart';
import 'package:movix/features/home/presentation/widgets/movie_card_widget.dart';

class ProfileMovieList extends StatelessWidget {
  final List<MovieEntity> movies;
  final String emptyLabel;
  final IconData emptyIcon;

  const ProfileMovieList(
      {super.key,
      required this.movies,
      required this.emptyLabel,
      required this.emptyIcon});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(emptyIcon, color: Colors.white24, size: 64),
            const SizedBox(height: 16),
            Text(emptyLabel,
                style: const TextStyle(color: Colors.white38, fontSize: 16)),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) => MovieCardWidget(movie: movies[index]),
    );
  }
}
