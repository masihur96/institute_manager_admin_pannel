import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/constants.dart';
import 'package:institute_manager_admin_pannel/controller/firebase_provider.dart';
import 'package:institute_manager_admin_pannel/controller/public_provider.dart';
import 'package:institute_manager_admin_pannel/model/data_model/sub_category_model.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/fading_circle.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/im_text_form_field.dart';
import 'package:provider/provider.dart';

class Admission extends StatefulWidget {
  static const String id = "admission_screen";
  @override
  _AdmissionState createState() => _AdmissionState();
}

class _AdmissionState extends State<Admission> {
  final TextEditingController nameController = TextEditingController();
//size Variable
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  //Image Varialbe
  String? error;
  Uint8List? data;
  List<dynamic> p1ConvertedImages = [];
  List<dynamic> p2ConvertedImages = [];
  List<dynamic> sTConvertedImages = [];
  List<dynamic> nIDConvertedImages = [];
  List<dynamic> bCConvertedImages = [];
  List<dynamic> tCConvertedImages = [];

//Image URL
  String parent1ImageUrl = '';
  String parent2ImageUrl = '';
  String studentImageUrl = '';
  String nIDImageUrl = '';
  String tCImageUrl = '';
  String bCImageUrl = '';

  String name = '';

  //custom init
  int counter = 0;
  List _categoryList = [];
  List filterSubcategory = [];
  String categoryDropdownValue = "";
  String subCategoryDropdownValue = "";

  List<SubCategoryModel> _filteredList = [];
  List<SubCategoryModel> _subCategoryModelList = [];
  customInt(FirebaseProvider firebaseProvider) async {
    setState(() {
      counter++;
    });
    if (firebaseProvider.categoryList.isEmpty) {
      await firebaseProvider.getCategory().then((value) {
        for (var i = 0; i < firebaseProvider.categoryList.length; i++) {
          _categoryList.add(firebaseProvider.categoryList[i].category);
        }

        setState(() {
          categoryDropdownValue = _categoryList[0];
        });
      });
    } else {
      for (var i = 0; i < firebaseProvider.categoryList.length; i++) {
        _categoryList.add(firebaseProvider.categoryList[i].category);
      }
      setState(() {
        categoryDropdownValue = _categoryList[0];
        _subCategoryModelList = firebaseProvider.subCategoryList;
      });

      _filterSubCategoryList(categoryDropdownValue);
    }
  }

  _filterSubCategoryList(String searchItem) {
    setState(() {
      filterSubcategory.clear();
      _filteredList = _subCategoryModelList
          .where((element) => (element.category!
              .toLowerCase()
              .contains(searchItem.toLowerCase())))
          .toList();
      if (_filteredList.isNotEmpty) {
        for (var i = 0; i < _filteredList.length; i++) {
          filterSubcategory.add(_filteredList[i].subCategory!);
        }
        setState(() {
          subCategoryDropdownValue = filterSubcategory[0];
        });
      } else {
        setState(() {
          subCategoryDropdownValue = '';
        });
      }
    });
  }

  //Text Form key
  final _formKeyOne = GlobalKey<FormState>();
  final _formKeyTwo = GlobalKey<FormState>();
  final _formKeyThree = GlobalKey<FormState>();

  //Student info
  String? _studentID;
  String? _studentName;
  String? _birthDate;
  String? _fatherName;
  String? _motherName;
  String? _guardianName;
  String? _guardianRelation;
  String? _nationality;
  String? _religion;
  String? _studentType;

  //Address info
  String? _prVillage;
  String? _prPost;
  String? _prThana;
  String? _prZila;
  String? _village;
  String? _post;
  String? _thana;
  String? _zila;
  String? _phoneNo;
  String? _email;

  //Admission Info
  String? _class;
  String? _section;
  String? _branch;
  String? _roll;
  String? _status;
  String? _mFees;
  String? _addFees;
  String? _tourFees;
  String? _mahfilFees;
  String? _othersFees;

  //Dropdown controller
  final studentTypeController = TextEditingController();
  final studentClassController = TextEditingController();
  final studentSectionController = TextEditingController();
  final studentBranchController = TextEditingController();
  final studentStatusController = TextEditingController();
  final List<String> studentTypeList = ['Regular', 'Irregular'];
  final List<String> studentSectionList = [
    'Nurani',
    'Ampara',
    'Najera',
    'Hifj'
  ];
  final List<String> studentBranchList = [
    'Boys',
    'Girls',
  ];
  final List<String> studentStatusList = [
    'Residential',
    'Non-resident',
    'Daycare',
    'Night Care',
    'Full Time',
  ];
  final List<String> studentClassList = [
    'Play',
    'Nursery',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight'
  ];
  //DropDown value
  String? studentType;
  String? studentClass;
  String? studentSection;
  String? studentBranch;
  String? studentStatus;

  //selected frame
  String selectedFrame = '';
  String nid = '';
  String tC = '';
  String bC = '';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);

    if (counter == 0) {
      customInt(firebaseProvider);
    }
    return Container(
      width: publicProvider.pageWidth(size),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: IMColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        IMAsset.appLogo,
                        fit: BoxFit.fill,
                        width: size.height * .15,
                        height: size.height * .15,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          IMText.instituteName,
                          style: IMTextStyle.IMHeader.copyWith(
                              color: Colors.black),
                        ),
                        Text(
                          IMText.instituteAddress,
                          style: IMTextStyle.IMSubHeaderWhite,
                        )
                      ],
                    ),
                    Container(
                      width: size.height * .4,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                color: IMColors.white,
                                child: Stack(
                                  children: [
                                    p1ConvertedImages.isNotEmpty
                                        ? Container(
                                            child: Image.memory(
                                              p1ConvertedImages[0],
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : SizedBox(),
                                    Positioned.fill(
                                      child: TextButton(
                                        onPressed: () {
                                          p1ConvertedImages.clear();
                                          setState(() {
                                            selectedFrame = 'Parent-1';
                                          });
                                          pickedImage();
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.photo),
                                            Text(
                                              "Parent-1",
                                              style:
                                                  IMTextStyle.IMHeader.copyWith(
                                                      fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                width: 80,
                                color: IMColors.white,
                                child: Stack(
                                  children: [
                                    p2ConvertedImages.isNotEmpty
                                        ? Container(
                                            child: Image.memory(
                                              p2ConvertedImages[0],
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : SizedBox(),
                                    Positioned.fill(
                                      child: TextButton(
                                        onPressed: () {
                                          p2ConvertedImages.clear();
                                          setState(() {
                                            selectedFrame = 'Parent-2';
                                          });
                                          pickedImage();
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.photo),
                                            Text(
                                              "Parent-2",
                                              style:
                                                  IMTextStyle.IMHeader.copyWith(
                                                      fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                width: 80,
                                color: IMColors.white,
                                child: Stack(
                                  children: [
                                    sTConvertedImages.isNotEmpty
                                        ? Container(
                                            child: Image.memory(
                                              sTConvertedImages[0],
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : const SizedBox(),
                                    Positioned.fill(
                                      child: TextButton(
                                        onPressed: () {
                                          sTConvertedImages.clear();
                                          setState(() {
                                            selectedFrame = 'Student';
                                          });
                                          pickedImage();
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.photo),
                                            Text(
                                              "Student",
                                              style:
                                                  IMTextStyle.IMHeader.copyWith(
                                                      fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      nIDConvertedImages.clear();
                                      setState(() {
                                        selectedFrame = 'NID-P1';
                                      });
                                      pickedImage();
                                    },
                                    child: Text(
                                      nid == '' ? "NID-P1" : nid,
                                      style:
                                          IMTextStyle.IMSubHeaderWhite.copyWith(
                                              fontSize: 10),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              IMColors.secondaryColor),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    tCConvertedImages.clear();
                                    setState(() {
                                      selectedFrame = 'TC';
                                    });
                                    pickedImage();
                                  },
                                  child: Text(
                                    tC == '' ? "TC" : tC,
                                    style:
                                        IMTextStyle.IMSubHeaderWhite.copyWith(
                                            fontSize: 10),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        IMColors.secondaryColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      bCConvertedImages.clear();
                                      setState(() {
                                        selectedFrame = 'BC';
                                      });
                                      pickedImage();
                                    },
                                    child: Text(
                                      bC == '' ? "BC" : bC,
                                      style:
                                          IMTextStyle.IMSubHeaderWhite.copyWith(
                                              fontSize: 10),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              IMColors.secondaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // publicProvider.isWindows
            //     ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: publicProvider.pageWidth(size) * .4,
                    child: studentInfoWidget(
                        firebaseProvider, publicProvider, size)),
                Container(
                    width: publicProvider.pageWidth(size) * .3,
                    child: studentAddressWidget(
                        firebaseProvider, publicProvider, size)),
                Container(
                    width: publicProvider.pageWidth(size) * .3,
                    child: admissionInfoWidget(
                        firebaseProvider, publicProvider, size)),
              ],
            ),
            // : Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       studentInfoWidget(
            //           firebaseProvider, publicProvider, size),
            //       studentAddressWidget(
            //           firebaseProvider, publicProvider, size)
            //     ],
            //   ),

            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                final date = DateTime.now().toString();
                var lastThree = date.substring(date.length - 3);
                final String id = 'BM-${nameController.text[0]}$lastThree';
                if (_formKeyOne.currentState!.validate() &&
                    _formKeyTwo.currentState!.validate() &&
                    _formKeyThree.currentState!.validate()) {
                  _formKeyOne.currentState!.save();
                  _formKeyTwo.currentState!.save();
                  _formKeyThree.currentState!.save();

                  _submitData(publicProvider, firebaseProvider, id);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "Save",
                  style: IMTextStyle.IMHeader.copyWith(
                      color: IMColors.white, fontSize: 14),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(IMColors.primaryColor),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget studentInfoWidget(FirebaseProvider firebaseProvider,
      PublicProvider publicProvider, Size size) {
    ScrollController scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Student Info",
            style: IMTextStyle.IMHeader.copyWith(
                fontSize: 20, color: Colors.black),
          ),
          Form(
            key: _formKeyOne,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    textEditingController: nameController,
                    hintText: "Student Name",
                    onSaved: (String? value) {
                      setState(() {
                        _studentName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Father Name",
                    onSaved: (String? value) {
                      setState(() {
                        _fatherName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Mother Name",
                    onSaved: (String? value) {
                      setState(() {
                        _motherName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Guardian Name",
                    onSaved: (String? value) {
                      setState(() {
                        _guardianName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Guardian Relation",
                    onSaved: (String? value) {
                      setState(() {
                        _guardianRelation = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Nationality",
                    onSaved: (String? value) {
                      setState(() {
                        _nationality = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Religion",
                    onSaved: (String? value) {
                      setState(() {
                        _religion = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Birth Date",
                    onSaved: (String? value) {
                      setState(() {
                        _birthDate = value;
                      });
                    },
                  ),
                ),
                CustomDropdown(
                  hintText: 'Select Student Type',
                  items: studentTypeList,
                  controller: studentTypeController,
                  onChanged: (val) {
                    setState(() {
                      studentType = studentTypeController.text;
                    });
                    print(studentType);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget admissionInfoWidget(FirebaseProvider firebaseProvider,
      PublicProvider publicProvider, Size size) {
    ScrollController scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Admission Info",
            style: IMTextStyle.IMHeader.copyWith(
                fontSize: 20, color: Colors.black),
          ),
          Form(
            key: _formKeyThree,
            child: Column(
              children: [
                CustomDropdown(
                  hintText: 'Select Class',
                  items: studentClassList,
                  controller: studentClassController,
                  onChanged: (val) {
                    setState(() {
                      studentClass = val;
                    });
                    print(studentClass);
                  },
                ),
                CustomDropdown(
                  hintText: 'Select Section',
                  items: studentSectionList,
                  controller: studentSectionController,
                  onChanged: (val) {
                    setState(() {
                      studentSection = val;
                    });
                    print(studentSection);
                  },
                ),
                CustomDropdown(
                  hintText: 'Select Branch',
                  items: studentBranchList,
                  controller: studentBranchController,
                  onChanged: (val) {
                    setState(() {
                      studentBranch = val;
                    });
                    print(studentBranch);
                  },
                ),
                CustomDropdown(
                  hintText: 'Select Status',
                  items: studentStatusList,
                  controller: studentStatusController,
                  onChanged: (val) {
                    setState(() {
                      studentStatus = val;
                    });
                    print(studentStatus);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Roll",
                    onSaved: (String? value) {
                      setState(() {
                        _roll = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Monthly Fees",
                    onSaved: (String? value) {
                      setState(() {
                        _mFees = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Admission Fees",
                    onSaved: (String? value) {
                      setState(() {
                        _addFees = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Mahfil Fees",
                    onSaved: (String? value) {
                      setState(() {
                        _mahfilFees = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Tour Fees",
                    onSaved: (String? value) {
                      setState(() {
                        _tourFees = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Others Fees",
                    onSaved: (String? value) {
                      setState(() {
                        _othersFees = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget studentAddressWidget(FirebaseProvider firebaseProvider,
      PublicProvider publicProvider, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Address Info",
            style: IMTextStyle.IMHeader.copyWith(
                fontSize: 20, color: Colors.black),
          ),
          Form(
            key: _formKeyTwo,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Present Address",
                  style: IMTextStyle.IMHeader.copyWith(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Village",
                    onSaved: (String? value) {
                      setState(() {
                        _prVillage = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Post",
                    onSaved: (String? value) {
                      setState(() {
                        _prPost = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Thana",
                    onSaved: (String? value) {
                      setState(() {
                        _prThana = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Zila",
                    onSaved: (String? value) {
                      setState(() {
                        _prZila = value;
                      });
                    },
                  ),
                ),
                Text(
                  "Permanent Address",
                  style: IMTextStyle.IMHeader.copyWith(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Village",
                    onSaved: (String? value) {
                      setState(() {
                        _village = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Post",
                    onSaved: (String? value) {
                      setState(() {
                        _post = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Thana",
                    onSaved: (String? value) {
                      setState(() {
                        _thana = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Zila",
                    onSaved: (String? value) {
                      setState(() {
                        _zila = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: IMTextFormField(
                    hintText: "Phone No",
                    onSaved: (String? value) {
                      setState(() {
                        _phoneNo = value;
                      });
                    },
                  ),
                ),
                IMTextFormField(
                  hintText: "Email",
                  onSaved: (String? value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pickedImage() async {
    FileUploadInputElement input = FileUploadInputElement()..accept = 'image/*';
    FirebaseStorage fs = FirebaseStorage.instance;
    input.multiple = false;
    input.click();

    input.onChange.listen((event) {
      for (var image in input.files!) {
        final reader = FileReader();
        reader.readAsDataUrl(image);
        reader.onLoadEnd.listen((event) async {
          if (selectedFrame == 'Parent-1') {
            print('parent-1');
            var snapshot = await fs
                .ref()
                .child('Student Photo')
                .child(image.name)
                .putBlob(image);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            setState(() {
              parent1ImageUrl = downloadUrl;
            });
          } else if (selectedFrame == 'Parent-2') {
            var snapshot = await fs
                .ref()
                .child('Student Photo')
                .child(image.name)
                .putBlob(image);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            setState(() {
              parent2ImageUrl = downloadUrl;
            });
          } else if (selectedFrame == 'Student') {
            var snapshot = await fs
                .ref()
                .child('Student Photo')
                .child(image.name)
                .putBlob(image);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            setState(() {
              studentImageUrl = downloadUrl;
            });
          } else if (selectedFrame == 'NID-P1') {
            setState(() {
              nid = image.name;
            });
            var snapshot = await fs
                .ref()
                .child('Student Photo')
                .child(image.name)
                .putBlob(image);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            setState(() {
              nIDImageUrl = downloadUrl;
            });
          } else if (selectedFrame == 'TC') {
            setState(() {
              tC = image.name;
            });
            var snapshot = await fs
                .ref()
                .child('Student Photo')
                .child(image.name)
                .putBlob(image);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            setState(() {
              tCImageUrl = downloadUrl;
            });
          } else if (selectedFrame == 'BC') {
            setState(() {
              bC = image.name;
            });
            var snapshot = await fs
                .ref()
                .child('Student Photo')
                .child(image.name)
                .putBlob(image);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            setState(() {
              bCImageUrl = downloadUrl;
            });
          }
        });

        reader.onLoad.first.then((res) {
          final encoded = reader.result as String;
          final stripped =
              encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
          setState(() {
            data = base64.decode(stripped);
            if (selectedFrame == 'Parent-1') {
              p1ConvertedImages.add(data);
            } else if (selectedFrame == 'Parent-2') {
              p2ConvertedImages.add(data);
            } else if (selectedFrame == 'Student') {
              sTConvertedImages.add(data);
            }
            error = null;
          });
        });
      }
    });
  }

  Future<void> _submitData(PublicProvider publicProvider,
      FirebaseProvider firebaseProvider, String id) async {
    DateTime date = DateTime.now();
    String dateData = '${date.month}-${date.day}-${date.year}';
    setState(() => _isLoading = true);
    print(id);
    print(_prVillage);
    print(_section);
    print(_roll);
    print(studentTypeController.text);

    Map<String, dynamic> map = {
      'studentID': id,
      'studentName': _studentName!,
      'fatherName': _fatherName!,
      'motherName': _motherName!,
      'guardianName': _guardianName!,
      'guardianRelation': _guardianRelation!,
      'nationality': _nationality!,
      'religion': _religion!,
      'dOb': _birthDate!,
      'studentType': studentTypeController.text,
      'prVillage': _prVillage!,
      'prPost': _prPost!,
      'prThana': _prThana!,
      'prZila': _prZila!,
      'village': _village!,
      'post': _post!,
      'thana': _thana!,
      'zila': _zila!,
      'phoneNo': _phoneNo!,
      'email': _email!,
      'class': studentClassController.text,
      'section': studentSectionController.text,
      'branch': studentBranchController.text,
      'status': studentStatusController.text,
      'roll': _roll!,
      'mFees': _mFees!,
      'addFees': _addFees!,
      'mahfilFees': _mahfilFees!,
      'tourFees': _tourFees!,
      'othersFees': _othersFees!,
      'parent1ImageUrl': parent1ImageUrl,
      'parent2ImageUrl': parent2ImageUrl,
      'studentImageUrl': studentImageUrl,
      'nIDImageUrl': nIDImageUrl,
      'tCImageUrl': tCImageUrl,
      'bCImageUrl': bCImageUrl,
      'date': dateData,
      'id': id,
    };

    await firebaseProvider.addStudentData(map).then((value) async {
      if (value) {
        showToast('Successfully admitted');

        setState(() {
          _emptyFildCreator();
          p1ConvertedImages.clear();
          p2ConvertedImages.clear();
          sTConvertedImages.clear();
        });

        _isLoading = false;
      } else {
        setState(() => _isLoading = false);
        showToast('Failed');
      }
    });
  }

  _emptyFildCreator() {
    setState(() {
      _studentID = String.fromCharCodes([]);
      _studentName = String.fromCharCodes([]);
      _fatherName = String.fromCharCodes([]);
      _motherName = String.fromCharCodes([]);
      _guardianName = String.fromCharCodes([]);
      _guardianRelation = String.fromCharCodes([]);
      _nationality = String.fromCharCodes([]);
      _religion = String.fromCharCodes([]);
      _birthDate = String.fromCharCodes([]);
      _studentType = String.fromCharCodes([]);
      _prVillage = String.fromCharCodes([]);
      _prPost = String.fromCharCodes([]);
      _prThana = String.fromCharCodes([]);
      _prZila = String.fromCharCodes([]);
      _village = String.fromCharCodes([]);
      _post = String.fromCharCodes([]);
      _thana = String.fromCharCodes([]);
      _zila = String.fromCharCodes([]);
      _phoneNo = String.fromCharCodes([]);
      _email = String.fromCharCodes([]);
      _class = String.fromCharCodes([]);
      _section = String.fromCharCodes([]);
      _branch = String.fromCharCodes([]);
      _status = String.fromCharCodes([]);
      _roll = String.fromCharCodes([]);
      _mFees = String.fromCharCodes([]);
      _addFees = String.fromCharCodes([]);
      _mahfilFees = String.fromCharCodes([]);
      _tourFees = String.fromCharCodes([]);
      _othersFees = String.fromCharCodes([]);
      parent1ImageUrl = String.fromCharCodes([]);
      parent2ImageUrl = String.fromCharCodes([]);
      studentImageUrl = String.fromCharCodes([]);
      nIDImageUrl = String.fromCharCodes([]);
      tCImageUrl = String.fromCharCodes([]);
      bCImageUrl = String.fromCharCodes([]);
    });
  }
}
