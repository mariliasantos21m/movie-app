import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/app_colors.dart';
import 'package:movie_app/controller/age_range_controller.dart';
import 'package:movie_app/controller/movie_controller.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/movie_with_age_range_model.dart';
import 'package:movie_app/view/components/app_bar_custom.dart';
import 'package:movie_app/view/components/input_form.dart';

class UpdateMovie extends StatefulWidget {
  final MovieWithAgeRangeModel movieUpdate;

  const UpdateMovie({super.key, required this.movieUpdate});

  @override
  State<UpdateMovie> createState() => _UpdateMovieState();
}

class _UpdateMovieState extends State<UpdateMovie> {
  late MovieWithAgeRangeModel _movie = widget.movieUpdate;

  // controllers
  final _ageRangeController = AgeRangeController();
  final _movieController = MovieController();

  // variáveis do form
  final _keyForm = GlobalKey<FormState>();
  late final TextEditingController _inputUrlImage;
  late final TextEditingController _inputTitle;
  late final TextEditingController _inputGenres;
  late int _selectAgeRange;
  late final TextEditingController _inputDuration;
  late double _inputRating = 0.0;
  late final TextEditingController _inputYear;
  late final TextEditingController _inputDescription;

  @override
  void initState() {
    super.initState();
    _movie = widget.movieUpdate; // Aqui você acessa o movieUpdate

    _inputUrlImage = TextEditingController(text: _movie.urlImage);
    _inputTitle = TextEditingController(text: _movie.title);
    _inputGenres = TextEditingController(text: _movie.genres);
    _selectAgeRange = _movie.ageRangeId;
    _inputDuration = TextEditingController(text: _movie.duration);
    _inputRating = _movie.rating;
    _inputYear = TextEditingController(text: _movie.year.toString());
    _inputDescription = TextEditingController(text: _movie.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Editar Filme"),
      body: Container(
        padding: EdgeInsets.all(16),
        color: AppColors.background,
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              InputForm(controller: _inputUrlImage, label: "Url Image"),
              InputForm(controller: _inputTitle, label: "Título"),
              InputForm(controller: _inputGenres, label: "Gênero"),
              Container(
                padding: EdgeInsets.only(bottom: 12, top: 12),
                child: FutureBuilder(
                  future: _ageRangeController.findAll(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final ageRanges = snapshot.data;
                      return ageRanges != null && ageRanges.isNotEmpty
                          ? DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: "Faixa Etária:",
                              labelStyle: TextStyle(
                                color: AppColors.subTitle,
                                fontSize: 20,
                              ),
                              border: InputBorder.none,
                            ),
                            dropdownColor: AppColors.card,
                            value: _selectAgeRange,
                            items:
                                ageRanges.map((item) {
                                  return DropdownMenuItem<int>(
                                    value: item.id,
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                        color: AppColors.subTitle,
                                      ),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectAgeRange = value ?? 0;
                              });
                            },
                          )
                          : Text(
                            "Nenhum resultado encontrado.",
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
              Row(
                children: [
                  Text(
                    "Nota:",
                    style: TextStyle(color: AppColors.subTitle, fontSize: 16),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 12, top: 12, left: 8),
                    child: RatingBar.builder(
                      initialRating: _inputRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      unratedColor: AppColors.card,
                      itemSize: 24,
                      itemBuilder:
                          (context, index) =>
                              Icon(Icons.star, color: AppColors.primary),
                      onRatingUpdate: (rating) {
                        _inputRating = rating;
                      },
                    ),
                  ),
                ],
              ),
              InputForm(controller: _inputDuration, label: "Duração"),
              InputForm(controller: _inputYear, label: "Ano"),
              InputForm(
                controller: _inputDescription,
                label: "Descrição",
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final valid = _keyForm.currentState!.validate();
          if (!valid) return;

          MovieModel movieUpdate = MovieModel(
            title: _inputTitle.text,
            genres: _inputGenres.text,
            urlImage: _inputUrlImage.text,
            ageRangeId: _selectAgeRange,
            duration: _inputDuration.text,
            rating: _inputRating,
            year: int.parse(_inputYear.text),
            description: _inputDescription.text,
          );

          try {
            await _movieController.update(_movie.id, movieUpdate);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Atualização realizada com sucesso')),
            );
            Navigator.pop(context);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro ao atualizar filme: $e')),
            );
          }
        },
        backgroundColor: AppColors.primary,
        hoverColor: AppColors.primaryDark,
        child: Icon(Icons.save, color: AppColors.text),
      ),
    );
  }
}
