import 'package:flutter/material.dart';
import 'package:movie_app/app_colors.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final List<MovieModel> mockMovies = [
    MovieModel(
      id: 1,
      title: 'A Jornada do Herói',
      genres: 'Aventura',
      urlImage:
          'https://img.freepik.com/vetores-gratis/amor-em-paris_23-2147506097.jpg?semt=ais_hybrid&w=740',
      ageRangeId: 2,
      duration: "1h 20min",
      rating: 4.7,
      year: 2023,
      description:
          'Um jovem camponês descobre que está destinado a salvar seu reino de uma força sombria.',
    ),
    MovieModel(
      id: 2,
      title: 'No Limite do Medo',
      genres: 'Terror',
      urlImage:
          'https://img.freepik.com/vetores-gratis/amor-em-paris_23-2147506097.jpg?semt=ais_hybrid&w=740',
      ageRangeId: 4,
      duration: "2h 10min",
      rating: 3.9,
      year: 2022,
      description:
          'Durante um fim de semana isolado, um grupo de amigos descobre que não estão sozinhos.',
    ),
    MovieModel(
      id: 3,
      title: 'Amor em Paris',
      genres: 'Romance',
      urlImage:
          'https://img.freepik.com/vetores-gratis/amor-em-paris_23-2147506097.jpg?semt=ais_hybrid&w=740',
      ageRangeId: 1,
      duration: '2h 20min',
      rating: 4.2,
      year: 2021,
      description:
          'Dois estranhos se encontram em Paris e descobrem que o amor pode surgir onde menos se espera.',
    ),
  ];
  @override
  void initialState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Filmes",
          style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.info, color: AppColors.text),
          ),
        ],
        backgroundColor: AppColors.background,
      ),
      body: Container(
        color: AppColors.background,
        child: Center(
          child: ListView.builder(
            itemCount: mockMovies.length,
            itemBuilder: (context, index) {
              return buildItemList(mockMovies[index]);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: AppColors.primary,
        hoverColor: AppColors.primaryDark,
        child: Icon(Icons.add, color: AppColors.text),
      ),
    );
  }

  Widget buildItemList(MovieModel movie) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: AppColors.card,
        child: ListTile(
          leading: SizedBox(
            height: double.infinity,
            child: Image.network(movie.urlImage, fit: BoxFit.cover),
          ),
          title: Container(
            padding: EdgeInsetsDirectional.only(bottom: 5.0),
            child: Text(
              movie.title,
              style: TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(bottom: 5.0),
                child: Text(
                  movie.genres,
                  style: TextStyle(color: AppColors.subTitle, fontSize: 12),
                ),
              ),
              Text(
                movie.duration,
                style: TextStyle(color: AppColors.subTitle, fontSize: 12),
              ),
              SizedBox(width: 20, height: 20),
              RatingBarIndicator(
                rating: movie.rating,
                itemBuilder:
                    (context, index) =>
                        Icon(Icons.star, color: AppColors.primary),
                itemCount: 5,
                itemSize: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
