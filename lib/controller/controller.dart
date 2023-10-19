import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../models/amount.dart';
import '../models/salesman.dart';

class MyNotifier with ChangeNotifier {
  late final CollectionReference salesperson_Ref, sellingInfo_Ref;
  String auth_user = '';
  late DocumentReference df;
  List<SalesMan> usersList = [];
  List<Amount> amountInfoList = [];

  MyNotifier() {
    print('object');
    define();
  }

  setAth_user() {
    auth_user = FirebaseAuth.instance.currentUser!.uid;
    notifyListeners();
  }

  define() async {
    //  storage_Ref = await FirebaseStorage.instance.ref('salesperson');

    salesperson_Ref =
    await FirebaseFirestore.instance.collection('salesperson');
    notifyListeners();
  }

  getsalesperson() async {
    usersList.clear();
    var responseBody =
    await salesperson_Ref.where('auth_user', isEqualTo: auth_user).get();
    responseBody.docs.forEach((element) {
      usersList.add(SalesMan().toUser(element));
    });
    notifyListeners();
  }

  Future<String> addUser(SalesMan user, File? photo) async {
    if (photo != null) {
      var imgname = basename(photo.path);
      var refStorage = FirebaseStorage.instance.ref("images/$imgname");
      await refStorage.putFile(photo);
      user.photo = await refStorage.getDownloadURL();
    }
    user.auth_user = auth_user;
    df = await salesperson_Ref.add(user.toJson());
    usersList.clear();
    getsalesperson();
    notifyListeners();
    return df.id;
  }
  deleteSalesMan(SalesMan user) async {
    if (user.photo != 'none') {
      FirebaseStorage.instance.refFromURL(user.photo!).delete();
    }
    await salesperson_Ref.doc(user.id).delete();
    getsalesperson();
    notifyListeners();
  }
  updatSalesman(SalesMan data) {
    print(data.toJson());
data.auth_user =auth_user;
    salesperson_Ref.doc(data.id).update(data.toJson());
    getsalesperson();
    notifyListeners();
  }


  Future<String> addAmount(Amount amount, String id) async {
    // sellingInfo_Ref =FirebaseFirestore.instance.collection('salesperson').doc(id).collection('sellingInfo');
    df = await FirebaseFirestore.instance
        .collection('salesperson')
        .doc(id)
        .collection('sellingInfo')
        .add(amount.toMap());

    return df.id;
  }

  get_sales_person_And_Amount_Info(String date) async {
    usersList.clear();
    var responseBody = await FirebaseFirestore.instance
        .collectionGroup("sellingInfo")
        .where("amountDate", isEqualTo: date)
        .get();
    print('element.data()');

    responseBody.docs.forEach((element) {
      print(element.id);
    });
    notifyListeners();
  }

  getAllSalesmanWithDate(String date) async {
    amountInfoList.clear();
    await getsalesperson();
    for (var salesperson in usersList) {
      QuerySnapshot sellingInfo = await FirebaseFirestore.instance
          .collection("salesperson")
          .doc(salesperson.id)
          .collection("sellingInfo")
          .where("amountDate", isEqualTo: date)
          .get();
      for (var postDoc in sellingInfo.docs) {
        Amount amount = Amount.no();
        amount = Amount().toAmount(postDoc);
        amount.user = salesperson;
        amountInfoList.add(amount);
        print(amount.user!.name);
      }
    }
    notifyListeners();
  }

  getPersonInfo(String name,String number) async {
    amountInfoList.clear();
    usersList.clear();
    var responseBody =
    await FirebaseFirestore.instance.collection('salesperson').where(
        'name', isEqualTo:name).where('number', isEqualTo:number).get();
    responseBody.docs.forEach((element) {
      usersList.add(SalesMan().toUser(element));
    });
    for (var userdoc in usersList) {
      print(userdoc.id);
      QuerySnapshot sellingInfo = await FirebaseFirestore.instance
          .collection("salesperson")
          .doc(userdoc.id)
          .collection("sellingInfo")
          .get();
      for (var postDoc in sellingInfo.docs) {
        Amount amount = Amount.no();
        amount = Amount().toAmount(postDoc);
        amount.user = userdoc;
        amountInfoList.add(amount);
        print(amount.user!.name);
      }
    }
    notifyListeners();
  }
}
