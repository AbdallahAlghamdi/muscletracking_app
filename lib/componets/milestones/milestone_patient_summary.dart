import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/progress_bar.dart';
import 'package:muscletracking_app/utils/patient_progress.dart';
import 'package:unicons/unicons.dart';

class MilestonePatientSummary extends StatelessWidget {
  final PatientProgress patientData;
  const MilestonePatientSummary({super.key, required this.patientData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
        ProgressBar(
          progress: patientData.progress[0],
          milestone: patientData.milestone[0],
          muscleGroup: "bicep",
        ),
        ProgressBar(
          progress: patientData.progress[1],
          milestone: patientData.milestone[1],
          muscleGroup: "calf",
        ),
        ProgressBar(
          progress: patientData.progress[2],
          milestone: patientData.milestone[2],
          muscleGroup: "thigh",
        ),
        ProgressBar(
          progress: patientData.progress[3],
          milestone: patientData.milestone[3],
          muscleGroup: "forearm",
        ),
        const SizedBox(height: 10),
      ]),
    );
  }
}
