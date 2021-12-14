import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: addexpense(),
  ));
}
class addexpense extends StatefulWidget {
  @override
  _addexpenseState createState() => _addexpenseState();
}

class _addexpenseState extends State<addexpense> {
  var selection;
  String selectcat;
  DateTime selectedDate = DateTime.now();
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Body(),
    );
  }

  Widget Body() {
    String _formatDate=new DateFormat.yMMMd().format(selectedDate);
    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 200.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 185,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
              ),
            ),
          ),
          SizedBox(height: 100),
          Column(
            children: [
              // ignore: deprecated_member_use
              SizedBox(height: 230),
              Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // ignore: deprecated_member_use
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back,
                                    color: Colors.black)),
                            SizedBox(width: 30),
                            Text(
                              "Add Expense",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: ("Monserrat"),
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Expense Name"),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Expense Amount"),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value.isEmpty ||
                                !RegExp(r"0-9").hasMatch(value)) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: DropdownButton(
                          value: selection,
                          hint: Text(
                            "Choose Budget Name",
                            style: TextStyle(
                              fontFamily: ('Monserrat'),
                            ),
                          ),
                          iconSize: 50,
                          dropdownColor: Colors.grey[300],
                          iconDisabledColor: Colors.grey[300],
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: ('Monserrat'),
                            fontSize: 10.0,
                          ),
                          items: listItems.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selection = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: DropdownButton(
                          value: selectcat,
                          hint: Text(
                            "Choose Category",
                            style: TextStyle(
                              fontFamily: ('Monserrat'),
                            ),
                          ),
                          iconSize: 50,
                          dropdownColor: Colors.grey[300],
                          iconDisabledColor: Colors.grey[300],
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: ('Monserrat'),
                            fontSize: 10.0,
                          ),
                          items: category.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectcat = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Text('$_formatDate'),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Choose Date'),
                      ),
                      SizedBox(height: 30),
                      // ignore: deprecated_member_use
                      RaisedButton(
                          onPressed: () => _submit(), child: Text("Submit")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<int> listItems = new List<int>.generate(5, (i) => i + 1);
List<String> category = ["shopping", "dinner", "Health"];
