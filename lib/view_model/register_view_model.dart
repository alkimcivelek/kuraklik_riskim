import 'package:kuraklik_riskim/constants/application_constants.dart';
import 'package:kuraklik_riskim/model/city_model.dart';
import 'package:kuraklik_riskim/services/services.dart';
import 'package:mobx/mobx.dart';
part 'register_view_model.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

abstract class _RegisterViewModelBase with Store {
  @observable
  List<CityModel> cities = [];

  @action
  Future<void> getCities() async {
    dynamic response = await Service.getService(
        ApplicationConstant.API_URL + ApplicationConstant.CITIES_URL);
    cities =
        response.data.map((e) => CityModel.fromJson(response.data)).toList();
  }
}
