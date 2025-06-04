import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/app_colors.dart';
import 'package:movie_app/model/movie_with_age_range_model.dart';
import 'package:movie_app/view/components/app_bar_custom.dart';

class DetailsMovie extends StatelessWidget {
  final MovieWithAgeRangeModel movie;

  const DetailsMovie({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Detalhes"),
      body: Container(
        padding: EdgeInsets.all(12),
        color: AppColors.background,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  movie.urlImage,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "images/not_found_image.jpg",
                      fit: BoxFit.fill,
                    );
                  },
                  width: 100,
                  height: 180,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    movie.year.toString(),
                    style: TextStyle(fontSize: 12, color: AppColors.subTitle),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    movie.genres,
                    style: TextStyle(fontSize: 12, color: AppColors.subTitle),
                  ),
                  Text(
                    "${movie.ageRangeName} anos",
                    style: TextStyle(fontSize: 12, color: AppColors.subTitle),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 8, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie.duration,
                      style: TextStyle(fontSize: 12, color: AppColors.subTitle),
                    ),
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
              Expanded(
                child: Text(
                  movie.description,
                  style: TextStyle(fontSize: 12, color: AppColors.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
