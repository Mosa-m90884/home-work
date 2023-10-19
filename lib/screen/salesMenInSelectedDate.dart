import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/controller.dart';
import 'package:flutter/material.dart' show showCupertinoModalPopup;
import '../helpers/dimensions_screen .dart';
import 'package:intl/intl.dart' as format;

class SalesManInfo extends StatefulWidget {
  @override
  _SalesManInfoState createState() => _SalesManInfoState();
}

class _SalesManInfoState extends State<SalesManInfo> {
  DateTime _selectedDate = DateTime.now();
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('مبيعات المندوبين في تاريخ محدد '),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child:
                      Text('اختر السنة والوقت', style: TextStyle(fontSize: 20)),
                ),
                onPressed: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildCupertinoDatePicker();
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${format.DateFormat.yM().format(_selectedDate)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
              ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child:
                        Text('تنفيذ الإستعلام', style: TextStyle(fontSize: 20)),
                  ),
                  onPressed: () async {
                    show = true;

                    await Provider.of<MyNotifier>(context, listen: false)
                        .getAllSalesmanWithDate(
                            format.DateFormat.yM().format(_selectedDate));
                    show = false;
                  }),
              Container(
                height: Screendimensions.screenHeight! * 0.7,
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

  Widget _buildCupertinoDatePicker() {
    return Container(
      height: 250,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.monthYear,
              initialDateTime: _selectedDate,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('اختيار الشهر والسنة'))
        ],
      ),
    );
  }

  @override
  void initState() {
    Provider.of<MyNotifier>(context, listen: false).amountInfoList.clear();
  }
}
