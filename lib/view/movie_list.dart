import 'package:flutter/material.dart';
import 'package:movie_app/app_colors.dart';
import 'package:movie_app/controller/movie_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/model/movie_with_age_range_model.dart';
import 'package:movie_app/view/components/app_bar_custom.dart';
import 'package:movie_app/view/create_movie.dart';
import 'package:movie_app/view/update_movie.dart';

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
                        return Dismissible(
                          key: Key(movies[index].id.toString()),
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Colors.redAccent[700],
                            height: 100,
                            child: Icon(Icons.delete, color: AppColors.text),
                          ),
                          onDismissed: (direction) async {
                            try {
                              await _movieController.delete(movies[index].id);

                              setState(() {
                                movies.removeAt(index);
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Filme removido com sucesso.'),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro ao remover o filme: $e'),
                                ),
                              );
                            }
                          },
                          direction: DismissDirection.endToStart,
                          child: buildItemList(movies[index]),
                        );
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
          onTap: () {
            menuBottom(movie);
          },
        ),
      ),
    );
  }

  Future<void> menuBottom(MovieWithAgeRangeModel movieTarget) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: AppColors.card,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Exibir Dados',
                  style: TextStyle(color: AppColors.text),
                ),
                onTap: () {
                  print("exibir");
                },
              ),
              ListTile(
                title: Text('Alterar', style: TextStyle(color: AppColors.text)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UpdateMovie(movieUpdate: movieTarget);
                      },
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
