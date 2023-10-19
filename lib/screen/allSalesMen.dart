import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';
import 'addSalesMan.dart';

class AllSalesPerson extends StatefulWidget {
  const AllSalesPerson({Key? key}) : super(key: key);

  @override
  State<AllSalesPerson> createState() => _AllSalesPersonState();
}

class _AllSalesPersonState extends State<AllSalesPerson> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(backgroundColor: Theme.of(context).primaryColor,title: Text('مندوبي المبيعات')),
          body: Provider<MyNotifier>(
              create: (_) => Provider.of<MyNotifier>(context, listen: false),
              child: Provider.of<MyNotifier>(context, listen: true)
                  .usersList
                  .length==0?Center(child: CircularProgressIndicator()):ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(width: 1, color: Colors.blueGrey.shade200),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Provider.of<MyNotifier>(context, listen: false)
                                      .usersList[index].photo ==
                                  'none'
                              ? CircleAvatar(radius: 50,backgroundColor: Colors.black,
                                  backgroundImage:
                                      AssetImage('asset/images/noimage.png'))
                              : CircleAvatar(radius: 50,
                                  backgroundImage: NetworkImage(scale: 10,
                                      '${Provider.of<MyNotifier>(context, listen: false).usersList[index].photo}')),
                          Column(mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          color: Colors.white,
                                          child: Text(
                                            'المنطقة الرئيسية  ',
                                            style: TextStyle(color: Colors.blue),
                                          )),
                                      Text(
                                          '${Provider.of<MyNotifier>(context, listen: false).usersList[index].main_region}'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          color: Colors.white,
                                          child: Text(
                                            'اسم المندوب  ',
                                            style: TextStyle(color: Colors.blue),
                                          )),
                                      Text(
                                          '${Provider.of<MyNotifier>(context, listen: false).usersList[index].name}'),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        Provider.of<MyNotifier>(context, listen: false).deleteSalesMan(
                                            Provider.of<MyNotifier>(context, listen: false).usersList[index] );
                                      },
                                      child: Text('حذف')),
                                  SizedBox(width: 25,),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddSalesPerson(user:  Provider.of<MyNotifier>(context, listen: false).usersList[index],),
                                          ),
                                        );
                                      },
                                      child: Text('تعديل'))
                                ],)
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: Provider.of<MyNotifier>(context, listen: true)
                      .usersList
                      .length))),
    );
  }

  @override
  void initState() {
    Future(() async {
      await Provider.of<MyNotifier>(context, listen: false).getsalesperson();

    });
  }
}
