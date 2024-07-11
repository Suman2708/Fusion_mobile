import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UpdateActivityCalendarPage extends StatefulWidget {
  @override
  _UpdateActivityCalendarPageState createState() =>
      _UpdateActivityCalendarPageState();
}

class _UpdateActivityCalendarPageState
    extends State<UpdateActivityCalendarPage> {
  String _selectedClub = 'Club 1';
  String _filePath = 'No file chosen';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'png'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path!;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform submission logic here
      print('Selected Club: $_selectedClub');
      print('File Path: $_filePath');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Activity Calendar',
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.deepOrangeAccent),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Club:',
                style: TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
              ),
              DropdownButton<String>(
                value: _selectedClub,
                items: <String>['Club 1', 'Club 2', 'Club 3', 'Club 4']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedClub = newValue!;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Activity Calendar',
                    style: TextStyle(
                        color: Color.fromARGB(255, 8, 8, 8), fontSize: 20.0),
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton.icon(
                    onPressed: _openFileExplorer,
                    icon: Icon(Icons.attach_file),
                    label: Text('Choose File'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                '$_filePath',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UpdateActivityCalendarPage(),
    theme: ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.orange,
    ),
  ));
}

