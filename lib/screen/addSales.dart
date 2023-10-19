import 'package:intl/intl.dart' as format;
import 'package:flutter/material.dart';
import '../models/amount.dart';
import '../models/salesman.dart';
import 'package:provider/provider.dart';
import '../../controller/controller.dart';
import '../../helpers/customTextFormField.dart';

class AddSales extends StatefulWidget {
  AddSales({Key? key}) : super(key: key);

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  double comissionAmount = 0;
  TextEditingController amount_for_Southern_Region =
      TextEditingController(text: '0');
  TextEditingController amount_for_Coastal_Region =
      TextEditingController(text: '0');
  TextEditingController amount_for_Northern_Region =
      TextEditingController(text: '0');
  TextEditingController amount_for_Eastern_Region =
      TextEditingController(text: '0');
  TextEditingController amount_for_Lebanon = TextEditingController(text: '0');
  SalesMan? selUser;
  DateTime amountDate = DateTime.now();

  List<DropdownMenuItem<SalesMan>>? _users;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 100;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'اضافة  مبيعات',
              style: TextStyle(color: Colors.white),
            )),
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: ListView(padding: EdgeInsets.all(15), children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      'اسم المندوب:',
                    )),
                Expanded(
                  flex: 1,
                  child: DropdownButton<SalesMan>(
                    isExpanded: true,
                    hint: Text('اختيار مندوب مبيعات'),
                    alignment: Alignment.center,
                    underline: Card(),
                    elevation: 5,
                    items: _users,
                    value: selUser,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          selUser = val;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('المنطقة الرئيسية'),
                      Text(
                          selUser != null
                              ? '${selUser!.main_region}'
                              : 'لم يتم اختيار اسم',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Center(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Container(
                          height: 100,
                          width: 100,
                          child: selUser != null && selUser!.photo != 'none'
                              ? Image.network('${selUser!.photo}')
                              : Image.asset('asset/images/noimage.png')),
                    ],
                  )),
                ],
              ),
            ),
            CustomTextFormField(
                controller: amount_for_Coastal_Region,
                valdiate: true,
                labelText: '  مبيعا ت المنطقة الساحلية',
                keyboardType: TextInputType.number),
            CustomTextFormField(
                keyboardType: TextInputType.number,
                controller: amount_for_Eastern_Region,
                valdiate: true,
                labelText: ' مبيعا ت المنطقة الشرقية'),
            CustomTextFormField(
                keyboardType: TextInputType.number,
                controller: amount_for_Southern_Region,
                valdiate: true,
                labelText: ' مبيعا ت المنطقة الجنوبية'),
            CustomTextFormField(
                keyboardType: TextInputType.number,
                controller: amount_for_Northern_Region,
                valdiate: true,
                labelText: '   مبيعا ت المنطقة الشمالية'),
            CustomTextFormField(
                keyboardType: TextInputType.number,
                controller: amount_for_Lebanon,
                valdiate: true,
                labelText: 'مبيعا ت منطقة لبنان'),
            MaterialButton(
              height: 55,
              shape: StadiumBorder(),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Amount amount = Amount(
                    amount_for_Coastal_Region:
                        double.parse(amount_for_Coastal_Region.text),
                    amount_for_Eastern_Region:
                        double.parse(amount_for_Eastern_Region.text),
                    amount_for_Lebanon: double.parse(amount_for_Lebanon.text),
                    amount_for_Northern_Region:
                        double.parse(amount_for_Northern_Region.text),
                    amount_for_Southern_Region:
                        double.parse(amount_for_Southern_Region.text),
                  );

                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          alignment: Alignment.center,
                          title: Text(
                              textAlign: TextAlign.right,
                              'هل تريد إضافة المعلومات التالية؟'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('cancel')),
                            TextButton(
                                onPressed: () async {
                                  amount.comissionAmount =
                                      calc(selUser!.main_region!);
                                  amount.amountDate = format.DateFormat.yM()
                                      .format(DateTime.now());
                                  await Provider.of<MyNotifier>(context,
                                          listen: false)
                                      .addAmount(amount, selUser!.id!);
                                  Navigator.pop(context);
                                },
                                child: Text('ok'))
                          ],
                        );
                      });
                }
              },
              child: Text('حساب العمولة وتخزين معلومات البيع ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('العمولة: ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue)),
                      Text(
                        '${comissionAmount} ',
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void initState() {
    super.initState();

    controller = Provider.of<MyNotifier>(context, listen: false);
    Future(() async {
      await Provider.of<MyNotifier>(context, listen: false).getsalesperson();
      define();
    });
  }

  late MyNotifier controller;

  define() {
    _users = controller.usersList.map((item) {
      return DropdownMenuItem<SalesMan>(
        child: Text(item.name!),
        value: item,
      );
    }).toList();
    setState(() {});
  }

  double calc(String mainRegion) {
    comissionAmount = 0;
    double mainAmount = 0;
    double otherAmount = 0;
    switch (mainRegion) {
      case 'Southern region':
        mainAmount = double.parse(amount_for_Southern_Region.text);
        comissionAmount = mainComission(mainAmount) +
            otherComission(double.parse(amount_for_Lebanon.text)) +
            otherComission(double.parse(amount_for_Northern_Region.text)) +
            otherComission(double.parse(amount_for_Eastern_Region.text)) +
            otherComission(double.parse(amount_for_Coastal_Region.text));
        print(comissionAmount);

        break;
      case 'Coastal region':
        mainAmount = double.parse(amount_for_Coastal_Region.text);
        comissionAmount = mainComission(mainAmount) +
            otherComission(double.parse(amount_for_Lebanon.text)) +
            otherComission(double.parse(amount_for_Northern_Region.text)) +
            otherComission(double.parse(amount_for_Eastern_Region.text)) +
            otherComission(double.parse(amount_for_Southern_Region.text));
        print(comissionAmount);
        break;
      case 'Northern Region':
        mainAmount = double.parse(amount_for_Northern_Region.text);
        comissionAmount = mainComission(mainAmount) +
            otherComission(double.parse(amount_for_Lebanon.text)) +
            otherComission(double.parse(amount_for_Southern_Region.text)) +
            otherComission(double.parse(amount_for_Eastern_Region.text)) +
            otherComission(double.parse(amount_for_Coastal_Region.text));
        print(comissionAmount);
        break;
      case 'Lebanon':
        mainAmount = double.parse(amount_for_Lebanon.text);
        comissionAmount = mainComission(mainAmount) +
            otherComission(double.parse(amount_for_Eastern_Region.text)) +
            otherComission(double.parse(amount_for_Northern_Region.text)) +
            otherComission(double.parse(amount_for_Eastern_Region.text)) +
            otherComission(double.parse(amount_for_Coastal_Region.text));
        print(comissionAmount);
        break;
      case 'Eastern Region':
        mainAmount = double.parse(amount_for_Eastern_Region.text);
        comissionAmount = mainComission(mainAmount) +
            otherComission(double.parse(amount_for_Lebanon.text)) +
            otherComission(double.parse(amount_for_Northern_Region.text)) +
            otherComission(double.parse(amount_for_Southern_Region.text)) +
            otherComission(double.parse(amount_for_Coastal_Region.text));
        print(comissionAmount);
        break;
    }
    setState(() {});
    return comissionAmount;
  }

  double otherComission(double x) {
    if (x > 1000000) {
      double y = x;

      x = 1000000 * 0.03 + (y - 1000000) * 0.04;
    } else {
      x = x * 0.03;
    }
    return x;
  }

  double mainComission(double x) {
    if (x > 1000000) {
      double y = x;
      x = 1000000 * 0.05 + (y - 1000000) * 0.07;
    } else {
      x = x * 0.05;
    }
    return x;
  }
}
