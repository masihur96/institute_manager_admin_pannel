import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/constants.dart';
import 'package:institute_manager_admin_pannel/pages/login_page.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/firebase_provider.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/public_provider.dart';
import 'package:institute_manager_admin_pannel/responsive.dart';
import 'package:institute_manager_admin_pannel/variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  static const String id = "main_page_screen";
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  int counter = 0;

  _customInit(FirebaseProvider firebaseProvider) async {
    counter++;
    await firebaseProvider.getAdminData();
    await firebaseProvider.getRate();
    await firebaseProvider.getUser();
    await firebaseProvider.getCategory();
    await firebaseProvider.getSubCategory();
    await firebaseProvider.getStudents();
    await firebaseProvider.getPackage();
    await firebaseProvider.getAreaHub();
    await firebaseProvider.getWithdrawRequest();
    await firebaseProvider.getDepositRequest();
    await firebaseProvider.getInsurancePendingRequest();
    await firebaseProvider.getInsuranceTransferredRequest();
    await firebaseProvider.getSoldPackage();
    await firebaseProvider.getProductOrder();
    await firebaseProvider.getPackageRequest();
    // firebaseProvider.getDepositHistory('01929444532');
    await firebaseProvider.getVideo();
    await firebaseProvider.getAdminData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    // if (counter == 0) _customInit(firebaseProvider);

    if ((defaultTargetPlatform == TargetPlatform.iOS) ||
        (defaultTargetPlatform == TargetPlatform.android)) {
      setState(() {
        publicProvider.isWindows = false;
      }); // print('iOS');
    } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
        (defaultTargetPlatform == TargetPlatform.macOS) ||
        (defaultTargetPlatform == TargetPlatform.windows)) {
      setState(() {
        publicProvider.isWindows = true;
      });
      //  print('windows'); // Some desktop specific code there
    } else {
      setState(() {
        publicProvider.isWindows = true;
      });

      // Some web specific code there
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blueGrey.shade50,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          height: 60,
          width: size.width,
          //color: Theme.of(context).primaryColor,
          decoration: BoxDecoration(color: IMColors.primaryColor),
          padding: EdgeInsets.symmetric(
              horizontal: publicProvider.isWindows
                  ? size.height * .02
                  : size.width * .02,
              vertical: publicProvider.isWindows
                  ? size.height * .01
                  : size.width * .01),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              size.width < 1300
                  ? Row(
                      children: [
                        IconButton(
                            onPressed: () =>
                                _scaffoldKey.currentState!.openDrawer(),
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            )),
                        InkWell(
                          onTap: () {
                            publicProvider.subCategory = 'Dashboard';
                            publicProvider.category = '';
                          },
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage('assets/images/logo.png'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Text('BTQM',
                                    style: TextStyle(
                                        fontSize: publicProvider.isWindows
                                            ? size.height * .035
                                            : size.width * .035,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontFamily: 'OpenSans')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        publicProvider.subCategory = 'Dashboard';
                        publicProvider.category = '';
                      },
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage('assets/images/logo.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text('BTQHM',
                                style: TextStyle(
                                    fontSize: publicProvider.isWindows
                                        ? size.height * .035
                                        : size.width * .035,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontFamily: 'OpenSans')),
                          ),
                        ],
                      ),
                    ),
              Text(publicProvider.pageHeader(),
                  style: TextStyle(
                      fontSize: publicProvider.isWindows
                          ? size.height * .03
                          : size.width * .03,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: 'OpenSans')),
              Row(
                children: [
                  Row(
                    children: [
                      size.width < 1300
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  publicProvider.subCategory =
                                      'Student Admission';
                                  publicProvider.category = '';
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: IMColors.secondaryColor,
                              ))
                          : ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    IMColors.secondaryColor),
                              ),
                              onPressed: () {
                                setState(() {
                                  publicProvider.subCategory =
                                      'Student Admission';
                                  publicProvider.category = '';
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: IMColors.primaryColor,
                              ),
                              label: Text(
                                "Add Student",
                                style: TextStyle(color: IMColors.primaryColor),
                              ),
                            ),
                      PopupMenuButton(
                        offset: Offset(0, kToolbarHeight),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    publicProvider.subCategory =
                                        'Regular Orders';
                                    publicProvider.category = '';
                                  });
                                },
                                child: Text(
                                  'You Have ${firebaseProvider.productPendingOrderList.length + firebaseProvider.packagePendingOrderList.length} new Orders',
                                  style: TextStyle(
                                    fontSize: publicProvider.isWindows
                                        ? size.height * .02
                                        : size.width * .02,
                                  ),
                                )),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    publicProvider.subCategory = 'Withdraw';
                                    publicProvider.category = '';
                                  });
                                },
                                child: Text(
                                    'You Have ${firebaseProvider.withdrawRequestList.length} Withdraw Request',
                                    style: TextStyle(
                                      fontSize: publicProvider.isWindows
                                          ? size.height * .02
                                          : size.width * .02,
                                    ))),
                            value: 1,
                          ),
                        ],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Stack(
                            children: [
                              Icon(
                                Icons.notifications,
                                size: 20,
                                color: Colors.white,
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                      radius: 6,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        '${firebaseProvider.packagePendingOrderList.length + firebaseProvider.productPendingOrderList.length + firebaseProvider.withdrawRequestList.length}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 7),
                                      )))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: size.height * .01),
                      PopupMenuButton(
                        offset: Offset(0, kToolbarHeight),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    publicProvider.subCategory = 'Settings';
                                    publicProvider.category = '';
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Change Password',
                                      style: TextStyle(
                                        fontSize: publicProvider.isWindows
                                            ? size.height * .02
                                            : size.width * .02,
                                      )),
                                )),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                          PopupMenuItem(
                            child: InkWell(
                                onTap: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.clear();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LoginPage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Logout',
                                      style: TextStyle(
                                        fontSize: publicProvider.isWindows
                                            ? size.height * .02
                                            : size.width * .02,
                                      )),
                                )),
                            value: 1,
                          ),
                        ],
                        child: Icon(
                          Icons.account_circle,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: NavigationDrawer(),
      body: _bodyUI(size, publicProvider),
    );
  }

  Widget _bodyUI(Size size, PublicProvider publicProvider) => Container(
        height: size.height,
        width: size.width,
        color: IMColors.secondaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [SideBar(), publicProvider.pageBody()],
        ),
      );
}

///Sidebar
class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Container(
      width: size.width < 1300 || publicProvider.isWindows == false
          ? 0.0
          : size.width * .15,
      height: size.height,
      decoration: BoxDecoration(color: IMColors.primaryColor),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SidebarContentBuilder(title: 'Dashboard'),
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: Variables.sideBarMenuList().length,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => EntryItemTile(
                Variables.sideBarMenuList()[index],
                size,
                publicProvider,
                context),
          ),
          SidebarContentBuilder(title: 'Contact Info'),
          SidebarContentBuilder(title: 'Settings'),
        ],
      ),
    );
  }
}

///Sidebar Builder
// ignore: must_be_immutable
class SidebarContentBuilder extends StatelessWidget {
  String title;
  SidebarContentBuilder({required this.title});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: InkWell(
        onTap: () {
          publicProvider.subCategory = title;
          publicProvider.category = '';
          if (size.width < 1300) Navigator.pop(context);
        },
        child: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: size.height * .02,
                color: Colors.white)),
      ),
    );
  }
}

///Drawer Sidebar
class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Container(
        margin: EdgeInsets.only(top: 60),
        child: Drawer(
          elevation: 0.0,
          child: Container(
            width: size.width < 1300 ? 0.0 : size.width * .10,
            height: size.height,
            decoration: BoxDecoration(color: IMColors.primaryColor),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SidebarContentBuilder(title: 'Dashboard'),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: Variables.sideBarMenuList().length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => EntryItemTile(
                      Variables.sideBarMenuList()[index],
                      size,
                      publicProvider,
                      context),
                ),
                SidebarContentBuilder(title: 'Contact Info'),
                SidebarContentBuilder(title: 'Settings'),
              ],
            ),
          ),
        ));
  }
}

///Create the widget for the row...
// ignore: must_be_immutable
class EntryItemTile extends StatelessWidget {
  final Entry entry;
  final Size size;
  PublicProvider publicProvider;
  BuildContext context;
  EntryItemTile(this.entry, this.size, this.publicProvider, this.context);
  String? _category;
  String? _subCategory;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        onTap: () {
          _subCategory = root.title;
          publicProvider.category = _category!;
          publicProvider.subCategory = _subCategory!;
          if (size.width < 1300) Navigator.pop(context);
        },
        contentPadding: EdgeInsets.only(left: 30),
        dense: true,
        title: Text(root.title,
            style: TextStyle(
                color: Colors.white,
                fontSize: size.height * .02,
                fontFamily: 'OpenSans')),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: size.height * .02,
              color: Colors.white,
              fontFamily: 'OpenSans')),
      trailing: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      onExpansionChanged: (val) {
        _category = root.title;
      },
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
