// ignore_for_file: file_names, unnecessary_this, prefer_collection_literals

class KontakApp {
  int? id;
  String? name;
  String? mobileNo;
  String? email;
  String? company;
  String? alamat;

  KontakApp(
      {this.id,
      this.name,
      this.mobileNo,
      this.email,
      this.company,
      this.alamat});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['mobileNo'] = mobileNo;
    map['email'] = email;
    map['company'] = company;
    map['alamat'] = alamat;

    return map;
  }

  KontakApp.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.mobileNo = map['mobileNo'];
    this.email = map['email'];
    this.company = map['company'];
    this.alamat = map['alamat'];
  }
}
