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
    print("CHAMADA DAO");

    try {
      final listMap = await db.rawQuery('''
        SELECT 
          movies.id, 
          movies.title,
          movies.genres,
          movies.url_image,
          age_ranges.name,
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
      print("list Map DAO");
      List<MovieWithAgeRangeModel> movies = [];
      for (var map in listMap) {
        movies.add(MovieWithAgeRangeModel.fromMap(map));
      }

      return movies;
    } catch (e) {
      print(e);
      return null;
    } finally {
      db.close();
      print("finallyyyyy");
    }
  }

  Future<int?> save(MovieModel movieModel) async {
    final db = await dbHelper.initDb();

    try {
      return await db.insert('movies', movieModel.toMap());
    } catch (e) {
      return null;
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
    } finally {
      db.close();
    }
  }

  Future<int?> update(int id, MovieModel movie) async {
    final db = await dbHelper.initDb();

    try {
      return await db.update(
        "movie",
        movie.toMap(),
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
      return null;
    } finally {
      db.close();
    }
  }
}
