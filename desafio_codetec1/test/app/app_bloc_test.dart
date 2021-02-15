import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_codetec1/app/app_module.dart';

import '../../lib/app/app_bloc.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(AppModule());
  AppBloc bloc;

  // setUp(() {
  //     bloc = AppModule.to.get<AppBloc>();
  // });

  // group('AppBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<AppBloc>());
  //   });
  // });
}
