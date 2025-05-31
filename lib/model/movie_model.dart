class MovieModel {
  int? id;
  String title;
  String genres;
  String urlImage;
  int ageRangeId;
  String duration;
  double rating;
  int year;
  String description;

  MovieModel({
    this.id,
    required this.title,
    required this.genres,
    required this.urlImage,
    required this.ageRangeId,
    required this.duration,
    required this.rating,
    required this.year,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'genres': genres,
      'url_image': urlImage,
      'age_range_id': ageRangeId,
      'duration': duration,
      'rating': rating,
      'year': year,
      'description': description,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      title: map['title'],
      genres: map['genres'],
      urlImage: map['urlImage'],
      ageRangeId: map['ageRangeId'],
      duration: map['duration'],
      rating: map['rating'],
      year: map['year'],
      description: map['description'],
    );
  }
}
