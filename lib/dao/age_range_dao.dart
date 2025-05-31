import 'package:movie_app/database/database_helper.dart';
import 'package:movie_app/model/age_range_model.dart';
import 'package:movie_app/model/movie_with_age_range_model.dart';

class AgeRangeDao {
  late DatabaseHelper dbHelper;

  AgeRangeDao() {
    dbHelper = DatabaseHelper();
  }

  Future<List<AgeRangeModel>?> findAll() async {
    final db = await dbHelper.initDb();

    try {
      final listMap = await db.query('age_ranges');
      List<AgeRangeModel> ageRangeList = [];
      for (var map in listMap) {
        ageRangeList.add(AgeRangeModel.fromMap(map));
      }

      return ageRangeList;
    } catch (e) {
      print(e);
    } finally {
      db.close();
    }
  }
}
