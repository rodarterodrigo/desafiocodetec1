import 'package:desafio_codetec1/app/modules/home/shared/enums/buttom_style.dart';
import 'package:desafio_codetec1/app/modules/home/shared/widgets/custom_buttom.dart';
import 'package:desafio_codetec1/app/modules/home/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_bloc.dart';

class HomePage extends StatelessWidget {
  final homeBloc = Modular.get<HomeBloc>();
  final TextEditingController nameController = TextEditingController();
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
                    clearTap: () => homeBloc.clearName(nameController),
                    controller: nameController,
                    borderColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.text,
                    labelText: "Nome",
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Sexo",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    DropdownButton<String>(
                      value: homeBloc.selectedGender,
                      items: <String>['Masculino', 'Feminino',].map((String value) => DropdownMenuItem<String>(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Usuário do portal?",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                    Checkbox(value: homeBloc.portalUser,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged:(value) => homeBloc.inputPortalUser(value)),
                  ],
                ),
                CustomButton(
                    onPressed: (){},
                    text: "Cadastrar",
                    buttonStyle: CustomButtonStyle.Primary,
                    isEnable: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}