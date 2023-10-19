import 'package:cloud_firestore/cloud_firestore.dart';

class SalesMan {
  String? id;
  String? auth_user;

  String? number;
  String? name;
  String? photo;
  String? main_region;
  String? registeration_date;

  SalesMan(
      {this.id, this.name, this.photo, this.registeration_date, this.main_region, this.number,this.auth_user });

  SalesMan.no();

  SalesMan.withName(this.name);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['auth_user'] = this.auth_user;
    data['number'] = this.number;
    data['main_region'] = this.main_region;
    data['photo'] = this.photo;
    data['registeration_date'] = this.registeration_date;
    return data;
  }

  SalesMan toUser(DocumentSnapshot doc) =>
      SalesMan(
        id: doc.id,
        name: doc.get('name'),
        main_region: doc.get('main_region'),
        number: doc.get('number'),
        photo: doc.get('photo'),
        registeration_date: doc.get('registeration_date'));
}