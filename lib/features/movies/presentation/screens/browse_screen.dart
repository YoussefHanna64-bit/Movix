import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/custom_error_widget.dart';
import 'package:movix/features/home/domain/entities/movie_entity.dart';
import 'package:movix/features/home/presentation/cubit/home_cubit.dart';
import 'package:movix/features/home/presentation/cubit/home_state.dart';
import 'package:movix/features/home/presentation/widgets/movie_card_widget.dart';
import 'package:movix/features/movies/domain/enums/movie_category.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});
  @override
  State<StatefulWidget> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final TextEditingController textEditingControllerSearch =
      TextEditingController();
  final ScrollController scrollController = ScrollController();

  void onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      context.read<HomeCubit>().loadNextPage();
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    textEditingControllerSearch.dispose();
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  MovieCategory? selectedMovieCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeError) {
              return CustomErrorWidget(
                  errorMessage: state.errorMessage,
                  onRetry: () => context.read<HomeCubit>().loadHome());
            } else if (state is HomeLoaded) {
              String searchQuery = textEditingControllerSearch.text;

              List<MovieEntity> movies = state.movies;
              List<MovieEntity> filteredMovies = movies
                  .where((movie) =>
                      selectedMovieCategory == null ||
                      movie.genres.contains(selectedMovieCategory!.name))
                  .where((movie) =>
                      searchQuery.isEmpty ||
                      movie.title.toLowerCase().contains(
                          textEditingControllerSearch.text.toLowerCase()))
                  .toList();

              return Column(
                spacing: 8.0,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textEditingControllerSearch,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 30.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            prefixIcon: const Icon(Icons.search),
                            labelText: "Search",
                            suffixIcon: IconButton(
                              onPressed: () {
                                textEditingControllerSearch.clear();
                                setState(() {});
                              },
                              icon: const Icon(Icons.cancel),
                            ),
                          ),
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      Badge(
                        isLabelVisible: selectedMovieCategory != null,
                        label: const Text("1"),
                        offset: const Offset(0, 0),
                        child: IconButton(
                            onPressed: () async {
                              final MovieCategory? result =
                                  await showModalBottomSheet<MovieCategory?>(
                                context: context,
                                builder: (context) {
                                  return SafeArea(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Choose genres",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Wrap(
                                            alignment: WrapAlignment.center,
                                            children: [
                                              for (final movieCategory
                                                  in MovieCategory.values)
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                            selectedMovieCategory ==
                                                                    movieCategory
                                                                ? Colors.white10
                                                                : null),
                                                    onPressed: () {
                                                      if (selectedMovieCategory ==
                                                          movieCategory) {
                                                        selectedMovieCategory =
                                                            null;
                                                        Navigator.pop(context);
                                                      } else {
                                                        Navigator.pop(context,
                                                            movieCategory);
                                                      }
                                                    },
                                                    child: Text(
                                                        movieCategory.name))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              setState(() {
                                selectedMovieCategory =
                                    result ?? selectedMovieCategory;
                              });
                            },
                            icon: const Icon(Icons.filter_list)),
                      )
                    ],
                  ),
                  filteredMovies.isEmpty
                      ? const Text("There are no movies that match your search")
                      : Expanded(
                          child: GridView.builder(
                          controller: scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 1 / 3,
                          ),
                          itemCount: filteredMovies.length,
                          itemBuilder: (context, index) {
                            final MovieEntity movie = filteredMovies[index];
                            return Column(
                              children: [
                                MovieCardWidget(movie: movie),
                                Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            );
                          },
                        ))
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      )),
    );
  }
}
