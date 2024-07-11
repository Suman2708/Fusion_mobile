import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class EditRequestFormB extends StatefulWidget {
   final String oldVenue;
  final List<String> venueOptions;
  final DateTime selectedDate;
  final String inCharge;
  final String event;

  EditRequestFormB({
    required this.oldVenue,
    required this.venueOptions,
    required this.selectedDate,
    required this.inCharge,
    required this.event,
  });

  @override
  _EditRequestFormBState createState() => _EditRequestFormBState();
}

class _EditRequestFormBState extends State<EditRequestFormB> {
  late String _selectedVenue;
  late DateTime _selectedDate;
  // late TimeOfDay _selectedStartTime;
  late String _inCharge;
  late String _posterPath;
  late String _event;

  @override
  void initState() {
    super.initState();
    _selectedVenue = widget.oldVenue;
    _selectedDate = widget.selectedDate;
    // _selectedStartTime = widget.oldStartTime;
    _inCharge = '';
    _posterPath = '';
    _event = '';
  }

  String _fileName = '';
  bool _fileChosen = false;

  Future<void> _selectPoster() async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'png'],
    );

    if (resultFile != null) {
      setState(() {
        // _filePath = result.files.single.path!;
        _fileChosen = true;
        PlatformFile file = resultFile.files.first;
        _fileChosen = true;
        _fileName = file.name;
        print(_fileName);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

Future<void> _EventTime(BuildContext context) async {
  final String? picked = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Select Event Time'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'Morning'); // Example value for morning
            },
            child: Text('Morning'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'Afternoon'); // Example value for afternoon
            },
            child: Text('Afternoon'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'Evening'); // Example value for evening
            },
            child: Text('Evening'),
          ),
        ],
      );
    },
  );

  if (picked != null && picked != _event) {
    setState(() {
      _event = picked;
    });
  }
}



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Request',
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.deepOrangeAccent),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrangeAccent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Venue',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      value: _selectedVenue,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedVenue = newValue!;
                        });
                      },
                      items: widget.venueOptions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrangeAccent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Select Date'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
  children: [
    Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrangeAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              // controller: _eventController, // Add a controller for the text field
              decoration: InputDecoration(
                hintText: 'Enter Event', // Placeholder text
                border: OutlineInputBorder(), // Add border
              ),
            ),
          ],
        ),
      ),
    ),
    SizedBox(width: 20),
    Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrangeAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'In Charge',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              // controller: _inChargeController, // Add a controller for the text field
              decoration: InputDecoration(
                hintText: 'Enter In Charge', // Placeholder text
                border: OutlineInputBorder(), // Add border
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectPoster,
                child: Text('Select Poster (if any)'),
              ),
              Text(_fileName.isEmpty
                  ? 'No file selected'
                  : _fileName),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrangeAccent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _event = value;
                    });
                  },
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Details and Description',
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    // Add logic to submit the form data
    // You can access the selected values using _selectedVenue, _selectedDate, etc.
  }
}
