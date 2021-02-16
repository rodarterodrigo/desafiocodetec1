class HomeModel{
  String name;
  String gender;
  bool isPortalUser;
  String reservist;

  HomeModel({this.name = "", this.gender = "Masculino", this.isPortalUser = false, this.reservist = ""});

  @override
  String toString(){
    return '{ ${this.name}, ${this.gender}, ${this.isPortalUser}, ${this.reservist} }';
  }

  bool isValidName() => this.name.isNotEmpty;
  bool isValidReservist() => this.reservist.isNotEmpty;
  bool isValidForm() => this.isValidName() && ((this.isValidReservist() && this.gender == "Masculino") || (!this.isValidReservist() && this.gender == "Feminino"));
}