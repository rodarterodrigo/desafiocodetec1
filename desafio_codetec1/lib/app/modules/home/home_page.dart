import 'package:desafio_codetec1/app/modules/home/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_bloc.dart';

class HomePage extends StatelessWidget {
  final homeBloc = Modular.get<HomeBloc>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: homeBloc.output,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Desafio Codetec1")),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    borderColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.text,
                    labelText: "Nome",
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Sexo"),
                    DropdownButton<String>(
                      value: homeBloc.selectedGender,
                      items: <String>['Masculino', 'Feminino',].map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      )).toList(),
                      onChanged: (value) => homeBloc.inputSex(value),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Usuário do portal?"),
                    Checkbox(value: homeBloc.portalUser,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged:(value) => homeBloc.inputPortalUser(value)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
