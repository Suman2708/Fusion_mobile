import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ClubBudgetForm extends StatefulWidget {
  @override
  _ClubBudgetFormState createState() => _ClubBudgetFormState();
}

class _ClubBudgetFormState extends State<ClubBudgetForm> {
  String _club = '';
  String _budgetFor = '';
  double _budgetAmount = 0.0;
  String _attachment = '';
  String _detailsDescription = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club Budget Form',
            style: TextStyle(color: Colors.deepOrangeAccent)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.deepOrangeAccent),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Club',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter club name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _club = value ?? '';
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Budget For',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter budget for';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _budgetFor = value ?? '';
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Budget Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter budget amount';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _budgetAmount = double.tryParse(value) ?? 0.0;
                  });
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();

                  if (result != null) {
                    setState(() {
                      _attachment = result.files.single.name ?? '';
                    });
                  }
                },
                child: Text(
                  'Attachment',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrangeAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Details & Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter details & description';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _detailsDescription = value ?? '';
                  });
                },
                maxLines: null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Submit form logic goes here
                    // You can access form fields using _club, _budgetFor, _budgetAmount, _attachment, and _detailsDescription variables
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrangeAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
    title: 'Club Budget Form',
    theme: ThemeData(
      primaryColor: Colors.deepOrangeAccent,
      hintColor: Colors.deepOrangeAccent,
    ),
    home: ClubBudgetForm(),
  ));
}
