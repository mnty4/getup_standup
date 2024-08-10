import 'package:flutter/material.dart';
import 'package:day_picker/day_picker.dart';
/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add alarm'),
      ),
      body: const Center(
        child: AlarmForm()
      ),
    );
  }
}

class AlarmForm extends StatefulWidget {
  const AlarmForm({
    super.key,
  });

  @override
  State<AlarmForm> createState() => _AlarmFormState();
}

class _AlarmFormState extends State<AlarmForm> {
  bool? isChecked = true;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final List<DayInWeek> _days = [
    DayInWeek(
      "Mon", dayKey: '0',
    ),
    DayInWeek(
      "Tue", dayKey: '1',
    ),
    DayInWeek(
      "Wed", dayKey: '2',
    ),
    DayInWeek(
      "Thu", dayKey: '3',
    ),
    DayInWeek(
      "Fri", dayKey: '4',
    ),
    DayInWeek(
      "Sat", dayKey: '5',
    ),
      DayInWeek(
      "Sun", dayKey: '6',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Get up, stand up!',
                  labelText: 'Name',
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Checkbox(value: isChecked, onChanged: (bool? value) {
                    setState(() {
                      isChecked = value;
                    });
                  }),
                  const Text('Repeat')
                ]
              ),
              TextFormField(
                enabled: !isChecked!,
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: isChecked,
                      controller: _startTimeController,
                      decoration: const InputDecoration(
                        labelText: 'Start Time',
                        filled: true,
                        prefixIcon: Icon(Icons.alarm),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectStartTime();
                      },
                    ),
                  ),
                  const SizedBox(width: 10,),
                  const Text('-', style: TextStyle(fontSize: 32),),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: TextFormField(
                      enabled: isChecked,
                      controller: _endTimeController,
                      decoration: const InputDecoration(
                        labelText: 'End Time',
                        filled: true,
                        prefixIcon: Icon(Icons.alarm),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectEndTime();
                      },
                    ),
                  ),
                ],
              ),
              SelectWeekDays(onSelect: (values) {
                print(values);
              }, fontSize: 14,
            fontWeight: FontWeight.w500,
            days: _days,
            border: false,
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Color.fromRGBO(255, 2, 200, 1), Color.fromARGB(255, 118, 48, 211)],
                tileMode:
                TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),)

              // InputDatePickerFormField(firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)))

              // https://pub.dev/packages/time_picker_spinner
          ],
        ),
    );

    
  }
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

    if (picked != null) {
      _dateController.text = picked.toString().split(" ")[0];
    }
  }

  Future<void> _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 9, minute: 0));
    if (picked != null) {
      _startTimeController.text = _selectTime(picked);
    }
  }
  Future<void> _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 17, minute: 0));
    if (picked != null) {
      _endTimeController.text = _selectTime(picked);
    }
  }

  String _selectTime(TimeOfDay picked) {
    String minute = '${picked.minute < 10 ? '0' : ''}${picked.minute}';
    String amOrPm = picked.hour < 12 ? 'AM' : 'PM';

    int hour = picked.hour;
    if (picked.hour != 12 && picked.hour != 0) {
      hour = picked.hour % 12;
    } else {
      hour = 12;
    }
    
    return '$hour:$minute $amOrPm';
  }
  
}
