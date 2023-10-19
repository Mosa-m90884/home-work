import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:home_work/models/salesman.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../controller/controller.dart';
import '../../helpers/customTextFormField.dart';

class AddSalesPerson extends StatefulWidget {
  AddSalesPerson({Key? key, required this.user}) : super(key: key);
  final SalesMan user;

  @override
  State<AddSalesPerson> createState() => _AddSalesPersonState();
}

class _AddSalesPersonState extends State<AddSalesPerson> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController salesPersonNo = TextEditingController();
  TextEditingController salesPersonName = TextEditingController();
  String mainRigion = menueItems[0];
  DateTime registerationDate = DateTime.now();
  File? _salesPersonPhoto;

  static const List<String> menueItems = <String>[
    'Southern region',
    'Coastal region',
    'Northern Region',
    'Eastern Region',
    'Lebanon'
  ];
  final List<DropdownMenuItem<String>> _list1 = menueItems
      .map(
        (e) => DropdownMenuItem<String>(
          child: Text(e),
          value: e,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              widget.user.id != null
                  ? 'تعديل مندوب مبيعات'
                  : 'اضافة مندوب مبيعات',
              style: TextStyle(color: Colors.white),
            )),
        key: _scaffoldKey,
        body: Form(
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
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      'المنطقة الرئيسية:',
                    )),
                Expanded(
                  flex: 1,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    alignment: Alignment.center,
                    underline: Card(),
                    elevation: 5,
                    items: _list1,
                    value: mainRigion,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          mainRigion = val;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(15),
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
              label: Text('Select Image'),
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: showOptions,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: _salesPersonPhoto == null
                    ? widget.user.id != null && widget.user.photo != 'none'
                        ? Container(
                            height: 100,
                            width: 100,
                            child: Image.network(widget.user.photo!))
                        : Text('No Image selected')
                    : Container(
                        height: 100,
                        width: 100,
                        child: Image.file(_salesPersonPhoto!)),
              ),
            ),
            MaterialButton(
              height: 55,
              shape: StadiumBorder(),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
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
                                  if (widget.user.id == null) {
                                    widget.user.photo = 'none';
                                    widget.user.number = salesPersonNo.text;
                                    widget.user.name = salesPersonName.text;
                                    widget.user.main_region = mainRigion;
                                    widget.user.registeration_date =
                                        registerationDate.toString();

                                    Provider.of<MyNotifier>(context,
                                            listen: false)
                                        .addUser(
                                            widget.user, _salesPersonPhoto);
                                  } else {
                                    widget.user.number = salesPersonNo.text;
                                    widget.user.name = salesPersonName.text;
                                    widget.user.main_region = mainRigion;
                                    Provider.of<MyNotifier>(context,
                                            listen: false)
                                        .updatSalesman(widget.user);
                                  }
                                  Navigator.pop(context);
                                },
                                child: Text('ok'))
                          ],
                        );
                      }).then((value) => Navigator.pop(context));
                }
              },
              child: Text(
                widget.user.id == null ? 'اضافة ' : 'تعديل',
                style: TextStyle(color: Colors.white, fontSize: 18),
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
    print(widget.user.id);
    print(widget.user.photo);
    if (widget.user.id != null) {
      salesPersonNo.text = widget.user.number!;
      salesPersonName.text = widget.user.name!;
      mainRigion = widget.user.main_region!;
      // registerationDate = DateTime.now();
      //  if (widget.user.photo != 'none')
      //    _salesPersonPhoto = File.fromUri(Uri(path: widget.user.photo !));
    }
  }

  late MyNotifier controller;

  pickImageFromGallery() {
    ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 25)
        .then((imgFile) async {
      setState(() {
        if (imgFile != null) _salesPersonPhoto = File(imgFile!.path);
      });
    });
  }

  pickImageFromCamera() {
    ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 25)
        .then((imgFile) async {
      setState(() {
        if (imgFile != null) _salesPersonPhoto = File(imgFile!.path);
      });
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              pickImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              pickImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
}
