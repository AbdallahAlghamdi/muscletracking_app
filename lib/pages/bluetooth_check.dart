import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:muscletracking_app/componets/bluetooth/bluetooth_item.dart';
import 'package:muscletracking_app/componets/bluetooth/bluetooth_list.dart';
import 'package:muscletracking_app/componets/text_icon.dart';
import 'package:muscletracking_app/pages/sensor_check.dart';

class BluetoothCheck extends StatefulWidget {
  final String muscleGroup;
  const BluetoothCheck({super.key, required this.muscleGroup});

  @override
  State<BluetoothCheck> createState() => _BluetoothCheckState();
}

class _BluetoothCheckState extends State<BluetoothCheck> {
  @override
  void initState() {
    super.initState();
  }

  bool clicked = false;
  List<bool> devicesConnected = [false, false, false];
  connect(int index) {
    for (int i = 0; i < devicesConnected.length; i++) {
      setState(() {
        clicked = true;
        if (i != index) {
          devicesConnected[i] = false;
        } else {
          devicesConnected[i] = true;
        }
      });
    }
  }

  goToSensorCheck() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SensorCheck(muscleGroup: widget.muscleGroup)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Bluetooth",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        actions: const [
          Icon(
            Icons.bluetooth,
            color: Colors.white,
          ),
          SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          Center(
            child: BluetoothList(
              list: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  children: [
                    BluetoothItem(
                      deviceName: "Lenovo XT10 Headphones",
                      function: () => connect(0),
                      connected: devicesConnected[0],
                    ),
                    BluetoothItem(
                      deviceName: "Muscle Sensor",
                      function: () => connect(1),
                      connected: devicesConnected[1],
                    ),
                    BluetoothItem(
                      deviceName: "Xiaomi Mi band",
                      function: () => connect(2),
                      connected: devicesConnected[2],
                    ),
                  ]),
            ),
          ),
          Visibility(
              visible: clicked,
              child: Container(
                margin: EdgeInsets.all(25),
                child: Lottie.asset(devicesConnected[1]
                    ? "lib/icons/reactions/holding_hands.json"
                    : "lib/icons/reactions/disappointed.json"),
              )),
          Visibility(
            visible: devicesConnected[1],
            child: ElevatedButton(
              onPressed: goToSensorCheck,
              child: const TextIcon(
                text: "Continue",
                icon: FontAwesomeIcons.personWalkingArrowRight,
              ),
            ),
          ),
          Visibility(
            visible: !devicesConnected[1] && clicked,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: RichText(
                text: const TextSpan(
                    text: "Oh no! A different ",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    children: [
                      TextSpan(
                          text: "bluetooth",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              " device was connected. make sure you are near the sensor and click '"),
                      TextSpan(
                          text: "Muscle sensor",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                      TextSpan(text: "'")
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
