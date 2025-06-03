class MovieWithAgeRangeModel {
  int id;
  String title;
  String genres;
  String urlImage;
  String ageRangeName;
  int ageRangeId;
  String duration;
  double rating;
  int year;
  String description;

  MovieWithAgeRangeModel({
    required this.id,
    required this.title,
    required this.genres,
    required this.urlImage,
    required this.ageRangeName,
    required this.ageRangeId,
    required this.duration,
    required this.rating,
    required this.year,
    required this.description,
  });

  factory MovieWithAgeRangeModel.fromMap(Map<String, dynamic> map) {
    return MovieWithAgeRangeModel(
      id: map['id'],
      title: map['title'],
      genres: map['genres'],
      urlImage: map['url_image'],
      ageRangeName: map['age_range_name'],
      ageRangeId: map['age_range_id'],
      duration: map['duration'],
      rating: map['rating'],
      year: map['year'],
      description: map['description'],
    );
  }
}
