import 'package:desafio_codetec1/app/modules/shared/enums/buttom_style.dart';
import 'package:desafio_codetec1/app/modules/shared/widgets/custom_buttom.dart';
import 'package:desafio_codetec1/app/modules/shared/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_bloc.dart';

class HomePage extends StatelessWidget {

  final homeBloc = Modular.get<HomeBloc>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reservistController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    homeBloc.criticalMessage();
    return StreamBuilder(
      stream: homeBloc.output,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Desafio Codetec1")),
        ),
        body: homeBloc.isLoading? Center(child: CircularProgressIndicator()): SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: CustomTextField(
                              onChanged: (value) => homeBloc.inputName(value),
                              suffixIcon: Icon(Icons.clear),
                              clearTap: () => homeBloc.clearName(nameController),
                              controller: nameController,
                              borderColor: homeBloc.homeModel.isValidName()? Theme.of(context).accentColor: Theme.of(context).errorColor,
                              keyboardType: TextInputType.text,
                              labelText: "Nome",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sexo",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: homeBloc.homeModel.gender,
                                  items: <String>['M', 'F',].map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20
                                      ),
                                    ),
                                  )).toList(),
                                  onChanged: (value) => homeBloc.inputSex(value),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Usuário do portal?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor
                                  ),
                                ),
                                Checkbox(value: homeBloc.homeModel.isPortalUser,
                                    activeColor: Theme.of(context).primaryColor,
                                    onChanged:(value) => homeBloc.inputPortalUser(value)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: AnimatedOpacity(
                              opacity: homeBloc.homeModel.gender == "F"? 0: 1,
                              duration: Duration(milliseconds: 800),
                              child: CustomTextField(
                                onChanged: (value) => homeBloc.inputReservist(value),
                                suffixIcon: Icon(Icons.clear),
                                clearTap: () => homeBloc.clearReservist(reservistController),
                                controller: reservistController,
                                borderColor: homeBloc.homeModel.isValidReservist()? Theme.of(context).accentColor: Theme.of(context).errorColor,
                                keyboardType: TextInputType.text,
                                labelText: "Nº Reservista",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: AnimatedOpacity(
                              opacity: homeBloc.homeModel.isValidForm()? 0: 1,
                              duration: Duration(milliseconds: 800),
                              child: Text(
                                homeBloc.critical,
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      onPressed: () async => await homeBloc.commit(),
                      text: "Cadastrar",
                      buttonStyle: CustomButtonStyle.Primary,
                      isEnable: homeBloc.homeModel.isValidForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}