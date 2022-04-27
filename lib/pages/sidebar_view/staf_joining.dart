import 'dart:convert';
import 'dart:typed_data';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/constants.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/firebase_provider.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/public_provider.dart';
import 'package:institute_manager_admin_pannel/model/data_model/sub_category_model.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/fading_circle.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/im_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';
import 'package:nanoid/nanoid.dart';

class StaffJoining extends StatefulWidget {
  const StaffJoining({Key? key}) : super(key: key);

  @override
  _StaffJoiningState createState() => _StaffJoiningState();
}

class _StaffJoiningState extends State<StaffJoining> {
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

  List<dynamic> tConvertedImages = [];
  List<dynamic> nIDConvertedImages = [];
  List<dynamic> cConvertedImages = [];
  List<dynamic> eConvertedImages = [];

//Image URL

  String staffImageUrl = '';
  String nIDImageUrl = '';
  String cImageUrl = '';
  String eImageUrl = '';

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

  String? _staffName;
  String? _birthDate;
  String? _fatherName;
  String? _motherName;
  String? _referenceName;
  String? _referenceRelation;
  String? _nationality;
  String? _religion;
  String? _maritalType;

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
  String? _status;
  String? _msalary;

  //Dropdown controller
  final maritalTypeController = TextEditingController();
  final studentClassController = TextEditingController();
  final studentSectionController = TextEditingController();
  final studentBranchController = TextEditingController();
  final studentStatusController = TextEditingController();
  final List<String> maritalStatusList = ['Married', 'Unmarried'];
  final List<String> sectionList = ['Nurani', 'Ampara', 'Najera', 'Hifj'];
  final List<String> branchList = [
    'Boys',
    'Girls',
  ];
  final List<String> statusList = [
    'Residential',
    'Non-resident',
    'Daycare',
    'Night Care',
    'Full Time',
  ];
  final List<String> classList = [
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
  String? maritalType;
  String? studentClass;
  String? studentSection;
  String? studentBranch;
  String? studentStatus;

  //selected frame
  String selectedFrame = '';
  String nid = '';
  String certificate = '';
  String experience = '';
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            color: IMColors.white,
                            child: Stack(
                              children: [
                                tConvertedImages.isNotEmpty
                                    ? Container(
                                        child: Image.memory(
                                          tConvertedImages[0],
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : SizedBox(),
                                Positioned.fill(
                                  child: TextButton(
                                    onPressed: () {
                                      tConvertedImages.clear();
                                      setState(() {
                                        selectedFrame = 'Stuff';
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
                                          "Stuff",
                                          style: IMTextStyle.IMHeader.copyWith(
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    nIDConvertedImages.clear();
                                    setState(() {
                                      selectedFrame = 'NID';
                                    });
                                    pickedImage();
                                  },
                                  child: Text(
                                    nid == '' ? "NID" : nid,
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
                                      cConvertedImages.clear();
                                      setState(() {
                                        selectedFrame = 'Experience';
                                      });
                                      pickedImage();
                                    },
                                    child: Text(
                                      experience == ''
                                          ? "Experience"
                                          : experience,
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
                    width: publicProvider.pageWidth(size) * .5,
                    child: stuffInfoWidget(
                        firebaseProvider, publicProvider, size)),
                Container(
                    width: publicProvider.pageWidth(size) * .5,
                    child: stuffAddressWidget(
                        firebaseProvider, publicProvider, size)),
                // Container(
                //     width: publicProvider.pageWidth(size) * .3,
                //     child: joiningInfoWidget(
                //         firebaseProvider, publicProvider, size)),
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

  Widget stuffInfoWidget(FirebaseProvider firebaseProvider,
      PublicProvider publicProvider, Size size) {
    ScrollController scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Stuff Info",
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
                    hintText: "Stuff Name",
                    onSaved: (String? value) {
                      setState(() {
                        _staffName = value;
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
                    hintText: "Reference Name",
                    onSaved: (String? value) {
                      setState(() {
                        _referenceName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Reference Relation",
                    onSaved: (String? value) {
                      setState(() {
                        _referenceRelation = value;
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
                SizedBox(
                  height: 10,
                ),
                CustomDropdown(
                  hintText: 'Marital status',
                  items: maritalStatusList,
                  controller: maritalTypeController,
                  onChanged: (val) {
                    setState(() {
                      maritalType = maritalTypeController.text;
                    });
                    print(maritalType);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomDropdown(
                  hintText: 'Select Status',
                  items: statusList,
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
                    hintText: "Designatio n",
                    onSaved: (String? value) {
                      setState(() {
                        _msalary = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Monthly Salary",
                    onSaved: (String? value) {
                      setState(() {
                        _msalary = value;
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

  Widget joiningInfoWidget(FirebaseProvider firebaseProvider,
      PublicProvider publicProvider, Size size) {
    ScrollController scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Joining Info",
            style: IMTextStyle.IMHeader.copyWith(
                fontSize: 20, color: Colors.black),
          ),
          Form(
            key: _formKeyThree,
            child: Column(
              children: [
                CustomDropdown(
                  hintText: 'Select Status',
                  items: statusList,
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
                    hintText: "Designation",
                    onSaved: (String? value) {
                      setState(() {
                        _msalary = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IMTextFormField(
                    hintText: "Monthly Salary",
                    onSaved: (String? value) {
                      setState(() {
                        _msalary = value;
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

  Widget stuffAddressWidget(FirebaseProvider firebaseProvider,
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
          if (selectedFrame == 'Stuff') {
            print('Stuff');
            var snapshot = await fs
                .ref()
                .child('Stuff Photo')
                .child(image.name)
                .putBlob(image);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            setState(() {
              staffImageUrl = downloadUrl;
            });
          } else if (selectedFrame == 'NID') {
            setState(() {
              nid = image.name;
            });
            var snapshot = await fs
                .ref()
                .child('Stuff Photo')
                .child(image.name)
                .putBlob(image);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            setState(() {
              nIDImageUrl = downloadUrl;
            });
          } else if (selectedFrame == 'Experience') {
            setState(() {
              experience = image.name;
            });
            var snapshot = await fs
                .ref()
                .child('Stuff Photo')
                .child(image.name)
                .putBlob(image);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            setState(() {
              eImageUrl = downloadUrl;
            });
          }
        });

        reader.onLoad.first.then((res) {
          final encoded = reader.result as String;
          final stripped =
              encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
          setState(() {
            data = base64.decode(stripped);
            if (selectedFrame == 'Stuff') {
              tConvertedImages.add(data);
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

    Map<String, dynamic> map = {
      'stuffID': id,
      'stuffName': _staffName!,
      'fatherName': _fatherName!,
      'motherName': _motherName!,
      'referenceName': _referenceName!,
      'referenceRelation': _referenceRelation!,
      'nationality': _nationality!,
      'religion': _religion!,
      'dOb': _birthDate!,
      'maritalType': maritalTypeController.text,
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
      'status': studentStatusController.text,
      'salary': _msalary!,
      'stuffImageUrl': staffImageUrl,
      'nIDImageUrl': nIDImageUrl,
      'eImageUrl': eImageUrl,
      'date': dateData,
      'id': id,
    };

    await firebaseProvider.joinStuffData(map).then((value) async {
      if (value) {
        showToast('Successfully Joined');
        setState(() {
          _emptyFildCreator();
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
      _fatherName = String.fromCharCodes([]);
      _motherName = String.fromCharCodes([]);
      _nationality = String.fromCharCodes([]);
      _religion = String.fromCharCodes([]);
      _birthDate = String.fromCharCodes([]);
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
      nIDImageUrl = String.fromCharCodes([]);
    });
  }
}
