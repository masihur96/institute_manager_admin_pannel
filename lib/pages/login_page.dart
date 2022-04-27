import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:institute_manager_admin_pannel/constants.dart';
import 'package:institute_manager_admin_pannel/pages/main_page.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/firebase_provider.dart';
import 'package:institute_manager_admin_pannel/model/provider_model/public_provider.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/fading_circle.dart';
import 'package:institute_manager_admin_pannel/pages/custom_widget/form_decoration.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String id = "login_screen";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userNameTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  bool _isLoading = false;

  int counter = 0;

  _customInit(FirebaseProvider firebaseProvider) async {
    counter++;
    await firebaseProvider.getAdminData();
  }

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    final Size size = MediaQuery.of(context).size;
    if ((defaultTargetPlatform == TargetPlatform.iOS) ||
        (defaultTargetPlatform == TargetPlatform.android)) {
      setState(() {
        publicProvider.isWindows = false;
      });
    } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
        (defaultTargetPlatform == TargetPlatform.macOS) ||
        (defaultTargetPlatform == TargetPlatform.windows)) {
      setState(() {
        publicProvider.isWindows = true;
      });
    } else {
      setState(() {
        publicProvider.isWindows = true;
      });
    }
    if (counter == 0) {
      _customInit(firebaseProvider);
    }

    return Scaffold(
        backgroundColor: Colors.blueGrey.shade700,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: publicProvider.isWindows
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    size.width > 700
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              publicProvider.isWindows
                                  ? ClipRRect(
                                      child: Image.asset(
                                        IMAsset.appLogo,
                                        fit: BoxFit.fill,
                                        width: size.width * .15,
                                        height: size.width * .15,
                                      ),
                                    )
                                  : Container(),
                              Text(
                                'BTQM',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: size.height * .04,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                              Text(
                                'একটি অনলাইন মাদরাসা',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: size.height * .03,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.yellow),
                              ),
                            ],
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          size.width < 700
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'BTQM এ আপনাকে \n স্বাগতম',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: size.height * .04,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : Container(),
                          Container(
                            width: size.height * .5,
                            height: size.height * .5,
                            child: _formLogin(context),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BTQM এ আপনাকে \n স্বাগতম',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * .04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          child: Image.asset(
                            IMAsset.appLogo,
                            fit: BoxFit.fill,
                            width: size.width * .1,
                            height: size.width * .1,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 6),
                      child: Container(
                        width: size.width * .1,
                        child: _formLogin(context),
                      ),
                    )
                  ],
                ),
        ));
  }

  Widget _formLogin(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final FirebaseProvider firebaseProvider =
        Provider.of<FirebaseProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.grey),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'BTQM এ আপনাকে \n স্বাগতম',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: publicProvider.isWindows
                    ? size.height * .03
                    : size.width * .03,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Container(
                width: publicProvider.isWindows
                    ? size.height * .5
                    : size.width * .6,
                child: TextField(
                  controller: userNameTextController,
                  decoration: textFieldFormDecorationLogin(size, publicProvider)
                      .copyWith(
                    labelText: 'আপনার নাম',
                    hintText: 'আপনার নাম',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Container(
                width: publicProvider.isWindows
                    ? size.height * .5
                    : size.width * .6,
                child: TextField(
                  controller: passwordTextController,
                  decoration: textFieldFormDecorationLogin(size, publicProvider)
                      .copyWith(
                    labelText: 'পাসওয়ার্ড',
                    hintText: 'পাসওয়ার্ড',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                    width: publicProvider.isWindows
                        ? size.height * .4
                        : size.width * .5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      "লগইন",
                      textAlign: TextAlign.center,
                    )),
              ),
              onPressed: () async {
                if (firebaseProvider.adminList[0].userName ==
                        userNameTextController.text &&
                    firebaseProvider.adminList[0].password ==
                        passwordTextController.text) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setString('phone', userNameTextController.text);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MainPage()));
                } else {
                  showToast('আপনি ভুল পাসওয়ার্ড দিয়েছেন');
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
