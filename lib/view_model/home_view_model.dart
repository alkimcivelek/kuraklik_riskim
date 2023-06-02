import 'package:kuraklik_riskim/constants/application_constants.dart';
import 'package:kuraklik_riskim/model/response_model.dart';
import 'package:kuraklik_riskim/services/services.dart';
import 'package:mobx/mobx.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  @observable
  String prediction = "";
  double r2_score = 0;

  @action
  Future<void> getPrediction(String date) async {
    dynamic response = await Service.getService(
        ApplicationConstant.API_URL_PREDICT +
            ApplicationConstant.PREDICT.replaceFirst("parameter", date));
    prediction = response['prediction'].toString();
    r2_score = response['r2'];
    // cities = List<CityModel>.from(
    //     response['data'].map((x) => CityModel.fromJson(x)));
  }
}
