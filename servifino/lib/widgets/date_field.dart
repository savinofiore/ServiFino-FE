import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class DateField extends StatefulWidget {
  final Function(DateTime?) onDateTimeSelected;

  const DateField({Key? key, required this.onDateTimeSelected})
      : super(key: key);

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime? _selectedDateTime;
  bool _isLoading = false;

  get selectedDateTime => _selectedDateTime;

  final TextEditingController _controller = TextEditingController();

  Future<void> _pickDateTime() async {
    setState(() {
      _isLoading = true;
    });
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _controller.text =
              "${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year} ${_selectedDateTime!.hour}:${_selectedDateTime!.minute}";
        });

        widget.onDateTimeSelected(_selectedDateTime);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? TextFormField(
            controller: _controller,
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Seleziona data e ora",
              suffixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
            onTap: _pickDateTime,
          )
        : CircularProgressIndicator();
  }
}
