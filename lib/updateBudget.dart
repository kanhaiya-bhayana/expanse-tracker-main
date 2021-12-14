import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UpdateBudget extends StatefulWidget {
  UpdateBudget();

  @override
  _UpdateBudgetState createState() => _UpdateBudgetState();
}

class _UpdateBudgetState extends State<UpdateBudget> {
  TextEditingController _bnameController = TextEditingController();
  TextEditingController _bamountController = TextEditingController();
  // TextEditingController _controller = new TextEditingController();
  // _controller.text = 'Initial value';
  final _formkey = GlobalKey<FormState>();
  bool readOnly = true;
  var _check_d1 = 0;
  var _check_d2 = 0;

  void _saveForm() {
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      return;
    }
  }

  var sdt;
  var edt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F5F6F0"),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 5.0),

          SizedBox(height: 60.0), // this is height of appbar blue section...
          Container(
            height: MediaQuery.of(context).size.height - 30.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      75.0)), // this is the value of curve line...
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(
                  left: 30.0,
                  right: 25.0), // pading for whole section inside white..
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Update',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0)),
                      SizedBox(width: 10.0),
                      Text('Budget',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontSize: 18.0)),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(height: 22),
                Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300.0,
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              // ListTile(
                              //   title: Text('Clothes'),
                              //   trailing: IconButton(
                              //       icon: Icon(Icons.edit_attributes),
                              //       onPressed: () {
                              //         setState(() {
                              //           ListTile(
                              //             leading: TextFormField(
                              //               controller: _bamountController,
                              //               keyboardType: TextInputType.number,
                              //               maxLength: 20,
                              //               validator: (value) {
                              //                 if (value == null ||
                              //                     value.isEmpty) {
                              //                   return 'Please enter budget';
                              //                 }
                              //                 return null;
                              //               },
                              //               decoration: InputDecoration(
                              //                 enabledBorder: OutlineInputBorder(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(10))),
                              //                 labelText: "Enter Budget",
                              //               ),
                              //             ),
                              //           );
                              //         });
                              //       }),
                              // ),
                              // TextFormField(
                              //   initialValue: "Kanhaiya",
                              //   readOnly: true,

                              // ),
                              TextFormField(
                                maxLength: 30,
                                decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    icon: Icon(Icons.update_outlined),
                                    onPressed: () {
                                      readOnly = false;
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: "Enter Name",
                                ),
                                initialValue: "Clothes",
                              ),
                              SizedBox(height: 22),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                maxLength: 20,
                                decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    icon: Icon(Icons.update_outlined),
                                    onPressed: () {
                                      readOnly = false;
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: "Enter Budget",
                                ),
                                initialValue: '20,0000',
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(Icons.date_range),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1990),
                                        lastDate: DateTime(2024))
                                    .then(
                                  (date) {
                                    setState(() {
                                      var formattedDate =
                                          "${date!.day}-${date.month}-${date.year}";
                                      sdt = formattedDate;
                                    });
                                  },
                                );
                                _check_d1 = 1;
                              },
                            ),
                            title: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(right: 12.0),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        sdt == null ? '15-06-2021' : sdt,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      subtitle: Text(
                                        'Start Date',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            dense: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(Icons.date_range),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1990),
                                        lastDate: DateTime(2024))
                                    .then(
                                  (date) {
                                    setState(() {
                                      var formattedDate =
                                          "${date!.day}-${date.month}-${date.year}";
                                      edt = formattedDate;
                                    });
                                  },
                                );
                                _check_d2 = 1;
                              },
                            ),
                            title: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(right: 12.0),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        edt == null ? '01-12-2022' : edt,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      subtitle: Text(
                                        'End Date',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            dense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Icon(Icons.update),
                        onPressed: () {
                          _saveForm();
                          if (_check_d1 == 1 && _check_d2 == 1) {
                            setState(() {
                              _welcome();
                            });
                          }
                        }),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

void _welcome() {
  print("Weocmone");
}

intialValue(val) {
  return TextEditingController(text: val);
}
