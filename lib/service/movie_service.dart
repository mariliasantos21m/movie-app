import 'package:movie_app/dao/movie_dao.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/movie_with_age_range_model.dart';

class MovieService {
  final _movieDao = MovieDao();

  Future<List<MovieWithAgeRangeModel>?> findAll() async {
    return await _movieDao.findAll();
  }

  Future<int?> save(MovieModel movie) async {
    await _movieDao.save(movie);
  }

  Future<void> delete(int id) async {
    await _movieDao.delete(id);
  }

  Future<int?> update(int id, MovieModel movie) async {
    return await _movieDao.update(id, movie);
  }
}
