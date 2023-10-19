import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/controller.dart';
import '../helpers/colors.dart';
import '../helpers/customTextFormField.dart';
import 'package:flutter/material.dart' show showCupertinoModalPopup;
import '../helpers/dimensions_screen .dart';
import 'package:intl/intl.dart' as format;

class SalesManHome extends StatefulWidget {
  @override
  _SalesManHomeState createState() => _SalesManHomeState();
}

class _SalesManHomeState extends State<SalesManHome> {
  bool show = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController salesPersonNo = TextEditingController();
  TextEditingController salesPersonName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: brandingColor,
          title: Text('عرض معلومات مبيعاتك '),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Screendimensions.screenHeight! * 0.35,
                child: Form(
                  key: _formKey,
                  child: ListView(padding: EdgeInsets.all(15), children: [
                    CustomTextFormField(
                        controller: salesPersonNo,
                        valdiate: true,
                        labelText: 'رقم المندوب',
                        keyboardType: TextInputType.number),
                    CustomTextFormField(
                        controller: salesPersonName,
                        valdiate: true,
                        labelText: 'اسم المندوب'),
                    MaterialButton(
                        height: 55,
                        shape: StadiumBorder(),
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text('عرض المعلومات',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              show = true;
                            });
                            await Provider.of<MyNotifier>(context,
                                    listen: false)
                                .getPersonInfo(
                                    salesPersonName.text, salesPersonNo.text);
                            show = false;
                          }
                        }),
                  ]),
                ),
              ),
              Container(
                height: Screendimensions.screenHeight! * 0.5,
                color: Colors.white,
                child: Provider<MyNotifier>(
                  create: (_) => Provider.of<MyNotifier>(context, listen: true),
                  child: show == true
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 10 / 6,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15),
                              itemCount:
                                  Provider.of<MyNotifier>(context, listen: true)
                                      .amountInfoList
                                      .length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Container(
                                  padding: EdgeInsets.all(14),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Salesperson Number: '),
                                          Text(
                                              '${Provider.of<MyNotifier>(context, listen: false).amountInfoList[index].user!.number} '),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(' Salesperson Name: '),
                                          Text(
                                              '${Provider.of<MyNotifier>(context, listen: false).amountInfoList[index].user!.name} '),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Month/Year'),
                                          Text(
                                              '${Provider.of<MyNotifier>(context, listen: false).amountInfoList[index].amountDate} '),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Southern region'),
                                          Text(
                                              '${Provider.of<MyNotifier>(context, listen: false).amountInfoList[index].amount_for_Southern_Region} SYP'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Coastal region'),
                                          Text(
                                              '${Provider.of<MyNotifier>(context, listen: false).amountInfoList[index].amount_for_Coastal_Region} SYP'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Northern Region'),
                                          Text(
                                              '${Provider.of<MyNotifier>(context, listen: false).amountInfoList[index].amount_for_Northern_Region} SYP'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Eastern Region'),
                                          Text(
                                              '${Provider.of<MyNotifier>(context, listen: false).amountInfoList[index].amount_for_Eastern_Region} SYP'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Lebanon'),
                                          Text(
                                              '${Provider.of<MyNotifier>(context, listen: false).amountInfoList[index].amount_for_Lebanon} SYP'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Monthly commission'),
                                          Text(
                                              '${Provider.of<MyNotifier>(context, listen: false).amountInfoList[index].comissionAmount} SYP'),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Provider.of<MyNotifier>(context, listen: false).amountInfoList.clear();
  }
}
