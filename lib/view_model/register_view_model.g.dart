// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterViewModel on _RegisterViewModelBase, Store {
  late final _$citiesAtom =
      Atom(name: '_RegisterViewModelBase.cities', context: context);

  @override
  List<CityModel> get cities {
    _$citiesAtom.reportRead();
    return super.cities;
  }

  @override
  set cities(List<CityModel> value) {
    _$citiesAtom.reportWrite(value, super.cities, () {
      super.cities = value;
    });
  }

  late final _$getCitiesAsyncAction =
      AsyncAction('_RegisterViewModelBase.getCities', context: context);

  @override
  Future<void> getCities() {
    return _$getCitiesAsyncAction.run(() => super.getCities());
  }

  @override
  String toString() {
    return '''
cities: ${cities}
    ''';
  }
}
