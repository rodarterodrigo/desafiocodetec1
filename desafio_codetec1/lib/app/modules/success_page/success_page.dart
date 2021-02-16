import 'package:desafio_codetec1/app/modules/home/home_bloc.dart';
import 'package:desafio_codetec1/app/modules/shared/enums/buttom_style.dart';
import 'package:desafio_codetec1/app/modules/shared/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
class SuccessPage extends StatelessWidget {
  final homeBloc = Modular.get<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Dados cadastrados com sucesso!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(onPressed: () { homeBloc.clearForm(); Modular.to.pop(); }, text: "Cadastrar novamente", buttonStyle: CustomButtonStyle.Primary, isEnable: true,),
                    CustomButton(onPressed: () => Modular.to.pop(), text: "Voltar", buttonStyle: CustomButtonStyle.Secondary, isEnable: true,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
