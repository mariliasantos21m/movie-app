import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/movie_with_age_range_model.dart';
import 'package:movie_app/service/movie_service.dart';

class MovieController {
  final _service = MovieService();

  Future<List<MovieWithAgeRangeModel>?> findAll() async {
    return await _service.findAll();
  }

  Future<int?> save(MovieModel movie) async {
    return await _service.save(movie);
  }

  Future<void> delete(int id) async {
    return await _service.delete(id);
  }

  Future<int?> update(int id, MovieModel movie) async {
    return await _service.update(id, movie);
  }
}
