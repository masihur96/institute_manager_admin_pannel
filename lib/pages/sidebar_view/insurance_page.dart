import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/model/data_model/insurance_request_model.dart';
import 'package:intl/intl.dart';
import 'package:institute_manager_admin_pannel/controller/firebase_provider.dart';
import 'package:institute_manager_admin_pannel/controller/public_provider.dart';
import 'package:institute_manager_admin_pannel/model/data_model/sub_category_model.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/fading_circle.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/form_decoration.dart';

import 'package:provider/provider.dart';

class InsurancePage extends StatefulWidget {
  @override
  _InsurancePageState createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage> {
  bool _isLoading = false;

  final _ktabs = <Tab>[
    const Tab(text: 'Pending Request'),
    const Tab(
      text: 'Transferred Request',
    ),
  ];

  var searchTextController = TextEditingController();
  var searchTextControllerForTransferred = TextEditingController();
  List<InsuranceModel> _subList = [];
  List<InsuranceModel> _filteredList = [];

  List<InsuranceModel> _transferredSubList = [];
  List<InsuranceModel> _transferredFilteredList = [];

  int counter = 0;
  customInit(FirebaseProvider firebaseProvider) async {
    setState(() {
      counter++;
    });

    setState(() {
      _isLoading = true;
    });

    if (firebaseProvider.insuranceRequestList.isEmpty) {
      await firebaseProvider.getInsurancePendingRequest().then((value) {
        setState(() {
          _subList = firebaseProvider.insuranceRequestList;
          _filteredList = _subList;

          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _subList = firebaseProvider.insuranceRequestList;
        _filteredList = _subList;

        _isLoading = false;
      });
    }

    if (firebaseProvider.insuranceTransferredRequestList.isEmpty) {
      await firebaseProvider.getInsuranceTransferredRequest().then((value) {
        setState(() {
          _transferredSubList =
              firebaseProvider.insuranceTransferredRequestList;
          _transferredFilteredList = _transferredSubList;
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _transferredSubList = firebaseProvider.insuranceTransferredRequestList;
        _transferredFilteredList = _transferredSubList;
        _isLoading = false;
      });
    }
  }

  _filterList(String searchItem) {
    setState(() {
      _filteredList = _subList
          .where((element) =>
              (element.name!.toLowerCase().contains(searchItem.toLowerCase())))
          .toList();
    });
  }

  _transferredfilterList(String searchItem) {
    setState(() {
      _transferredFilteredList = _transferredSubList
          .where((element) =>
              (element.name!.toLowerCase().contains(searchItem.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);

    if (counter == 0) {
      customInit(firebaseProvider);
    }

    return Container(
        width: publicProvider.pageWidth(size),
        child: ListView(
          children: [
            Center(
              child: Text('Insurance List ',
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontSize: publicProvider.isWindows
                        ? size.height * .05
                        : size.width * .05,
                  )),
            ),
            Container(
              height: size.height * .913,
              child: DefaultTabController(
                length: _ktabs.length,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.white54,
                      bottom: TabBar(
                          labelStyle: TextStyle(
                            fontSize: size.height * .03,
                          ),
                          tabs: _ktabs,
                          indicatorColor: Colors.black,
                          unselectedLabelColor: Colors.blueGrey,
                          labelColor: Colors.black),
                    ),
                  ),
                  body: TabBarView(children: [
                    _pendingRequest(publicProvider, size, firebaseProvider),
                    _transferredRequest(publicProvider, size, firebaseProvider),
                  ]),
                ),
              ),
            ),
          ],
        ));
  }

  _pendingRequest(PublicProvider publicProvider, Size size,
      FirebaseProvider firebaseProvider) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.height * .4,
                child: TextField(
                  controller: searchTextController,
                  decoration: textFieldFormDecoration(size).copyWith(
                    hintText: 'Search Customer By Name',
                    hintStyle: TextStyle(
                      fontSize: publicProvider.isWindows
                          ? size.height * .02
                          : size.width * .02,
                    ),
                  ),
                  onChanged: _filterList,
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });

                  firebaseProvider
                      .getInsurancePendingRequest()
                      .then((value) => _isLoading = false);
                },
                icon: Icon(
                  Icons.refresh_outlined,
                  color: Colors.green,
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Customer ID',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Name',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Phone',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Date',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text('Insurance Amount', textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text('Status', textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text('Approval', textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
        _isLoading
            ? Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: fadingCircle,
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: _filteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(
                      firebaseProvider.insuranceRequestList[index].date));
                  var format = new DateFormat("yMMMd").add_jm();
                  String withdrawDate = format.format(date);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${_filteredList[index].userId}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: publicProvider.isWindows
                                    ? size.height * .02
                                    : size.width * .02,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${_filteredList[index].name}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: publicProvider.isWindows
                                    ? size.height * .02
                                    : size.width * .02,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            '${_filteredList[index].phone}',
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(withdrawDate,
                                  textAlign: TextAlign.center)),
                          Expanded(
                              child: Text('${_filteredList[index].status}',
                                  textAlign: TextAlign.center)),
                          Expanded(
                              child: Text('${_filteredList[index].amount}',
                                  textAlign: TextAlign.center)),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: Text('Alert'),
                                          content: Container(
                                            height: publicProvider.isWindows
                                                ? size.height * .2
                                                : size.width * .2,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .warning_amber_outlined,
                                                    color: Colors.yellow,
                                                    size: 40,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: Text(
                                                      'Are you going to transfer the Insurance Balance ?',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Ok'),
                                              onPressed: () {
                                                showLoaderDialog(context);
                                                _updateInsuranceRequestBalance(
                                                        firebaseProvider, index)
                                                    .then((value) {
                                                      _updateInsuranceStatus(
                                                          firebaseProvider,
                                                          index);
                                                    })
                                                    .then((value) =>
                                                        Navigator.of(context)
                                                            .pop())
                                                    .then((value) =>
                                                        Navigator.of(context)
                                                            .pop());
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Text('Accept')),
                          ),
                        ],
                      ),
                    ],
                  );
                })
      ],
    );
  }

  _transferredRequest(PublicProvider publicProvider, Size size,
      FirebaseProvider firebaseProvider) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.height * .4,
                child: TextField(
                  controller: searchTextControllerForTransferred,
                  decoration: textFieldFormDecoration(size).copyWith(
                    hintText: 'Search Customer By Nmae',
                    hintStyle: TextStyle(
                      fontSize: publicProvider.isWindows
                          ? size.height * .02
                          : size.width * .02,
                    ),
                  ),
                  onChanged: _transferredfilterList,
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });

                  firebaseProvider
                      .getInsuranceTransferredRequest()
                      .then((value) => _isLoading = false);
                },
                icon: Icon(
                  Icons.refresh_outlined,
                  color: Colors.green,
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Customer ID',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Name',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Phone',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Date',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text('Insurance Amount', textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text('Status', textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
        _isLoading
            ? Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: fadingCircle,
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: _transferredFilteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(
                      firebaseProvider
                          .insuranceTransferredRequestList[index].date));
                  var format = new DateFormat("yMMMd").add_jm();
                  String withdrawDate = format.format(date);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${_transferredFilteredList[index].userId}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: publicProvider.isWindows
                                    ? size.height * .02
                                    : size.width * .02,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Text(
                              '${_transferredFilteredList[index].name}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: publicProvider.isWindows
                                    ? size.height * .02
                                    : size.width * .02,
                              ),
                            ),
                          ),

                          Expanded(
                              child: Text(
                            '${_transferredFilteredList[index].phone}',
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(withdrawDate,
                                  textAlign: TextAlign.center)),
                          Expanded(
                              child: Text(
                                  '${_transferredFilteredList[index].status}',
                                  textAlign: TextAlign.center)),
                          Expanded(
                              child: Text(
                                  '${_transferredFilteredList[index].amount}',
                                  textAlign: TextAlign.center)),

                          // Expanded(
                          //   child: ElevatedButton(
                          //
                          //       onPressed: (){
                          //         showDialog(context: context, builder: (_){
                          //           return   AlertDialog(
                          //             title: Text('Alert'),
                          //             content: Container(
                          //               height: publicProvider.isWindows?size.height*.2:size.width*.2,
                          //
                          //               child:SingleChildScrollView(
                          //                 child: Column(
                          //                   mainAxisAlignment: MainAxisAlignment.center,
                          //                   crossAxisAlignment: CrossAxisAlignment.center,
                          //                   children: [
                          //                     Icon(Icons.warning_amber_outlined,color: Colors.yellow,size: 40,),
                          //
                          //                     Padding(
                          //                       padding: const EdgeInsets.symmetric(vertical: 5.0),
                          //                       child: Text('Are you confirm to delete this Insurance Info ?',style: TextStyle(fontSize: 14,color: Colors.black),),
                          //                     ),
                          //                   ],),
                          //               ),
                          //
                          //             ),
                          //             actions: <Widget>[
                          //               TextButton(
                          //                 child: Text('Cancel'),
                          //                 onPressed: () {
                          //                   Navigator.of(context).pop();
                          //                 },
                          //               ),
                          //               TextButton(
                          //                 child: Text('Ok'),
                          //                 onPressed: () {
                          //
                          //               //    _addDepositRequestBalance(firebaseProvider, updatableAmount, index);
                          //
                          //
                          //                   // var db = FirebaseFirestore.instance;
                          //                   // WriteBatch batch = db.batch();
                          //                   //
                          //                   // DocumentReference ref = db.collection("Area&Hub").doc(firebaseProvider.areaHubList[index1].id);
                          //                   // batch.delete(ref);
                          //                   //
                          //                   // batch.commit();
                          //                   //
                          //                   //
                          //
                          //                   Navigator.of(context).pop();
                          //                 },
                          //               ),
                          //             ],
                          //           );
                          //         }) ;
                          //
                          //
                          //       }, child: Text('Accept')),
                          // ),
                        ],
                      ),
                    ],
                  );
                })
      ],
    );
  }

  Future<void> _updateInsuranceStatus(
      FirebaseProvider firebaseProvider, int? index) async {
    Map<String, dynamic> map = {
      'status': 'transferred',
    };
    await firebaseProvider.updateInsuranceStatusData(map, index!).then((value) {
      if (value) {
        showToast('Success');
      } else {
        showToast('Failed');
      }
    });
  }

  Future<void> _updateInsuranceRequestBalance(
      FirebaseProvider firebaseProvider, int? index) async {
    Map<String, dynamic> map = {
      'insuranceBalance': '0',
    };
    await firebaseProvider.addInsuranceData(map, index!).then((value) {
      if (value) {
        showToast('Success');
      } else {
        showToast('Failed');
      }
    });
  }
}
