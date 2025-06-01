import 'package:flutter/material.dart';
import 'package:movie_app/app_colors.dart';
import 'package:movie_app/controller/movie_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/model/movie_with_age_range_model.dart';
import 'package:movie_app/view/components/app_bar_custom.dart';
import 'package:movie_app/view/create_movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _movieController = MovieController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Filmes"),
      body: Container(
        color: AppColors.background,
        child: Center(
          child: FutureBuilder(
            future: _movieController.findAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movies = snapshot.data;
                return movies != null && movies.isNotEmpty
                    ? ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return buildItemList(movies[index]);
                      },
                    )
                    : Text(
                      "Nenhum filme encontrado.",
                      style: TextStyle(color: AppColors.subTitle),
                    );
              } else if (snapshot.hasError) {
                return Text(
                  "Error: ${snapshot.error}",
                  style: TextStyle(color: AppColors.subTitle),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CreateMovie();
                  },
                ),
              ).then((value) {
                setState(() {});
              }),
            },
        backgroundColor: AppColors.primary,
        hoverColor: AppColors.primaryDark,
        child: Icon(Icons.add, color: AppColors.text),
      ),
    );
  }

  Widget buildItemList(MovieWithAgeRangeModel movie) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        color: AppColors.card,
        child: ListTile(
          leading: SizedBox(
            height: 100,
            width: 50,
            child: Image.network(
              movie.urlImage,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "images/not_found_image.jpg",
                  fit: BoxFit.fill,
                );
              },
              fit: BoxFit.fill,
            ),
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
