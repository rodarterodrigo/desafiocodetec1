import 'package:desafio_codetec1/app/modules/home/home_page.dart';
import 'package:desafio_codetec1/app/modules/routes/app_routes.dart';
import 'package:desafio_codetec1/app/modules/success_page/success_page.dart';
import 'home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Routes.HOME, child: (context, args) => HomePage()),
        ModularRouter(Routes.SUCCESSPAGE, child: (context, args) => SuccessPage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}