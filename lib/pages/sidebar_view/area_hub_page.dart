import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/controller/firebase_provider.dart';
import 'package:institute_manager_admin_pannel/controller/public_provider.dart';
import 'package:institute_manager_admin_pannel/model/data_model/sub_category_model.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/fading_circle.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/form_decoration.dart';
import 'package:provider/provider.dart';

class AreaHub extends StatefulWidget {
  @override
  _AreaHubState createState() => _AreaHubState();
}

class _AreaHubState extends State<AreaHub> {
  bool _isLoading = false;
  var areaTextController = TextEditingController();
  var hubTextController = TextEditingController();

  List<dynamic> hubValue = [];

  int counter = 0;

  customInit(FirebaseProvider firebaseProvider) {
    if (firebaseProvider.areaHubList.isEmpty) {
      firebaseProvider.getAreaHub();
    }
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
        child: publicProvider.isWindows
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: firebaseProvider.areaHubList.length,
                              itemBuilder: (BuildContext context, int index1) {
                                return Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          color: Colors.green,
                                          width: publicProvider.pageWidth(size),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  firebaseProvider
                                                      .areaHubList[index1].id,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Alert'),
                                                                content:
                                                                    Container(
                                                                  height: publicProvider
                                                                          .isWindows
                                                                      ? size.height *
                                                                          .2
                                                                      : size.width *
                                                                          .2,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .warning_amber_outlined,
                                                                          color:
                                                                              Colors.yellow,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(vertical: 5.0),
                                                                          child:
                                                                              Text(
                                                                            'Are you confirm to delete this Area ?',
                                                                            style:
                                                                                TextStyle(fontSize: 14, color: Colors.black),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    child: Text(
                                                                        'Cancel'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                    child: Text(
                                                                        'Ok'),
                                                                    onPressed:
                                                                        () {
                                                                      var db =
                                                                          FirebaseFirestore
                                                                              .instance;
                                                                      WriteBatch
                                                                          batch =
                                                                          db.batch();
                                                                      DocumentReference ref = db
                                                                          .collection(
                                                                              "Area&Hub")
                                                                          .doc(firebaseProvider
                                                                              .areaHubList[index1]
                                                                              .id);
                                                                      batch.delete(
                                                                          ref);
                                                                      batch
                                                                          .commit()
                                                                          .then((value) =>
                                                                              firebaseProvider.getAreaHub());
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Icon(
                                                          Icons.delete_outline,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) {
                                                                return StatefulBuilder(builder:
                                                                    (BuildContext
                                                                            context,
                                                                        StateSetter
                                                                            setState) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Add Hub'),
                                                                    content:
                                                                        Container(
                                                                      height: publicProvider
                                                                              .isWindows
                                                                          ? size.height *
                                                                              .3
                                                                          : size.width *
                                                                              .3,
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <
                                                                              Widget>[
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                                                              child: TextField(
                                                                                controller: areaTextController,
                                                                                decoration: textFieldFormDecoration(size).copyWith(
                                                                                  labelText: 'Area Name',
                                                                                  hintText: 'Area Name',
                                                                                  hintStyle: TextStyle(fontSize: 15),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                                                              child: TextField(
                                                                                controller: hubTextController,
                                                                                decoration: textFieldFormDecoration(size).copyWith(
                                                                                  labelText: 'Hub Name',
                                                                                  hintText: 'Hub Name',
                                                                                  hintStyle: TextStyle(fontSize: 15),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 20,
                                                                            ),
                                                                            _isLoading
                                                                                ? fadingCircle
                                                                                : ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      primary: Colors.green,
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      setState(() {
                                                                                        _isLoading = true;
                                                                                      });

                                                                                      setState(() {
                                                                                        hubValue.add(hubTextController.text);
                                                                                      });

                                                                                      _submitData(firebaseProvider).then((value) => _isLoading = false);
                                                                                    },
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                                                                      child: Text(
                                                                                        'Add',
                                                                                        style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                                                                                      ),
                                                                                    ))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    actions: <
                                                                        Widget>[
                                                                      TextButton(
                                                                        child: Text(
                                                                            'Cancel'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                              });
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .add_circle_outline,
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(8),
                                            itemCount: firebaseProvider
                                                .areaHubList[index1].hub.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      firebaseProvider
                                                          .areaHubList[index1]
                                                          .hub[index],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    IconButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            firebaseProvider
                                                                .areaHubList[
                                                                    index1]
                                                                .hub
                                                                .remove(firebaseProvider
                                                                    .areaHubList[
                                                                        index1]
                                                                    .hub[index]);
                                                          });
                                                          Map<String, dynamic>
                                                              map = {
                                                            'hub':
                                                                firebaseProvider
                                                                    .areaHubList[
                                                                        index1]
                                                                    .hub,
                                                          };
                                                          await firebaseProvider
                                                              .updateAreaHub(
                                                                  map,
                                                                  firebaseProvider
                                                                      .areaHubList[
                                                                          index1]
                                                                      .id)
                                                              .then((value) {
                                                            if (value) {
                                                              showToast(
                                                                  'Success');
                                                            } else {
                                                              showToast(
                                                                  'Failed');
                                                            }
                                                          });
                                                        },
                                                        icon: Icon(Icons
                                                            .cancel_outlined))
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(),
              ));
  }

  Future<void> _submitData(FirebaseProvider firebaseProvider) async {
    final snapshot1 = await FirebaseFirestore.instance
        .collection('Area&Hub')
        .doc(areaTextController.text)
        .get();

    if (snapshot1.exists) {
      Map<String, dynamic> map = {
        'id': areaTextController.text,
        'hub': FieldValue.arrayUnion(hubValue)
      };
      await firebaseProvider.updateHubData(map).then((value) {
        if (value) {
          print('Successfully Updated');
          Navigator.pop(context);
          _emptyFildCreator();

          setState(() {
            _isLoading = false;

            hubValue.clear();

            showToast('Successfully Updated');
          });
        } else {
          setState(() => _isLoading = false);
          print('Failed');
          showToast('Failed');
        }
      });
    } else {
      Map<String, dynamic> map = {
        'id': areaTextController.text,
        'hub': hubValue,
      };
      await firebaseProvider.addHubData(map).then((value) {
        if (value) {
          print('Success');
          showToast('Successfully Added');
          _emptyFildCreator();
          Navigator.pop(context);
          setState(() {
            _isLoading = false;
          });
        } else {
          showToast('Failed');
          setState(() => _isLoading = false);
          print('Failed');
        }
      });
    }

    // Map<String, dynamic> map = {
    //
    //   'id': areaTextController.text,
    //   'hub': hubValue,
    // };
    // await firebaseProvider.addHubData(map).then((value) {
    //   if (value) {
    //     print('Success');
    //     _emptyFildCreator();
    //
    //     setState(() {
    //       _isLoading = false;
    //       setState(() {
    //
    //       });
    //
    //     });
    //   } else {
    //     setState(() => _isLoading = false);
    //     print('Failed');
    //   }
    // });
  }

  _emptyFildCreator() {
    areaTextController.clear();
    hubTextController.clear();
  }
}
