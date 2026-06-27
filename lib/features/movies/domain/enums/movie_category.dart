enum MovieCategory {
  Mystery(name: "Mystery"),
  Thriller(name: "Thriller"),
  Documentary(name: "Documentary"),
  Music(name: "Music"),
  Comedy(name: "Comedy"),
  History(name: "History"),
  Action(name: "Action"),
  War(name: "War"),
  Crime(name: "Crime"),
  Drama(name: "Drama"),
  Horror(name: "Horror"),
  Adventure(name: "Adventure"),
  Fantasy(name: "Fantasy"),
  Sci_Fi(name: "Sci-Fi"),
  Romance(name: "Romance");

  const MovieCategory({required this.name});
  final String name;
}
