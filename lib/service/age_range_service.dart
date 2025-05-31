import 'package:movie_app/dao/age_range_dao.dart';
import 'package:movie_app/model/age_range_model.dart';

class AgeRangeService {
  final AgeRangeDao _ageRangeDao = AgeRangeDao();

  Future<List<AgeRangeModel>?> findAll() async {
    return await _ageRangeDao.findAll();
  }
}
