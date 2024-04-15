import 'dart:convert';
import 'package:http/http.dart' as http;

const String serverURL = 'cherubim-w8yy2.ondigitalocean.app';
//Link to the server

Future<bool> postData(finalJson, String subDomainName) async {
  //Sends the Json and query the SubDomain Name, with method POST
  var url = Uri.https(serverURL, subDomainName); //setting the URL
  var response = await http.post(url,
      body: jsonEncode(finalJson),
      headers: {"Content-Type": "application/json"}); //POST request
  if (response.statusCode != 200) {
    //if the status code is not 200, then return false, to indicate some errors
    return false;
  }
  return true;
}

updateData(String subDomainName) async {
  //Sends a request with the PUT method in the supplied subDomain Name.
  var url = Uri.https(serverURL, subDomainName);
  await http.put(url);
}

Future<String> getData(String subDomainName) async {
  //Sends a request with the GET method in the supplied subDomain Name.
  var url = Uri.https(serverURL, subDomainName);
  var response = await http.get(url);
  if (response.statusCode != 200) {
    //return an empty string if the status code is not 200
    return "";
  }
  return response.body;
}
