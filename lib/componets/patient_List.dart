import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:muscletracking_app/online/database.dart';
import 'package:muscletracking_app/utils/patient.dart';

class PatientList extends StatefulWidget {
  final int doctorID;
  final Function(int) function;
  final DropdownController controller;
  const PatientList(
      {super.key,
      required this.doctorID,
      required this.function,
      required this.controller});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  getPatientsList(int doctorID) async {
    List<Patient> patientList = await getPatientsNames(doctorID);
    if (mounted) {
      setState(() {
        for (var element in patientList) {
          String tempName = element.getName();
          int tempID = element.getID();
          patientsName.add(CoolDropdownItem(
            label: tempName,
            value: tempID,
            icon: Image.asset(
              'lib/icons/icon_patient.png',
              width: 20,
            ),
          ));
        }
      });
    }
  }

  List<CoolDropdownItem<int>> patientsName = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPatientsList(widget.doctorID);
  }

  @override
  Widget build(BuildContext context) {
    return CoolDropdown(
        dropdownItemOptions: const DropdownItemOptions(
            mainAxisAlignment: MainAxisAlignment.spaceBetween),
        dropdownList: patientsName,
        controller: widget.controller,
        onChange: widget.function);
  }
}
