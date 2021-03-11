
class Name {
  String firstName;
  String surname;
  Name([this.firstName, this.surname]);
    
  Name.fromJson(Map<String, dynamic> json) {
    this.firstName = json['firstName'];
    this.surname = json['surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['surname'] = this.surname;
    return data;
  }
}

