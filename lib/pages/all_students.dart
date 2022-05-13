import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/controller/data_fetcher.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/data.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/firebase_provider.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/public_provider.dart';
import 'package:institute_manager_admin_pannel/model/data_model/category_model.dart';
import 'package:institute_manager_admin_pannel/model/data_model/student_model.dart';
import 'package:institute_manager_admin_pannel/model/data_model/sub_category_model.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/fading_circle.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/form_decoration.dart';
import 'package:provider/provider.dart';

class AllStudent extends StatefulWidget {
  const AllStudent({Key? key}) : super(key: key);

  @override
  _AllStudentState createState() => _AllStudentState();
}

class _AllStudentState extends State<AllStudent> {
  final DataFetcher _dataFetcher = DataFetcher();
  List<StudentModel>? students;
  List<StudentModel> _filteredList = [];

  @override
  initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    List<StudentModel>? studentList =
        Provider.of<Data>(context, listen: false).students;
    if (studentList != null) {
      students = studentList;
      _filteredList = studentList;
      setState(() {});
      print(students![0].studentName);
      print('Filtered: ${_filteredList[0].studentName}');
    } else {
      List<StudentModel> studentList = await _dataFetcher.getStudents();
      Provider.of<Data>(context, listen: false).setStudents(studentList);
      students = studentList;
      _filteredList = studentList;
      setState(() {});
      print(students![0].studentName);
      print('Filtered: ${_filteredList[0].studentName}');
    }
  }

  var searchTextController = TextEditingController();
  bool _isLoading = false;
  // //Category Variable
  // //
  // // List<CategoryModel> caterorys = [];
  // // List<SubCategoryModel> subCategorys = [];
  //
  // List selectedProduct = []; //selected product for check
  // List selectedProductID = []; //selected product ID for Delete
  //
  // final List<String> imgList = [];
  // int _currentIndex = 0;
  // int counter = 0;
  List<StudentModel> _subList = [];

  // _customInit(FirebaseProvider firebaseProvider) async {
  //   setState(() {
  //     counter++;
  //     _isLoading = true;
  //   });
  //
  //   if (firebaseProvider.studentList.isEmpty) {
  //     await firebaseProvider.getStudents().then((value) {
  //       setState(() {
  //         _subList = firebaseProvider.studentList;
  //         _filteredList = _subList;
  //         _isLoading = false;
  //       });
  //     });
  //   } else {
  //     setState(() {
  //       _subList = firebaseProvider.studentList;
  //       _filteredList = _subList;
  //       _isLoading = false;
  //     });
  //   }
  // }
  //
  // _filterList(String searchItem) {
  //   setState(() {
  //     _filteredList = _subList
  //         .where((element) => (element.studentName!
  //             .toLowerCase()
  //             .contains(searchItem.toLowerCase())))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    // final FirebaseProvider firebaseProvider =
    //     Provider.of<FirebaseProvider>(context);

    // if (counter == 0) {
    //   _customInit(firebaseProvider);
    // }
    return Container(
      width: publicProvider.pageWidth(size),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: size.height * .4,
              child: TextField(
                controller: searchTextController,
                decoration: textFieldFormDecoration(size).copyWith(
                  hintText: 'Search Product By Title',
                  hintStyle: TextStyle(
                    fontSize: publicProvider.isWindows
                        ? size.height * .02
                        : size.width * .02,
                  ),
                ),
                // onChanged: _filterList,
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
                                  children: const [
                                    Icon(
                                      Icons.warning_amber_outlined,
                                      color: Colors.yellow,
                                      size: 40,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      child: Text(
                                        'Are you confirm to delete this Product ?',
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
                                    // var db = FirebaseFirestore.instance;
                                    // WriteBatch batch = db.batch();
                                    // for (String id in selectedProductID) {
                                    //   DocumentReference ref =
                                    //       db.collection("Products").doc(id);
                                    //   batch.delete(ref);
                                    // }
                                    // batch.commit().then((value) {
                                    //   firebaseProvider.getStudents();
                                    //   selectedProduct.clear();
                                    //   Navigator.of(context).pop();
                                    // });
                                    //
                                    // selectedProductID.forEach((element) {
                                    //   deleteSinglePhoto(firebaseProvider
                                    //       .studentList[element].image);
                                    // });

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
                      // selectedProduct.clear();
                      // selectedProductID.clear();
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
                      //
                      // firebaseProvider
                      //     .getStudents()
                      //     .then((value) => _isLoading = false);
                    },
                    icon: Icon(
                      Icons.refresh_outlined,
                      color: Colors.green,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SL No',
                  style: TextStyle(
                    fontSize: publicProvider.isWindows
                        ? size.height * .02
                        : size.width * .02,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Text(
                    'Photo',
                    style: TextStyle(
                      fontSize: publicProvider.isWindows
                          ? size.height * .02
                          : size.width * .02,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Name',
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
                    'Father Name',
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
                    'Phone/Email',
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
                    'Class',
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
                    'Section',
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
                    'Action',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: publicProvider.isWindows
                          ? size.height * .02
                          : size.width * .02,
                    ),
                  ),
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
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              // if (selectedProduct.contains(index)) {
                              //   selectedProductID
                              //       .remove(_filteredList[index].id);
                              //   selectedProduct.remove(index);
                              // } else {
                              //   selectedProductID
                              //       .add(_filteredList[index].id);
                              //   selectedProduct.add(index);
                              // }
                            });
                          },
                          // child: selectedProduct.contains(index)
                          //     ? Icon(Icons.check_box_outlined)
                          //     : Icon(
                          //         Icons.check_box_outline_blank_outlined),
                        ),
                        Text('${_filteredList[index].studentName}'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: Container(
                              height: publicProvider.isWindows
                                  ? size.height * .04
                                  : size.width * .04,
                              width: publicProvider.isWindows
                                  ? size.height * .03
                                  : size.width * .03,
                              child: _filteredList[index].studentImageUrl !=
                                          null &&
                                      _filteredList[index]
                                          .studentImageUrl!
                                          .isNotEmpty
                                  ? Image.network(
                                      _filteredList[index].studentImageUrl!,
                                      fit: BoxFit.fill,
                                    )
                                  : Container()),
                        ),
                        // Expanded(
                        //   child: Text(
                        //     '${_filteredList[index].studentName}',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       fontSize: publicProvider.isWindows
                        //           ? size.height * .02
                        //           : size.width * .02,
                        //     ),
                        //   ),
                        // ),
                        // Expanded(
                        //   child: Text(
                        //     '${_filteredList[index].fatherName}',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       fontSize: publicProvider.isWindows
                        //           ? size.height * .02
                        //           : size.width * .02,
                        //     ),
                        //   ),
                        // ),
                        // Expanded(
                        //   child: Text(
                        //     '${_filteredList[index].phoneNo}\n${_filteredList[index].email}',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       fontSize: publicProvider.isWindows
                        //           ? size.height * .02
                        //           : size.width * .02,
                        //     ),
                        //   ),
                        // ),
                        // Expanded(
                        //   child: Text(
                        //     '${_filteredList[index].admittedClass}',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       fontSize: publicProvider.isWindows
                        //           ? size.height * .02
                        //           : size.width * .02,
                        //     ),
                        //   ),
                        // ),
                        // Expanded(
                        //   child: Text(
                        //     '${_filteredList[index].section}',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       fontSize: publicProvider.isWindows
                        //           ? size.height * .02
                        //           : size.width * .02,
                        //     ),
                        //   ),
                        // ),
                        // Expanded(
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       InkWell(
                        //         onTap: () {
                        //           // setState(() {
                        //           //   firebaseProvider.productIndex = index;
                        //           // });
                        //           //
                        //           // showDialog(
                        //           //     context: context,
                        //           //     builder: (_) {
                        //           //       return AlertDialog(
                        //           //         title: Text('Product Details'),
                        //           //         content: Container(
                        //           //             height:
                        //           //                 publicProvider.isWindows
                        //           //                     ? size.height * .6
                        //           //                     : size.width * .6,
                        //           //             width:
                        //           //                 publicProvider.isWindows
                        //           //                     ? size.height
                        //           //                     : size.width * .8,
                        //           //             child: ListView(
                        //           //               children: [
                        //           //                 publicProvider.isWindows
                        //           //                     ? Row(
                        //           //                         mainAxisAlignment:
                        //           //                             MainAxisAlignment
                        //           //                                 .center,
                        //           //                         crossAxisAlignment:
                        //           //                             CrossAxisAlignment
                        //           //                                 .start,
                        //           //                         children: [
                        //           //                           Container(
                        //           //                               width: publicProvider.isWindows
                        //           //                                   ? size.height /
                        //           //                                       2
                        //           //                                   : size.width *
                        //           //                                       .8 /
                        //           //                                       2,
                        //           //                               child: productImageList(
                        //           //                                   publicProvider,
                        //           //                                   size,
                        //           //                                   index,
                        //           //                                   firebaseProvider)),
                        //           //                           Container(
                        //           //                               width: publicProvider.isWindows
                        //           //                                   ? size.height /
                        //           //                                       2
                        //           //                                   : size.width *
                        //           //                                       .8 /
                        //           //                                       2,
                        //           //                               child: productDetailsData(
                        //           //                                   publicProvider,
                        //           //                                   firebaseProvider,
                        //           //                                   index,
                        //           //                                   size))
                        //           //                         ],
                        //           //                       )
                        //           //                     : Column(
                        //           //                         mainAxisAlignment:
                        //           //                             MainAxisAlignment
                        //           //                                 .center,
                        //           //                         crossAxisAlignment:
                        //           //                             CrossAxisAlignment
                        //           //                                 .center,
                        //           //                         children: [
                        //           //                           Container(
                        //           //                               width:
                        //           //                                   publicProvider.pageWidth(size) *
                        //           //                                       .5,
                        //           //                               child: productImageList(
                        //           //                                   publicProvider,
                        //           //                                   size,
                        //           //                                   index,
                        //           //                                   firebaseProvider)),
                        //           //                           productDetailsData(
                        //           //                               publicProvider,
                        //           //                               firebaseProvider,
                        //           //                               index,
                        //           //                               size)
                        //           //                         ],
                        //           //                       ),
                        //           //               ],
                        //           //             )),
                        //           //         actions: <Widget>[
                        //           //           TextButton(
                        //           //             child: Text('Cancel'),
                        //           //             onPressed: () {
                        //           //               Navigator.of(context)
                        //           //                   .pop();
                        //           //             },
                        //           //           ),
                        //           //         ],
                        //           //       );
                        //           //     });
                        //         },
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Icon(
                        //             Icons.visibility,
                        //             size: publicProvider.isWindows
                        //                 ? size.height * .02
                        //                 : size.width * .02,
                        //             color: Colors.green,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    );
                  })
        ],
      ),
    );
  }

  Widget productDetailsData(PublicProvider publicProvider,
      FirebaseProvider firebaseProvider, int index, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Product Details',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            width: publicProvider.isWindows ? size.height / 2 : size.width * .2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      firebaseProvider.studentList[index].title,
                      style: TextStyle(
                        fontSize: publicProvider.isWindows
                            ? size.height * .025
                            : size.width * .025,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Description: ${firebaseProvider.studentList[index].description}',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .025
                              : size.width * .025,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Price: ${firebaseProvider.studentList[index].price}',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .025
                              : size.width * .025,
                        ),
                      )),
                  firebaseProvider.studentList[index].colors.length == 0
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Container(
                            // width: size.height*.5,
                            height: 30,
                            child: Row(
                              children: [
                                Text(
                                  'Color:',
                                  style: TextStyle(
                                    fontSize: publicProvider.isWindows
                                        ? size.height * .025
                                        : size.width * .025,
                                  ),
                                ),
                                ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: firebaseProvider
                                        .studentList[index].colors.length,
                                    itemBuilder: (_, idx) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: Color(int.parse(
                                                      firebaseProvider
                                                          .studentList[index]
                                                          .colors[idx])),
                                                  shape: BoxShape.circle),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          )),
                  firebaseProvider.studentList[index].size.length == 0
                      ? SizedBox()
                      : Container(
                          // width: size.height*.5,
                          height: 20,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Size:',
                                style: TextStyle(
                                  fontSize: publicProvider.isWindows
                                      ? size.height * .025
                                      : size.width * .025,
                                ),
                              ),
                              ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: firebaseProvider
                                      .studentList[index].size.length,
                                  itemBuilder: (_, idx) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        firebaseProvider
                                            .studentList[index].size[idx],
                                        style: TextStyle(
                                          fontSize: publicProvider.isWindows
                                              ? size.height * .025
                                              : size.width * .025,
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Profit Amount: ${firebaseProvider.studentList[index].profitAmount}',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .025
                              : size.width * .025,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Category:  ${firebaseProvider.studentList[index].category}',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .025
                              : size.width * .025,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Subcategory: ${firebaseProvider.studentList[index].subCategory}',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .025
                              : size.width * .025,
                        ),
                      )),
                  Text(
                    'Upload Date: ${firebaseProvider.studentList[index].date}',
                    style: TextStyle(
                      fontSize: publicProvider.isWindows
                          ? size.height * .025
                          : size.width * .025,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    publicProvider.subCategory = 'Update Product';
                    publicProvider.category = '';
                  });

                  Navigator.pop(context);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(width: 1, color: Colors.green)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50.0,
                        vertical: 5,
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: publicProvider.isWindows
                              ? size.height * .03
                              : size.width * .03,
                        ),
                      ),
                    ))),
          )
        ],
      ),
    );
  }

  Future deleteSinglePhoto(List<dynamic> photos) async {
    try {
      if (photos.isNotEmpty) {
        for (var photo in photos) {
          print('deleting $photo');
          await FirebaseStorage.instance.refFromURL(photo).delete();
        }
      }
    } catch (error) {
      print('deleting single photo error: $error');
    }
  }
}
