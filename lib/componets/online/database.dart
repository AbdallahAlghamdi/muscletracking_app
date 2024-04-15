import 'dart:convert';
import 'package:muscletracking_app/componets/mail/mail.dart';
import 'package:muscletracking_app/componets/online/request_methods.dart';
import 'package:muscletracking_app/utils/patient.dart';
import 'package:muscletracking_app/utils/patient_progress.dart';

//---------Mail--------
newMail(int sender, int receiver, String messageContent, String messageTitle) {
  //sends new mail to the database
  Map<String, dynamic> finalJson = {}; //Map variable that turn to a JSON

  finalJson["sender"] = sender;
  finalJson["receiver"] = receiver;
  finalJson["message_content"] = messageContent;
  finalJson["message_title"] = messageTitle;
  postData(finalJson, '/newMail'); //sends the Json file
}

Future<List<Mail>> getMail(int accountNumber, String accountName) async {
  //Get inbox mail of the user.
  List<Mail> mail = [];
  var tempbody = await getData("/getMail/$accountNumber");
  if (tempbody.isEmpty) {
    return [];
  }
  var body = jsonDecode(tempbody);
  for (var element in body) {
    DateTime time = DateTime.parse(element["_date"]);
    String senderName = element["_name"];
    String message = element["message_content"];
    String messageTitle = element["message_title"];
    int hasRead = element["hasRead"];
    int messageID = element["_id"];

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
  }
  return mail;
}

Future<List<Mail>> getSentMail(int accountNumber, String accountName) async {
  //Return a list of Mail that are sent from this account
  List<Mail> mail = [];
  var tempbody = await getData("/getSentMail/$accountNumber");
  if (tempbody.isEmpty) {
    return [];
  }
  var body = jsonDecode(tempbody);
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
  }
  return mail;
}

Future<Map<int, String>> getUserRecipients(int accountNumber) async {
  //returns a map of recipients that a specific account may send messages to.
  //patients can only send a message to a physician, but physicians can message
  //many patients.
  Map<int, String> result = {};
  var tempBody = await getData('/getRecipients/$accountNumber');
  if (tempBody.isEmpty) {
    return {};
  }
  var body = jsonDecode(tempBody);
  for (var element in body) {
    result[element["account_number"]] = element["_name"];
  }
  return result;
}

setMessageOpened(int messageID) {
  //sets message as ID
  updateData("/readMail/$messageID");
}

Future<int> getNotifications(int accountNumber) async {
  //get an integer that represent the amount of unread mail
  var tempBody = await getData("/getNotifications/$accountNumber");
  if (tempBody.isEmpty) {
    return 0;
  }
  var body = jsonDecode(tempBody);
  return body[0]["_count"];
}
//---------------------

//--Account management-
Future<Map<String, dynamic>> login(String username, String password) async {
  //Start the login process if the request is successful
  //it would return the account's information
  var tempBody = await getData('/login/$username/$password');
  if (tempBody.isEmpty) {
    return {};
  } else {
    Map<String, dynamic> loginInformation = {};
    var body = jsonDecode(tempBody);
    loginInformation["account_number"] = body[0]["account_number"].toString();
    loginInformation["status"] = body[0]["_status"];
    loginInformation["name"] = body[0]["_name"];
    return loginInformation;
  }
}

Future<bool> newAccount(String username, String password, String accountName,
    String accountType) async {
  //Sends a request to make a new account.
  Map<String, dynamic> finalJson = {};

  finalJson["username"] = username;
  finalJson["password"] = password;
  finalJson["accountName"] = accountName;
  finalJson["accountType"] = accountType;
  return await postData(finalJson,
      '/signUp'); //returns true if the account was successfully created
}

Future<bool> addPatientByID(int doctorNumber, int patientNumber) async {
  //adds a patient to the physician's list of care.
  return await postData(null, "addPatient/$doctorNumber/$patientNumber");
  //returns true if the patient was sucessfully added
}
//---------------------

//-----Exercise--------
newExercise(int accountNumber, double average, String muscleGroup,
    List<int> numbers, int duration) {
  //submits new exercise session to the server
  Map<String, dynamic> finalJson = {};
  //Sends a request to make a new account.

  finalJson["account_number"] = accountNumber;
  finalJson["average_data"] = average;
  finalJson["muscle_group"] = muscleGroup;
  finalJson["raw_data"] = numbers;
  finalJson["duration"] = duration;
  postData(finalJson, '/newExcercise'); //sends JSON to the server
}

Future<List<int>> getExerciseID(
    int patientID, String muscleName, String duration) async {
  //get a list of numbers of each exercise session in a specific period.
  List<int> data = [];
  var tempBody = await getData(
      "getExcerciseID/$patientID/${muscleName.toUpperCase()}/'$duration'");

  if (tempBody.isEmpty) {
    return [];
  }
  var body = jsonDecode(tempBody);
  for (var element in body) {
    data.add(element['_id']);
  }
  return data;
}

Future<List<double>> getDetailedExercise(int exerciseNumber) async {
  //returns a list of the muscle activity in a specific exercise session.
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

Future<List<Patient>> getPatientsNames(int physicianID) async {
  //Get a list of patient who are treated by the physician.
  List<Patient> patientList = [];
  var tempBody = await getData('/getPatientInfo/$physicianID');
  if (tempBody.isEmpty) {
    return [];
  }
  var body = jsonDecode(tempBody);
  for (var element in body) {
    //Go through each returned patient and add it to a list of Patient object
    patientList.add(Patient(element["_name"], element['account_number']));
  }
  return patientList;
}

Future<List<double>> getAverageMuscleData(
    int patientID, String muscleName, String duration) async {
  //returns the average exercise session muscle activity of a period.
  List<double> data = [];
  var tempBody = await getData(
      "getavg/$patientID/${muscleName.toUpperCase()}/'$duration'");
  if (tempBody.isEmpty) {
    return [];
  }
  var body = jsonDecode(tempBody);
  for (var element in body) {
    data.add(element['average_data']);
  }
  return data;
}
//---------------------

//-----Milestones------
Future<Map<int, PatientProgress>> getSummaryMilestones(
    int accountNumber) async {
  //get the weekly progress of all the patients who are treated by the doctor
  var tempBody = await getData("/getSummary/$accountNumber");
  if (tempBody.isEmpty) {
    return {};
  }
  var body = jsonDecode(tempBody);
  Map<int, PatientProgress> patientList = {};
  for (var element in body) {
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
        duration = element["duration"];
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
      PatientProgress tempPatient = patientList[patientAccountNumber]!;
      String muscleGroup = element["muscleGroup"];
      int passedDuration = element["passedDuration"];
      int duration = element["duration"];
      int muscleIndex = 0;
      muscleIndex = getMuscleIndex(muscleGroup);
      tempPatient.milestone[muscleIndex] = duration;
      tempPatient.progress[muscleIndex] = passedDuration;
      patientList[patientAccountNumber] = tempPatient;
    }
  }

  return patientList;
}

Future<PatientProgress> getPatientSummary(
    int patientID, String duration, String patientName) async {
  //returns a list of milestones of a specific patient and time period.
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

int getMuscleIndex(String muscleGroup) {
  //returns a number that represent the muscle group
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
  //inserts new milestones
  print("test");
  postData({},
      "/newMilestone/$patientID/$newMilestone/${muscleGroup.toUpperCase()}/$durationIndex");
}
//---------------------