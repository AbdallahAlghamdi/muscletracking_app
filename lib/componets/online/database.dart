import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muscletracking_app/componets/mail/mail.dart';
import 'package:muscletracking_app/utils/patient.dart';
import 'package:muscletracking_app/utils/patient_progress.dart';

const String serverURL = '10.0.2.2:5000';
// const String serverURL = 'cherubim-w8yy2.ondigitalocean.app';
postData(finalJson, String subDomainName) async {
  var url = Uri.http(serverURL, subDomainName);
  var response = await http.post(url,
      body: jsonEncode(finalJson),
      headers: {"Content-Type": "application/json"});
  if (response.statusCode != 200) {
    return false;
  }
  return true;
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
}

updateData(String subDomainName) async {
  var url = Uri.http(serverURL, subDomainName);
  var response = await http.put(url);
  if (response.statusCode != 200) {
    print("update failed");
  }
}

Future<String> getData(String subDomainName) async {
  var url = Uri.http(serverURL, subDomainName);
  var response = await http.get(url);
  if (response.statusCode != 200) {
    return "";
  }
  return response.body;
}

newMail(int sender, int receiver, String messageContent, String messageTitle) {
  Map<String, dynamic> finalJson = {};

  finalJson["sender"] = sender;
  finalJson["receiver"] = receiver;
  finalJson["message_content"] = messageContent;
  finalJson["message_title"] = messageTitle;
  postData(finalJson, '/newMail');
}

Future<bool> newAccount(String username, String password, String accountName,
    String accountType) async {
  Map<String, dynamic> finalJson = {};

  finalJson["username"] = username;
  finalJson["password"] = password;
  finalJson["accountName"] = accountName;
  finalJson["accountType"] = accountType;
  return await postData(finalJson, '/signUp');
}

newExercise(int accountNumber, double average, String muscleGroup,
    List<int> numbers, int duration) {
  Map<String, dynamic> finalJson = {};

  finalJson["account_number"] = accountNumber;
  finalJson["average_data"] = average;
  finalJson["muscle_group"] = muscleGroup;
  finalJson["raw_data"] = numbers;
  finalJson["duration"] = duration;

  postData(finalJson, '/newExcercise');
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

Future<bool> addPatientByID(int doctorNumber, int patientNumber) async {
  String subDomainName = "addPatient/$doctorNumber/$patientNumber";
  var url = Uri.http(serverURL, subDomainName);
  var response = await http.post(url);
  if (response.statusCode != 200) {
    return false;
  }
  return true;
}

Future<Map<String, dynamic>?> login(String username, String password) async {
  var tempBody = await getData('/login/$username/$password');
  if (tempBody.isEmpty) {
    return null;
  } else {
    Map<String, dynamic> loginInformation = {};
    var body = jsonDecode(tempBody);
    print(body);
    // int account_number = body[0]["account_number"];
    loginInformation["account_number"] = body[0]["account_number"].toString();
    loginInformation["status"] = body[0]["_status"];
    loginInformation["name"] = body[0]["_name"];
    return loginInformation;
  }
}

Future<Map<int, String>> getUserRecipients(int account_number) async {
  Map<int, String> result = {};
  var tempBody = await getData('/getRecipients/$account_number');
  if (tempBody.isEmpty) {
    return {};
  }
  var body = jsonDecode(tempBody);
  for (var element in body) {
    result[element["account_number"]] = element["_name"];
  }
  return result;
}

Future<List<Mail>> getMail(int accountNumber, String accountName) async {
  List<Mail> mail = [];
  var tempbody = await getData("/getMail/$accountNumber");
  if (tempbody.isEmpty) {
    return [];
  }
  var body = jsonDecode(tempbody);
  print(body);
  for (var element in body) {
    DateTime time = DateTime.parse(element["_date"]);
    String senderName = element["_name"];
    String message = element["message_content"];
    String messageTitle = element["message_title"];
    int hasRead = element["hasRead"];
    int messageID = element["_id"];
    print(hasRead == 1);

    mail.add(Mail(
      messageID: messageID,
      fromUser: senderName,
      toUser: accountName,
      message: message,
      time: time,
      title: messageTitle,
      hasRead: hasRead == 1,
      isSent: false,
    ));
    // print(element["_date"]);
  }
  return mail;
}

Future<List<Mail>> getSentMail(int accountNumber, String accountName) async {
  List<Mail> mail = [];
  var tempbody = await getData("/getSentMail/$accountNumber");
  if (tempbody.isEmpty) {
    return [];
  }
  var body = jsonDecode(tempbody);
  print(body);
  for (var element in body) {
    DateTime time = DateTime.parse(element["_date"]);
    String senderName = element["_name"];
    String message = element["message_content"];
    String messageTitle = element["message_title"];
    int messageID = element["_id"];
    mail.add(Mail(
      messageID: messageID,
      fromUser: accountName,
      toUser: senderName,
      message: message,
      time: time,
      title: messageTitle,
      hasRead: false,
      isSent: true,
    ));
    // print(element["_date"]);
  }
  return mail;
}

setMessageOpened(int messageID) {
  updateData("/readMail/$messageID");
}

Future<int> getNotifications(int accountNumber) async {
  var tempBody = await getData("/getNotifications/$accountNumber");
  if (tempBody.isEmpty) {
    return 0;
  }
  var body = jsonDecode(tempBody);

  return body[0]["_count"];
}

Future<Map<int, PatientProgress>> getSummaryMilestones(
    int accountNumber) async {
  var tempBody = await getData("/getSummary/$accountNumber");
  if (tempBody.isEmpty) {
    return {};
  }
  var body = jsonDecode(tempBody);
  Map<int, PatientProgress> patientList = {};
  for (var element in body) {
    print(element);
    if (!patientList.containsKey(element["account_number"])) {
      int patientAccountNumber = element["account_number"];
      String patientName = element["_name"];
      String muscleGroup = 'BICEP';
      if (element["muscleGroup"] != null) {
        muscleGroup = element["muscleGroup"];
      }
      int passedDuration = 0;
      if (element["passedDuration"] != null) {
        passedDuration = element["passedDuration"];
      }
      int duration = 1;
      if (element["duration"] != null) {
        element["duration"];
      }
      int muscleIndex = 0;
      muscleIndex = getMuscleIndex(muscleGroup);
      List<int> milestones = [0, 0, 0, 0];
      List<int> progress = [0, 0, 0, 0];
      milestones[muscleIndex] = duration;
      progress[muscleIndex] = passedDuration;
      patientList[patientAccountNumber] = PatientProgress(
          milestones, progress, patientName, "weekly", patientAccountNumber);
    } else {
      int patientAccountNumber = element["account_number"];
      PatientProgress tempProgress = patientList[patientAccountNumber]!;
      String muscleGroup = element["muscleGroup"];
      int passedDuration = element["passedDuration"];
      int duration = element["duration"];
      int muscleIndex = 0;
      muscleIndex = getMuscleIndex(muscleGroup);
      tempProgress.milestone[muscleIndex] = duration;
      tempProgress.progress[muscleIndex] = passedDuration;
      patientList[patientAccountNumber] = tempProgress;

      // print("old patient");
    }
  }
  return patientList;
}

Future<PatientProgress> getPatientSummary(
    int patientID, String duration, String patientName) async {
  var tempbody = await getData("/getPatientSummary/$patientID/${duration[0]}");
  PatientProgress currentPatient =
      PatientProgress([0, 0, 0, 0], [0, 0, 0, 0], patientName, duration, 0000);
  if (tempbody.isEmpty) {
    return currentPatient;
  }
  var body = jsonDecode(tempbody);
  for (var element in body) {
    String muscleGroup = element["muscleGroup"];
    int tempDuration = 0;
    if (element["daily"] != null) {
      tempDuration = element["daily"];
    } else if (element["weekly"] != null) {
      tempDuration = element["weekly"];
    } else if (element["monthly"] != null) {
      tempDuration = element["monthly"];
    } else if (element["yearly"] != null) {
      tempDuration = element["yearly"];
    }
    int passedDuration = 0;
    if (element["passedDuration"] == null || element["passedDuration"] < 1) {
      passedDuration = 0;
    } else {
      passedDuration = element["passedDuration"];
    }
    int muscleIndex = getMuscleIndex(muscleGroup);
    currentPatient.milestone[muscleIndex] = tempDuration;
    currentPatient.progress[muscleIndex] = passedDuration;
  }
  return currentPatient;
}

// var url = Uri.http('cherubim-w8yy2.ondigitalocean.app',
// 'getavg/555/${muscleSelectedGroup.toUpperCase()}');
int getMuscleIndex(String muscleGroup) {
  print("MUSCLE GROUP: $muscleGroup");
  switch (muscleGroup) {
    case "BICEP":
      return 0;
    case "CALF":
      return 1;
    case "THIGH":
      return 2;
    case "FOREARM":
      return 3;
    default:
      return -1;
  }
}

sendNewMilestone(
    int newMilestone, int patientID, String muscleGroup, String durationIndex) {
  print("new milestone submit");
  postData({},
      "/newMilestone/$patientID/$newMilestone/${muscleGroup.toUpperCase()}/$durationIndex");
  // newMilestone/<int:patientID>/<duration>/<muscleGroup>/<durationGroup>
}
