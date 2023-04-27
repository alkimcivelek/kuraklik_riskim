import 'package:kuraklik_riskim/constants/application_constants.dart';
import 'package:kuraklik_riskim/services/services.dart';
import 'package:mobx/mobx.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  @observable
  double prediction = 0;

  @action
  Future<void> getPrediction() async {
    dynamic response = await Service.getService(
        ApplicationConstant.API_URL + ApplicationConstant.CITIES_URL);
    // cities = List<CityModel>.from(
    //     response['data'].map((x) => CityModel.fromJson(x)));
  }
}
