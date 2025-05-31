import 'package:movie_app/model/age_range_model.dart';
import 'package:movie_app/service/age_range_service.dart';

class AgeRangeController {
  final _ageRangeService = AgeRangeService();

  Future<List<AgeRangeModel>?> findAll() {
    return _ageRangeService.findAll();
  }
}
