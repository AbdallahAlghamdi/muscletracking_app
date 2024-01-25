import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muscletracking_app/componets/login_button.dart';
import 'package:muscletracking_app/utils/patient.dart';

const String serverURL = '10.0.2.2:5000';
// const String serverURL = 'cherubim-w8yy2.ondigitalocean.app';

newExercise(
    int accountNumber, double average, String muscleGroup, List<int> numbers) {
  Map<String, dynamic> finalJson = {};

  finalJson["account_number"] = accountNumber;
  finalJson["average_data"] = average;
  finalJson["muscle_group"] = muscleGroup;
  finalJson["raw_data"] = numbers;
  postData(finalJson, '/newExcercise');
}

postData(finalJson, String subDomainName) async {
  var url = Uri.https(serverURL, subDomainName);
  await http.post(url,
      body: jsonEncode(finalJson),
      headers: {"Content-Type": "application/json"});
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
}

Future<String> getData(String subDomainName) async {
  var url = Uri.http(serverURL, subDomainName);
  var response = await http.get(url);
  if (response.statusCode != 200) {
    return "";
  }
  return response.body;
}

Future<List<Patient>> getPatientsNames(int physicianID) async {
  List<Patient> patientList = [];
  var body = jsonDecode(await getData('/getPatientInfo/$physicianID'));
  for (var element in body) {
    patientList.add(Patient(element["_name"], element['account_number']));
  }
  return patientList;
}

Future<List<double>> getAverageMuscleData(
    int patientID, String muscleName, String duration) async {
  List<double> data = [];
  var response = await getData(
      "getavg/$patientID/${muscleName.toUpperCase()}/'$duration'");
  if (response == "") {
    return [];
  }
  var body = jsonDecode(response);
  if (body == null) {
    return [];
  }
  for (var element in body) {
    data.add(element['average_data']);
  }
  return data;
}

Future<List<int>> getExerciseID(
    int patientID, String muscleName, String duration) async {
  List<int> data = [];
  var response = await getData(
      "getExcerciseID/$patientID/${muscleName.toUpperCase()}/'$duration'");

  if (response.isEmpty) {
    print("EMPTY");
    return [];
  }
  var body = jsonDecode(response);

  for (var element in body) {
    data.add(element['_id']);
  }
  return data;
}

Future<List<double>> getDetailedExercise(int exerciseNumber) async {
  List<double> exerciseData = [];
  var body = jsonDecode(await getData("/getDetailExercise/$exerciseNumber"));
  if (body == null) {
    return [];
  }
  for (var element in body) {
    exerciseData.add(element['value'].toDouble());
  }
  return exerciseData;
}

addPatientByID(int doctorNumber, int patientNumber) async {
  String subDomainName = "addPatient/$doctorNumber/$patientNumber";
  var url = Uri.http(serverURL, subDomainName);
  await http.post(url);
}

Future<Map<String, dynamic>?> login(String username, String password) async {
  var tempBody = await getData('/login/$username/$password');
  if (tempBody == "") {
    return null;
  } else {
    Map<String, dynamic> loginInformation = {};
    var body = jsonDecode(tempBody);
    print(body);
    int account_number = body[0]["account_number"];
    loginInformation["account_number"] = body[0]["account_number"].toString();
    loginInformation["status"] = body[0]["_status"];
    loginInformation["name"] = body[0]["_name"];
    return loginInformation;
  }
}

// var url = Uri.http('cherubim-w8yy2.ondigitalocean.app',
        // 'getavg/555/${muscleSelectedGroup.toUpperCase()}');