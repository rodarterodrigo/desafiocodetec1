import 'dart:async';
import 'package:desafio_codetec1/app/modules/models/home_model.dart';
import 'package:desafio_codetec1/app/modules/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeBloc extends Disposable {

  final HomeModel homeModel = HomeModel();

  String _critical = "";
  get critical => _critical;
  set critical(value) => _critical = value;

  bool _isLoading = false;
  get isLoading => _isLoading;
  set isLoading(value) => _isLoading = value;

  final StreamController _streamController = StreamController.broadcast();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void inputLoading(bool value){
    this.isLoading = value;
    input.add(this.isLoading);
  }

  void inputName(String name){
    this.homeModel.name = name;
    this.criticalMessage();
    input.add(this.homeModel);
  }

  void inputSex(String sex){
    this.homeModel.gender = sex;
    this.criticalMessage();
    input.add(homeModel);
  }

  void inputPortalUser(bool value){
    this.homeModel.isPortalUser = value;
    input.add(homeModel);
  }

  void inputReservist(String reservist){
    this.homeModel.reservist = reservist;
    this.criticalMessage();
    input.add(homeModel);
  }

  Future loading() async {
    this.changeLoading();
    Timer(Duration(seconds: 2), () async {
      await Modular.to.pushNamed(Routes.SUCCESSPAGE);
      this.changeLoading();
    });
  }

  void clearName(TextEditingController controller) { controller.clear(); this.homeModel.name = ""; this.criticalMessage(); this.input.add(this.homeModel); }
  void clearReservist(TextEditingController controller) { controller.clear(); this.homeModel.reservist = ""; this.criticalMessage(); this.input.add(this.homeModel); }

  Future commit() async => await loading();

  void changeLoading() {
    this.isLoading = !this.isLoading;
    this.input.add(isLoading);
  }

  @override
  void dispose() {
    _streamController.close();
  }

  void criticalMessage(){
    if (!homeModel.isValidName()) {
      this.critical = "Preencha seu nome";
      this.input.add(this.critical);
      return;
    }

    if (!homeModel.isValidReservist() && homeModel.gender == "M") {
      this.critical = "Preencha o seu número de reservista";
      this.input.add(this.critical);
      return;
    }
    this.critical = "";
  }
}