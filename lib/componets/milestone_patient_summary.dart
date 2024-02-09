import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/Progress_bar.dart';
import 'package:muscletracking_app/utils/patient_progress.dart';
import 'package:unicons/unicons.dart';

class MilestonePatientSummary extends StatelessWidget {
  final PatientProgress patientData;
  const MilestonePatientSummary({super.key, required this.patientData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 3, color: const Color.fromARGB(255, 72, 37, 132))),
      child: Column(children: [
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(patientData.name,
                  style: const TextStyle(color: Colors.white70)),
              Text(patientData.milestoneDuration,
                  style: const TextStyle(color: Colors.white70)),
              const Icon(UniconsLine.user, color: Colors.white70),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ProgressBar(
            part: patientData.progress[0] / patientData.milestone[0],
            muscleGroup: "bicep"),
        const SizedBox(height: 10),
        ProgressBar(
            part: patientData.progress[1] / patientData.milestone[1],
            muscleGroup: "leg"),
        const SizedBox(height: 10),
        ProgressBar(
            part: patientData.progress[2] / patientData.milestone[2],
            muscleGroup: "quad"),
        const SizedBox(height: 10),
        ProgressBar(
            part: patientData.progress[3] / patientData.milestone[3],
            muscleGroup: "forearm"),
        ElevatedButton(
          onPressed: () {},
          style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Colors.deepPurpleAccent)),
          child: const Text("More details"),
        ),
        const SizedBox(height: 10)
      ]),
    );
  }
}
