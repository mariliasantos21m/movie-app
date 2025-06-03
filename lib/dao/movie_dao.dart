import 'package:movie_app/database/database_helper.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/movie_with_age_range_model.dart';

class MovieDao {
  late DatabaseHelper dbHelper;

  MovieDao() {
    dbHelper = DatabaseHelper();
  }

  Future<List<MovieWithAgeRangeModel>?> findAll() async {
    final db = await dbHelper.initDb();

    try {
      final listMap = await db.rawQuery('''
        SELECT 
          movies.id, 
          movies.title,
          movies.genres,
          movies.url_image,
          age_ranges.name AS age_range_name,
          age_ranges.id AS age_range_id,
          movies.duration,
          movies.rating, 
          movies.year,
          movies.description
        FROM
          movies
          INNER JOIN age_ranges ON age_ranges.id = movies.age_range_id
        ORDER BY 
          movies.title
      ''');
      List<MovieWithAgeRangeModel> movies = [];
      for (var map in listMap) {
        movies.add(MovieWithAgeRangeModel.fromMap(map));
      }

      return movies;
    } catch (e) {
      print(e);
      throw Exception("Erro ao buscar dados.");
    } finally {
      db.close();
    }
  }

  Future<int?> save(MovieModel movieModel) async {
    final db = await dbHelper.initDb();

    try {
      return await db.insert('movies', movieModel.toMap());
    } catch (e) {
      print(e);
      throw Exception("Erro ao salvar dados.");
    } finally {
      db.close();
    }
  }

  Future<void> delete(int id) async {
    final db = await dbHelper.initDb();

    try {
      await db.delete('movies', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
      throw Exception("Erro ao deletar dados.");
    } finally {
      db.close();
    }
  }

  Future<int?> update(int id, MovieModel movie) async {
    final db = await dbHelper.initDb();

    try {
      return await db.update(
        "movies",
        movie.toMap(),
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
      throw Exception("Erro ao atualizar dados.");
    } finally {
      db.close();
    }
  }
}
