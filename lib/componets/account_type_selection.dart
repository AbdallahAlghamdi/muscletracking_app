import 'package:flutter/material.dart';

class AccountTypeSelection extends StatefulWidget {
  final Function(int) changeToggle;
  final List<bool> selectedOption;
  const AccountTypeSelection(
      {super.key, required this.changeToggle, required this.selectedOption});

  @override
  State<AccountTypeSelection> createState() => AccountTypeSelectionState();
}

class AccountTypeSelectionState extends State<AccountTypeSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.deepPurple,
      ),
      child: ToggleButtons(
        borderWidth: 4,
        borderRadius: BorderRadius.circular(6),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        fillColor: Colors.white,
        isSelected: widget.selectedOption,
        onPressed: widget.changeToggle,
        children: [
          Image.asset(
            'lib/icons/icon_patient.png',
            width: 40,
          ),
          Image.asset(
            'lib/icons/icon_doctor.png',
            width: 40,
          ),
        ],
      ),
    );
  }
}
