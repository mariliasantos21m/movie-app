import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/app_colors.dart';
import 'package:movie_app/model/age_range_model.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/view/components/app_bar_custom.dart';
import 'package:movie_app/view/components/input_form.dart';

class CreateMovie extends StatefulWidget {
  const CreateMovie({super.key});

  @override
  State<CreateMovie> createState() => _CreateMovieState();
}

class _CreateMovieState extends State<CreateMovie> {
  final _keyForm = GlobalKey<FormState>();
  final _inputUrlImage = TextEditingController();
  final _inputTitle = TextEditingController();
  final _inputGenres = TextEditingController();
  int _selectAgeRange = 1;
  final _inputDuration = TextEditingController();
  double _inputRating = 0.0;
  final _inputYear = TextEditingController();
  final _inputDescription = TextEditingController();

  final List<AgeRangeModel> ageRangeMock = [
    AgeRangeModel(id: 1, name: "teste 1", value: 1),
    AgeRangeModel(id: 2, name: "teste 2", value: 1),
    AgeRangeModel(id: 3, name: "teste 3", value: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Cadastrar Filme"),
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
                child: DropdownButtonFormField<int>(
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
                      ageRangeMock.map((item) {
                        return DropdownMenuItem<int>(
                          value: item.id,
                          child: Text(
                            item.name,
                            style: TextStyle(color: AppColors.subTitle),
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectAgeRange = value ?? 0;
                    });
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
        onPressed: () {
          final valid = _keyForm.currentState!.validate();
          if (!valid) return;

          MovieModel movieNew = MovieModel(
            title: _inputTitle.text,
            genres: _inputGenres.text,
            urlImage: _inputUrlImage.text,
            ageRangeId: _selectAgeRange,
            duration: _inputDuration.text,
            rating: _inputRating,
            year: int.parse(_inputYear.text),
            description: _inputDescription.text,
          );

          print(movieNew);
        },
        backgroundColor: AppColors.primary,
        hoverColor: AppColors.primaryDark,
        child: Icon(Icons.save, color: AppColors.text),
      ),
    );
  }
}
