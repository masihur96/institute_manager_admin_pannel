import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/model/data_model/package_order_request_model.dart';

import 'package:institute_manager_admin_pannel/controller/firebase_provider.dart';
import 'package:institute_manager_admin_pannel/controller/public_provider.dart';
import 'package:institute_manager_admin_pannel/model/data_model/product_order_model.dart';
import 'package:institute_manager_admin_pannel/model/data_model/sub_category_model.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/fading_circle.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/form_decoration.dart';
import 'package:provider/provider.dart';

class RegularOrderPage extends StatefulWidget {
  @override
  _RegularOrderPageState createState() => _RegularOrderPageState();
}

class _RegularOrderPageState extends State<RegularOrderPage> {
  var productSearchTextController = TextEditingController();
  var packageSearchTextController = TextEditingController();

  bool _isLoading = false;
  final _ktabs = <Tab>[
    const Tab(text: 'Product Order'),
    const Tab(
      text: 'Package Order',
    ),
  ];

  static const productSearchstatus = <String>[
    'pending',
    'processing',
    'delivered',
  ];
  String productSearchstatusValue = 'pending';

  static const productStatus = <String>[
    'pending',
    'processing',
    'delivered',
  ];
  String productStatusValue = 'pending';

  static const packageStatus = <String>[
    'pending',
    'processing',
    'delivered',
  ];
  String packageStatusValue = 'pending';

  List<dynamic> selectOrder = [];
  List<dynamic> selectUserPhone = [];
  List<dynamic> selectOrderID = [];

  List<ProductOrderModel> _productSubList = [];
  List<ProductOrderModel> _productFilteredList = [];
  List<ProductOrderModel> _productPendungFilteredList = [];
  List<PackageOrderModel> _packageSubList = [];
  List<PackageOrderModel> _packageFilteredList = [];
  List<PackageOrderModel> _packagePendungFilteredList = [];
  int counter = 0;
  customInit(FirebaseProvider firebaseProvider) async {
    setState(() {
      counter++;
    });
    setState(() {
      _isLoading = true;
    });

    if (firebaseProvider.productOrderList.isEmpty) {
      await firebaseProvider.getProductOrder().then((value) {
        setState(() {
          _productSubList = firebaseProvider.productOrderList;
          _productFilteredList = _productSubList;
          _isLoading = false;
          _productPendingFilterList('pending');
        });
      });
    } else {
      setState(() {
        _productSubList = firebaseProvider.productOrderList;
        _productFilteredList = _productSubList;
        _isLoading = false;
        _productPendingFilterList('pending');
      });
    }

    if (firebaseProvider.packageOrderList.isEmpty) {
      await firebaseProvider.getPackageRequest().then((value) {
        setState(() {
          _packageSubList = firebaseProvider.packageOrderList;
          _packageFilteredList = _packageSubList;
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _packageSubList = firebaseProvider.packageOrderList;
        _packageFilteredList = _packageSubList;
        _isLoading = false;
      });
    }

    _productPendingFilterList(productSearchstatusValue);
    _packagePendingFilterList(packageStatusValue);
  }

  _productPendingFilterList(String searchItem) {
    setState(() {
      _productFilteredList = _productSubList
          .where((element) =>
              (element.state!.toLowerCase().contains(searchItem.toLowerCase())))
          .toList();

      _productPendungFilteredList = _productFilteredList;
    });
  }

  _productFilterList(String searchItem) {
    setState(() {
      _productFilteredList = _productPendungFilteredList
          .where((element) => (element.orderNumber!
              .toLowerCase()
              .contains(searchItem.toLowerCase())))
          .toList();
    });
  }

  _packagePendingFilterList(String searchItem) {
    setState(() {
      _packageFilteredList = _packageSubList
          .where((element) => (element.status!
              .toLowerCase()
              .contains(searchItem.toLowerCase())))
          .toList();

      _packagePendungFilteredList = _packageFilteredList;
    });
  }

  _packageFilterList(String searchItem) {
    setState(() {
      _packageFilteredList = _packagePendungFilteredList
          .where((element) => (element.productName!
              .toLowerCase()
              .contains(searchItem.toLowerCase())))
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
                          fontSize: publicProvider.isWindows
                              ? size.height * .03
                              : size.width * .03,
                        ),
                        tabs: _ktabs,
                        indicatorColor: Colors.black,
                        unselectedLabelColor: Colors.blueGrey,
                        labelColor: Colors.black),
                  ),
                ),
                body: TabBarView(children: [
                  _productOrder(publicProvider, size, firebaseProvider),
                  _packageOrder(publicProvider, size, firebaseProvider),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _productOrder(PublicProvider publicProvider, Size size,
      FirebaseProvider firebaseProvider) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.height * .4,
            child: TextField(
                controller: productSearchTextController,
                decoration: textFieldFormDecoration(size).copyWith(
                  hintText: 'Search By Order ID',
                  hintStyle: TextStyle(
                    fontSize: publicProvider.isWindows
                        ? size.height * .02
                        : size.width * .02,
                  ),
                ),
                onChanged: _productFilterList),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.warning_amber_outlined,
                                    color: Colors.yellow,
                                    size: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Text(
                                      'Are you confirm to delete this Order ?',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ],
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
                                  var db = FirebaseFirestore.instance;
                                  WriteBatch batch = db.batch();
                                  for (String id in selectOrderID) {
                                    DocumentReference ref =
                                        db.collection("Orders").doc(id);
                                    batch.delete(ref);
                                  }
                                  batch.commit().then((value) {
                                    customInit(firebaseProvider);
                                    selectOrder.clear();
                                    selectOrderID.clear();
                                    Navigator.of(context).pop();
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.red,
                  )),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  setState(() {
                    selectOrder.clear();
                    selectOrderID.clear();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text('Clear All Selection ',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: publicProvider.isWindows
                            ? size.height * .02
                            : size.width * .02,
                      )),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });

                    firebaseProvider
                        .getProductOrder()
                        .then((value) => _isLoading = false);
                  },
                  icon: Icon(
                    Icons.refresh_outlined,
                    color: Colors.green,
                  )),
              Text(
                'Ordered Type : ',
                style: TextStyle(fontSize: 15),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: productSearchstatusValue,
                  elevation: 0,
                  dropdownColor: Colors.white,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: publicProvider.isWindows
                          ? size.height * .025
                          : size.height * .025),
                  items: productSearchstatus.map((itemValue) {
                    return DropdownMenuItem<String>(
                      value: itemValue,
                      child: Text(itemValue),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      productSearchstatusValue = newValue!;
                    });
                    _productPendingFilterList(productSearchstatusValue);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              ),
              Expanded(
                  child: Text(
                'Customer Info',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Date',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Order Number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Quantity',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Payment Status',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Amount',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Action',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
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
                itemCount: _productFilteredList.length,
                itemBuilder: (BuildContext context, int index1) {
                  return Container(
                    child: Column(
                      children: [
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (selectOrder.contains(index1)) {
                                      selectOrder.remove(index1);
                                      selectOrderID.remove(
                                          _productFilteredList[index1].id);
                                    } else {
                                      selectOrder.add(index1);
                                      selectOrderID
                                          .add(_productFilteredList[index1].id);
                                    }
                                  });
                                },
                                child: selectOrder.contains(index1)
                                    ? Icon(Icons.check_box_outlined)
                                    : Icon(Icons.check_box_outline_blank)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _productFilteredList[index1].name!,
                                      style: TextStyle(
                                        fontSize: publicProvider.isWindows
                                            ? size.height * .02
                                            : size.width * .02,
                                      ),
                                    ),
                                    Text(
                                      _productFilteredList[index1].phone!,
                                      style: TextStyle(
                                        fontSize: publicProvider.isWindows
                                            ? size.height * .02
                                            : size.width * .02,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              _productFilteredList[index1].orderDate!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: publicProvider.isWindows
                                    ? size.height * .02
                                    : size.width * .02,
                              ),
                            )),
                            Expanded(
                              child: Text(
                                _productFilteredList[index1].orderNumber!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: publicProvider.isWindows
                                      ? size.height * .02
                                      : size.width * .02,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _productFilteredList[index1].quantity!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: publicProvider.isWindows
                                      ? size.height * .02
                                      : size.width * .02,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _productFilteredList[index1].state!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: publicProvider.isWindows
                                      ? size.height * .02
                                      : size.width * .02,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _productFilteredList[index1].totalAmount!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: publicProvider.isWindows
                                      ? size.height * .02
                                      : size.width * .02,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  content: Container(
                                                    height:
                                                        publicProvider.isWindows
                                                            ? size.height * .7
                                                            : size.width * .7,
                                                    width:
                                                        publicProvider.isWindows
                                                            ? size.height * .8
                                                            : size.width * .5,
                                                    child: ListView(
                                                      children: <Widget>[
                                                        Text(
                                                          'Payment Information',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: publicProvider
                                                                    .isWindows
                                                                ? size.height *
                                                                    .03
                                                                : size.width *
                                                                    .03,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: publicProvider
                                                                  .isWindows
                                                              ? size.height * .2
                                                              : size.width * .2,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Order ID :',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          15),
                                                                  Text(
                                                                    _productFilteredList[
                                                                            index1]
                                                                        .orderNumber!,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              //   Text('Transaction Id',style: TextStyle(color: Colors.black,fontSize: publicProvider.isWindows?size.height*.02:size.width*.02,),),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Payment Date :',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          15),
                                                                  Text(
                                                                    _productFilteredList[
                                                                            index1]
                                                                        .orderDate!,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Area :',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          15),
                                                                  Text(
                                                                    _productFilteredList[
                                                                            index1]
                                                                        .Area!,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Hub :',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          15),
                                                                  Text(
                                                                    _productFilteredList[
                                                                            index1]
                                                                        .hub!,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Quantity :',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          15),
                                                                  Text(
                                                                    _productFilteredList[
                                                                            index1]
                                                                        .quantity!,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Amount Receive :',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          15),
                                                                  Text(
                                                                    _productFilteredList[
                                                                            index1]
                                                                        .totalAmount!,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Status :',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .025
                                                                          : size.width *
                                                                              .025,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          15),
                                                                  DropdownButtonHideUnderline(
                                                                    child: DropdownButton<
                                                                        String>(
                                                                      value:
                                                                          productStatusValue,
                                                                      elevation:
                                                                          0,
                                                                      dropdownColor:
                                                                          Colors
                                                                              .white,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: publicProvider.isWindows
                                                                              ? size.height * .025
                                                                              : size.height * .025),
                                                                      items: productStatus
                                                                          .map(
                                                                              (itemValue) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              itemValue,
                                                                          child:
                                                                              Text(itemValue),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (newValue) async {
                                                                        setState(
                                                                            () {
                                                                          productStatusValue =
                                                                              newValue!;
                                                                        });

                                                                        showLoaderDialog(
                                                                            context);

                                                                        await updateStateValue(
                                                                                firebaseProvider,
                                                                                _productFilteredList[index1].id!,
                                                                                productStatusValue)
                                                                            .then((value) {
                                                                          customInit(
                                                                              firebaseProvider);
                                                                          Navigator.pop(
                                                                              context);
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Center(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Ordered Product',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: publicProvider
                                                                      .isWindows
                                                                  ? size.height *
                                                                      .03
                                                                  : size.width *
                                                                      .03,
                                                            ),
                                                          ),
                                                        )),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Photo',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: publicProvider
                                                                        .isWindows
                                                                    ? size.height *
                                                                        .025
                                                                    : size.width *
                                                                        .025,
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Text(
                                                              'Product Info',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: publicProvider
                                                                        .isWindows
                                                                    ? size.height *
                                                                        .025
                                                                    : size.width *
                                                                        .025,
                                                              ),
                                                            )),
                                                            Text(
                                                              'Price',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: publicProvider
                                                                        .isWindows
                                                                    ? size.height *
                                                                        .025
                                                                    : size.width *
                                                                        .025,
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Text(
                                                              'Profit',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: publicProvider
                                                                        .isWindows
                                                                    ? size.height *
                                                                        .025
                                                                    : size.width *
                                                                        .025,
                                                              ),
                                                            )),
                                                          ],
                                                        ),
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            itemCount:
                                                                _productFilteredList[
                                                                        index1]
                                                                    .products!
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            8.0),
                                                                    child:
                                                                        Divider(
                                                                      height: 1,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                Image.network(
                                                                              '${_productFilteredList[index1].products![index]['productImage']}',
                                                                              height: 30,
                                                                              width: 25,
                                                                            )),
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                'Title: ${_productFilteredList[index1].products![index]['productName']}',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: publicProvider.isWindows ? size.height * .02 : size.width * .02,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                'Quantity: ${_productFilteredList[index1].products![index]['quantity']}',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: publicProvider.isWindows ? size.height * .02 : size.width * .02,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${_productFilteredList[index1].products![index]['price']}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: publicProvider.isWindows
                                                                                ? size.height * .02
                                                                                : size.width * .02,
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                            child:
                                                                                Text(
                                                                          '${_productFilteredList[index1].products![index]['profitAmount']}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: publicProvider.isWindows
                                                                                ? size.height * .02
                                                                                : size.width * .02,
                                                                          ),
                                                                        )),
                                                                      ]),
                                                                ],
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text('Cancel'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          publicProvider.isWindows
                                              ? size.height * .01
                                              : size.width * .01),
                                      child: Icon(
                                        Icons.visibility,
                                        size: publicProvider.isWindows
                                            ? size.height * .02
                                            : size.width * .02,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: Text('Alert'),
                                                content: Container(
                                                  height: size.height * .2,
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .warning_amber_outlined,
                                                        size: 50,
                                                        color: Colors.red,
                                                      ),
                                                      Text(
                                                          'Are You Confirm To Delete This Order ??'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('OK'),
                                                    onPressed: () {
                                                      showLoaderDialog(context);
                                                      firebaseProvider
                                                          .deleteProductOrder(
                                                              firebaseProvider,
                                                              _productFilteredList[
                                                                      index1]
                                                                  .id!)
                                                          .then((value) {
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            publicProvider.isWindows
                                                ? size.height * .01
                                                : size.width * .01),
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                          size: publicProvider.isWindows
                                              ? size.height * .03
                                              : size.width * .03,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                })
      ],
    );
  }

  Future<void> updateStateValue(
      FirebaseProvider firebaseProvider, String id, String status) async {
    Map<String, dynamic> map = {
      'state': status,
    };
    await firebaseProvider.updateOrderStatus(map, id).then((value) {
      if (value) {
        showToast('Success');
      } else {
        showToast('Failed');
      }
    });
  }

  _packageOrder(PublicProvider publicProvider, Size size,
      FirebaseProvider firebaseProvider) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.height * .4,
            child: TextField(
              controller: packageSearchTextController,
              decoration: textFieldFormDecoration(size).copyWith(
                hintText: 'Search By Package Name',
                hintStyle: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              ),
              onChanged: _packageFilterList,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.warning_amber_outlined,
                                    color: Colors.yellow,
                                    size: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Text(
                                      'Are you confirm to delete this Order ?',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ],
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
                                  var db = FirebaseFirestore.instance;
                                  WriteBatch batch = db.batch();

                                  for (int index in selectOrder) {
                                    DocumentReference ref = db
                                        .collection("PackageCollectionRequest")
                                        .doc(selectOrderID[index]);
                                    batch.delete(ref);
                                    DocumentReference ref1 = db
                                        .collection("Users")
                                        .doc(selectUserPhone[index])
                                        .collection('MyStore')
                                        .doc(selectOrderID[index]);
                                    batch.delete(ref1);
                                  }
                                  batch.commit().then((value) async {
                                    await firebaseProvider
                                        .getPackageRequest()
                                        .then((value) {
                                      setState(() {
                                        _packageSubList =
                                            firebaseProvider.packageOrderList;
                                        _packageFilteredList = _packageSubList;
                                        _isLoading = false;
                                      });
                                    });
                                    selectOrder.clear();
                                    selectOrderID.clear();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  });

                                  //  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.red,
                  )),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  setState(() {
                    selectOrder.clear();
                    selectOrderID.clear();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text('Clear All Selection ',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: publicProvider.isWindows
                            ? size.height * .02
                            : size.width * .02,
                      )),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });

                    firebaseProvider
                        .getPackageRequest()
                        .then((value) => _isLoading = false);
                  },
                  icon: Icon(
                    Icons.refresh_outlined,
                    color: Colors.green,
                  )),
              Text(
                'Ordered Type : ',
                style: TextStyle(fontSize: 15),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: packageStatusValue,
                  elevation: 0,
                  dropdownColor: Colors.white,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: publicProvider.isWindows
                          ? size.height * .025
                          : size.height * .025),
                  items: packageStatus.map((itemValue) {
                    return DropdownMenuItem<String>(
                      value: itemValue,
                      child: Text(itemValue),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      packageStatusValue = newValue!;
                    });
                    _packagePendingFilterList(packageStatusValue);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              ),
              Expanded(
                  child: Text(
                'Customer Info',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Date',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Package Name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Price',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Discount',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Quantity',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Order Status',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
              Expanded(
                  child: Text(
                'Action',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: publicProvider.isWindows
                      ? size.height * .02
                      : size.width * .02,
                ),
              )),
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
                itemCount: _packageFilteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (selectOrder.contains(index)) {
                                      selectOrder.remove(index);
                                      selectOrderID.remove(
                                          _packageFilteredList[index].id);
                                      selectUserPhone.remove(
                                          _packageFilteredList[index]
                                              .userPhone);

                                      print(selectOrderID);
                                      print(selectUserPhone);
                                    } else {
                                      selectOrder.add(index);
                                      selectOrderID
                                          .add(_packageFilteredList[index].id);
                                      selectUserPhone.add(
                                          _packageFilteredList[index]
                                              .userPhone);
                                      print(selectOrderID);
                                      print(selectUserPhone);
                                    }
                                  });
                                },
                                child: selectOrder.contains(index)
                                    ? Icon(Icons.check_box_outlined)
                                    : Icon(Icons.check_box_outline_blank)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _packageFilteredList[index].userName!,
                                      style: TextStyle(
                                        fontSize: publicProvider.isWindows
                                            ? size.height * .02
                                            : size.width * .02,
                                      ),
                                    ),
                                    Text(
                                      _packageFilteredList[index].userAddress!,
                                      style: TextStyle(
                                        fontSize: publicProvider.isWindows
                                            ? size.height * .02
                                            : size.width * .02,
                                      ),
                                    ),
                                    Text(
                                      _packageFilteredList[index].userPhone!,
                                      style: TextStyle(
                                        fontSize: publicProvider.isWindows
                                            ? size.height * .02
                                            : size.width * .02,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              _packageFilteredList[index].date!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: publicProvider.isWindows
                                    ? size.height * .02
                                    : size.width * .02,
                              ),
                            )),
                            Expanded(
                              child: Text(
                                _packageFilteredList[index].productName!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: publicProvider.isWindows
                                      ? size.height * .02
                                      : size.width * .02,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _packageFilteredList[index].productPrice!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: publicProvider.isWindows
                                      ? size.height * .02
                                      : size.width * .02,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _packageFilteredList[index].discount!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: publicProvider.isWindows
                                      ? size.height * .02
                                      : size.width * .02,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _packageFilteredList[index].quantity!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: publicProvider.isWindows
                                      ? size.height * .02
                                      : size.width * .02,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _packageFilteredList[index].status!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: publicProvider.isWindows
                                      ? size.height * .02
                                      : size.width * .02,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: Container(
                            //     child: ElevatedButton(onPressed: (){
                            //       showLoaderDialog(context);
                            //       updatePackageStateValue(firebaseProvider,index,packageStatusValue).then((value) => Navigator.pop(context));
                            //
                            //     },  style: ElevatedButton.styleFrom(
                            //         primary: Colors.green,
                            //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            //        ),
                            //         child: Text('Collected',style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 15,
                            //               ),)),
                            //   ),
                            // ),

                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: packageStatusValue,
                                  elevation: 0,
                                  dropdownColor: Colors.white,
                                  style: TextStyle(color: Colors.black),
                                  items: packageStatus.map((itemValue) {
                                    return DropdownMenuItem<String>(
                                      value: itemValue,
                                      child: Text(itemValue),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      packageStatusValue = newValue!;
                                    });
                                    showLoaderDialog(context);
                                    updatePackageStateValue(firebaseProvider,
                                            index, packageStatusValue)
                                        .then((value) {
                                      customInit(firebaseProvider);
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                })
      ],
    );
  }

  Future<void> updatePackageStateValue(
      FirebaseProvider firebaseProvider, int? index, String status) async {
    Map<String, dynamic> map = {
      'status': packageStatusValue,
    };

    await firebaseProvider
        .updatePackageOrderStatus(map, index!)
        .then((value) async {
      if (value) {
        showToast('Success');

        await firebaseProvider.getPackageRequest().then((value) {
          setState(() {
            _packageSubList = firebaseProvider.packageOrderList;
            _packageFilteredList = _packageSubList;
            _isLoading = false;
          });
        });
      } else {
        await firebaseProvider.getPackageRequest().then((value) async {
          setState(() {
            _packageSubList = firebaseProvider.packageOrderList;
            _packageFilteredList = _packageSubList;
            _isLoading = false;
          });
        });
      }
    });
  }
}
