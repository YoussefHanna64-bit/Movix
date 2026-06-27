import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/custom_error_widget.dart';
import 'package:movix/features/home/domain/entities/movie_entity.dart';
import 'package:movix/features/home/presentation/cubit/home_cubit.dart';
import 'package:movix/features/home/presentation/cubit/home_state.dart';
import 'package:movix/features/home/presentation/widgets/movie_card_widget.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});
  @override
  State<StatefulWidget> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final TextEditingController textEditingControllerSearch =
      TextEditingController();

  @override
  void dispose() {
    textEditingControllerSearch.dispose();
    super.dispose();
  }

  String? selectedFilterOption;

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
                      selectedFilterOption == null ||
                      movie.genres.contains(selectedFilterOption))
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
                                  icon: const Icon(Icons.cancel))),
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            final String result = await showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
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
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, "Mystery");
                                              },
                                              child: const Text("Mystery"),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, "Thriller");
                                                },
                                                child: const Text("Thriller")),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            setState(() {
                              selectedFilterOption = result;
                            });
                          },
                          icon: const Icon(Icons.filter_list))
                    ],
                  ),
                  filteredMovies.isEmpty
                      ? const Text("There are no movies that match your search")
                      : Expanded(
                          child: GridView.builder(
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
