// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  late final _$predictionAtom =
      Atom(name: '_HomeViewModelBase.prediction', context: context);

  @override
  double get prediction {
    _$predictionAtom.reportRead();
    return super.prediction;
  }

  @override
  set prediction(double value) {
    _$predictionAtom.reportWrite(value, super.prediction, () {
      super.prediction = value;
    });
  }

  late final _$getPredictionAsyncAction =
      AsyncAction('_HomeViewModelBase.getPrediction', context: context);

  @override
  Future<void> getPrediction() {
    return _$getPredictionAsyncAction.run(() => super.getPrediction());
  }

  @override
  String toString() {
    return '''
prediction: ${prediction}
    ''';
  }
}
