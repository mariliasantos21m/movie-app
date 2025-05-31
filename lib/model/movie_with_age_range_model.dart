class MovieWithAgeRangeModel {
  int? id;
  String title;
  String genres;
  String urlImage;
  String ageRangeName;
  String duration;
  double rating;
  int year;
  String description;

  MovieWithAgeRangeModel({
    this.id,
    required this.title,
    required this.genres,
    required this.urlImage,
    required this.ageRangeName,
    required this.duration,
    required this.rating,
    required this.year,
    required this.description,
  });

  factory MovieWithAgeRangeModel.fromMap(Map<String, dynamic> map) {
    return MovieWithAgeRangeModel(
      title: map['title'],
      genres: map['genres'],
      urlImage: map['urlImage'],
      ageRangeName: map['age_range_name'], // coluna retornada pelo JOIN
      duration: map['duration'],
      rating: map['rating'],
      year: map['year'],
      description: map['description'],
    );
  }
}
