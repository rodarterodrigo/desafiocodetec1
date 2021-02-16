import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:desafio_codetec1/app/modules/models/home_model.dart';
import 'package:desafio_codetec1/app/modules/routes/app_routes.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeBloc extends Disposable {
  Directory rootPath;
  FileTileSelectMode filePickerSelectMode = FileTileSelectMode.checkButton;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController reservistController = TextEditingController();

  HomeModel homeModel = HomeModel();

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

  Future<void> openFile(BuildContext context) async {
    rootPath = await getApplicationDocumentsDirectory();
    String path = await FilesystemPicker.open(
      title: 'Open file',
      context: context,
      rootDirectory: rootPath,
      fsType: FilesystemType.file,
      folderIconColor: Colors.teal,
      allowedExtensions: ['.pdf'],
      fileTileSelectMode: filePickerSelectMode,
      requestPermission: () async =>
      await Permission.storage.request().isGranted,
    );

    if (path != null) {
      File file = File('$path');
      List<int> bytes = file.readAsBytesSync();
      String base64file = base64Encode(bytes);

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(base64file)));
    }
  }

  void clearName(TextEditingController controller) { controller.clear(); this.homeModel.name = ""; this.criticalMessage(); this.input.add(this.homeModel); }
  void clearReservist(TextEditingController controller) { controller.clear(); this.homeModel.reservist = ""; this.criticalMessage(); this.input.add(this.homeModel); }
  void clearForm(){
    this.homeModel = new HomeModel();
    nameController.clear();
    reservistController.clear();
    this.criticalMessage();
  }

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