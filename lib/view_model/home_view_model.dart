import 'package:kuraklik_riskim/constants/application_constants.dart';
import 'package:kuraklik_riskim/model/response_model.dart';
import 'package:kuraklik_riskim/services/services.dart';
import 'package:mobx/mobx.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  @observable
  double? prediction;
  // double? r2score;

  @action
  Future<ResponseModel> getPrediction(String date) async {
    try {
      dynamic response = await Service.getService(
          ApplicationConstant.API_URL_PREDICT +
              ApplicationConstant.PREDICT.replaceFirst("parameter", date),
          null);
      prediction = double.parse(response['predicted_dam_occ_rate'].toString());
      // r2score = response['r2'];
      return ResponseModel(message: "İşlem başarılı!", status: true);
    } catch (e) {
      return ResponseModel(
          message: "Lütfen geçerli bir tarih giriniz.", status: false);
    }
  }

  @action
  Future<void> getVisualization(String date) async {
    dynamic response = await Service.getService(
        ApplicationConstant.API_URL_PREDICT + ApplicationConstant.VISUALIZE,
        "image/png");
    prediction = double.parse(response['prediction']);
    // r2score = response['r2'];
    // cities = List<CityModel>.from(
    //     response['data'].map((x) => CityModel.fromJson(x)));
  }
}
