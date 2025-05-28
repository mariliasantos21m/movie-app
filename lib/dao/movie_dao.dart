import 'package:movie_app/database/database_helper.dart';

class MovieDao {
  late DatabaseHelper dbHelper;

  MovieDao() {
    dbHelper = DatabaseHelper();
  }
}
