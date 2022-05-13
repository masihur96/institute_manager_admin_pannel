import 'package:institute_manager_admin_pannel/controller/connection_helper.dart';
import 'package:institute_manager_admin_pannel/model/data_model/student_model.dart';

class DataFetcher {
  final ConnectionHelper _connectionHelper = ConnectionHelper();

  Future<List<StudentModel>> getStudents() async {
    List<StudentModel> allStudents = [];
    try {
      await _connectionHelper.getAllStudents('Student').then((snapShot) {
        snapShot.docChanges.forEach((element) {
          StudentModel studentModel = StudentModel(
            id: element.doc['id'],
            date: element.doc['date'],
            addFee: element.doc['addFees'],
            bcImageUrl: element.doc['bCImageUrl'],
            branch: element.doc['branch'],
            admittedClass: element.doc['class'],
            dOB: element.doc['dOb'],
            email: element.doc['email'],
            fatherName: element.doc['fatherName'],
            guardianName: element.doc['guardianName'],
            guardianRelation: element.doc['guardianRelation'],
            mFee: element.doc['mFees'],
            mahfilFee: element.doc['mahfilFees'],
            motherName: element.doc['motherName'],
            nIDImageUrl: element.doc['nIDImageUrl'],
            nationality: element.doc['nationality'],
            othersFee: element.doc['othersFees'],
            parent1ImageUrl: element.doc['parent1ImageUrl'],
            parent2ImageUrl: element.doc['parent2ImageUrl'],
            phoneNo: element.doc['phoneNo'],
            post: element.doc['post'],
            prPost: element.doc['prPost'],
            prThana: element.doc['prThana'],
            prVillage: element.doc['prVillage'],
            prZila: element.doc['prZila'],
            religion: element.doc['religion'],
            roll: element.doc['roll'],
            section: element.doc['section'],
            status: element.doc['status'],
            studentID: element.doc['studentID'],
            studentImageUrl: element.doc['studentImageUrl'],
            studentName: element.doc['studentName'],
            studentType: element.doc['studentType'],
            tcImageUrl: element.doc['tCImageUrl'],
            thana: element.doc['thana'],
            tourFees: element.doc['tourFees'],
            village: element.doc['village'],
            zila: element.doc['zila'],
          );
          allStudents.add(studentModel);
        });
      });
    } catch (e) {
      print(e);
    }

    return allStudents;
  }

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
