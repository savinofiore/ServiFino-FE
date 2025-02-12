import 'package:flutter/material.dart';

class AddReservationField extends StatefulWidget {
  final Function(DateTime?, String?) updateSelected;

  const AddReservationField({Key? key, required this.updateSelected})
      : super(key: key);

  @override
  _AddReservationFieldState createState() => _AddReservationFieldState();
}

class _AddReservationFieldState extends State<AddReservationField> {
  DateTime? _selectedDateTime;
  String? _message;
  bool _isLoading = false;

  get selectedDateTime => _selectedDateTime;
  get message => _message;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

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

        widget.updateSelected(_selectedDateTime, _message);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              TextFormField(
                controller: _controller,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Seleziona data e ora",
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                onTap: _pickDateTime,
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Inserisci informazioni',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _message = value;
                    widget.updateSelected(_selectedDateTime, _message);
                  });
                },
              )
            ],
          )
        : const CircularProgressIndicator();
  }
}
