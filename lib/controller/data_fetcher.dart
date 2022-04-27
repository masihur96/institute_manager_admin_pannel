import 'package:institute_manager_admin_pannel/controller/connection_helper.dart';

class DataFetcher {
  final ConnectionHelper _connectionHelper = ConnectionHelper();

  // Future<AuthToken?> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   AuthToken? authToken;
  //   dynamic data = {"email": email, "password": password};
  //   Response<dynamic>? response =
  //       await _connectionHelper.postData(API.postLogin, data);
  //   if (response != null) {
  //     if (response.statusCode == 200) {
  //       var data = response.data["data"];
  //       authToken = AuthToken(
  //         accessToken: data["access_token"],
  //         refreshToken: data["refresh_token"],
  //       );
  //     }
  //   }
  //   return authToken;
  // }
  //
  // Future<bool> register({
  //   required String email,
  //   required String address,
  //   required String name,
  //   required String password,
  // }) async {
  //   bool status = false;
  //   dynamic data = {
  //     "password": password,
  //     "email": email,
  //     "address": address,
  //     "first_name": name,
  //     "last_name": name
  //   };
  //
  //   Response<dynamic>? response =
  //       await _connectionHelper.postData(API.postRegister, data);
  //   if (response != null) {
  //     if (response.statusCode == 201) {
  //       var data = response.data["message"];
  //
  //       print("DATAAAAAA ${data}");
  //
  //       status = true;
  //     }
  //   }
  //   return status;
  // }
  //
  // Future<bool> emailValidator({
  //   required String email,
  //   required String verificationCode,
  // }) async {
  //   bool status = false;
  //   dynamic data = {
  //     "verification_code": verificationCode,
  //     "email": email,
  //   };
  //
  //   Response<dynamic>? response =
  //       await _connectionHelper.postData(API.postEmailValidator, data);
  //   if (response != null) {
  //     if (response.statusCode == 201) {
  //       status = true;
  //     }
  //   }
  //   return status;
  // }
  //
  // // Location [Booking Service APIs]
  // Future<List<Location>> getAllLocations() async {
  //   List<Location> allLocations = [];
  //   print(API.getAllLocations);
  //   Response? response = await _connectionHelper.getData(API.getAllLocations);
  //   if (response != null) {
  //     if (response.statusCode == 200) {
  //       var data = response.data;
  //       // try {
  //       var locations = data["data"];
  //       for (var location in locations) {
  //         allLocations.add(
  //           Location(
  //             uid: location["uuid"],
  //             name: location["name"],
  //             terminalName: location["terminal"],
  //             description: location["description"],
  //             imageUrl: null,
  //           ),
  //         );
  //       }
  //       // } catch (e) {
  //       //   print(e);
  //       // }
  //     }
  //   }
  //   return allLocations;
  // }
  //
  // // Get Available Launch With Location [Booking Service APIs]
  //
  // Future<List<Launch>> getAvailableLaunchWithLocation({
  //   required String departure,
  //   required String destination,
  //   required String date,
  // }) async {
  //   // print(departure);
  //   List<Launch> availableLaunch = [];
  //   bool status = false;
  //   dynamic data = {
  //     "location_from": departure,
  //     "location_to": destination,
  //     "trip_date": date,
  //   };
  //
  //   print(data);
  //
  //   Response<dynamic>? response =
  //       await _connectionHelper.postData(API.postAvailableLaunch, data);
  //   if (response != null) {
  //     if (response.statusCode == 201) {
  //       var data = response.data["data"];
  //       for (var launches in data) {
  //         availableLaunch.add(Launch(
  //           uid: launches["uuid"],
  //           shipId: launches["ship_uid"],
  //           name: launches!["name"],
  //           //  imageUrl: launches['imageUrl'],
  //         ));
  //       }
  //       status = true;
  //     }
  //   }
  //   return availableLaunch;
  // }
}
