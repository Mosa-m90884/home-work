import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_work/screen/addSalesMan.dart';
import 'package:home_work/screen/allSalesMen.dart';
import 'package:home_work/screen/salesmanHome.dart';
import 'package:home_work/screen/addSales.dart';
import 'package:home_work/screen/salesMenInSelectedDate.dart';

import '../helpers/colors.dart';
import '../models/salesman.dart';

class HomePage extends StatelessWidget {
  var buttons = [
    'مندوبي المبيعات',
    'اضافة مندوب مبيعات',
    'اضافة  مبيعات',
    'إستعلامات عن مندوبي المبيعات',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent, elevation: 0, actions: []),
        body: ListView(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: Colors.white.withOpacity(0.8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'asset/images/logo.png',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MWS_WMB_S23',
                        style: TextStyle(
                            fontSize: 25,
                            color: freeDelivery,
                            fontWeight: FontWeight.w900,
                            wordSpacing: 25),
                      )
                    ],
                  )
                ],
              )),
          Container(
            padding: EdgeInsets.only(top: 25),
            height: MediaQuery.of(context).size.height * 0.75 - 40,
            color: Colors.indigo.shade50,
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.75 - 150,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: buttons.length,
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                    child: MaterialButton(
                        elevation: 15,
                        height: 55,
                        shape: StadiumBorder(),
                        color: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text(buttons.elementAt(index),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        onPressed: () {
                          switch (index) {
                            case 0:
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AllSalesPerson(),
                                ),
                              );
                              break;

                            case 1:
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddSalesPerson(
                                    user: SalesMan.no(),
                                  ),
                                ),
                              );
                              break;
                            case 3:
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SalesManInfo(),
                                ),
                              );
                              break;
                            case 2:
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddSales(),
                                ),
                              );
                              break;
                          }
                        }),
                  ),
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
