import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: VotingPolls(),
  ));
}

class VotingPolls extends StatefulWidget {
  @override
  _VotingPollsState createState() => _VotingPollsState();
}

class _VotingPollsState extends State<VotingPolls> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    CreatePolls(),
    ActivePolls(),
    PollStatus(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voting Polls', style: TextStyle(color: Colors.deepOrangeAccent)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.deepOrangeAccent),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Polls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Active Polls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll),
            label: 'Poll Status',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange.shade900,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CreatePolls extends StatefulWidget {
  @override
  _CreatePollsState createState() => _CreatePollsState();
}

class _CreatePollsState extends State<CreatePolls> {
  List<String> choices = [''];
  DateTime? _selectedDate;
  String? _selectedForwardTo;

  void addChoice() {
    setState(() {
      choices.add('');
    });
  }

  void deleteChoice() {
    setState(() {
      if (choices.length > 1) {
        choices.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Title',
            labelStyle: TextStyle(color: Colors.orange.shade900),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange.shade900),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Description',
            labelStyle: TextStyle(color: Colors.orange.shade900),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange.shade900),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          maxLines: null,
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: _selectedForwardTo,
          decoration: InputDecoration(
            labelText: 'Forward To',
            labelStyle: TextStyle(color: Colors.orange.shade900),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange.shade900),
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: <String>[
            '2017 Batch',
            '2018 Batch',
            '2019 Batch',
            '2017 CSE Batch',
            '2017 ME Batch',
            '2017 ECE Batch',
            '2017 Design Batch',
            '2018 CSE Batch',
            '2018 ME Batch',
            '2018 ECE Batch',
            '2018 Design Batch',
            '2019 CSE Batch',
            '2019 ME Batch',
            '2019 ECE Batch',
            '2019 Design Batch'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedForwardTo = value;
            });
          },
        ),
        SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Expiry Date',
            labelStyle: TextStyle(color: Colors.orange.shade900),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange.shade900),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          style: TextStyle(color: Colors.black),
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          readOnly: true,
          controller: TextEditingController(
            text: _selectedDate != null
                ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                : '',
          ),
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choices',
              style: TextStyle(color: Colors.orange.shade900),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: choices.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Choice ${index + 1}',
                          hintStyle: TextStyle(color: Colors.orange.shade900),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange.shade900),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        if (choices.length > 1) {
                          deleteChoice();
                        }
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  addChoice();
                },
                child: Text('Add Choice', style: TextStyle(color: Colors.orange.shade900)),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Submit poll
          },
          child: Text('Submit', style: TextStyle(color: Colors.black),),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange.shade900,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class ActivePolls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Active Polls'),
    );
  }
}

class PollStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Poll Status'),
    );
  }
}



