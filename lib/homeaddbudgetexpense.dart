import 'package:flutter/material.dart';

class HomeAddBudgetExpense extends StatefulWidget {
  HomeAddBudgetExpense();

  @override
  _HomeAddBudgetExpenseState createState() => _HomeAddBudgetExpenseState();
}

class _HomeAddBudgetExpenseState extends State<HomeAddBudgetExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1428),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {},
                ),
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.filter_list),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Expense',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
                Text('Tracker',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25.0))
              ],
            ),
          ),

          SizedBox(height: 75.0), // this is height of appbar blue section...
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      75.0)), // this is the value of curve line...
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(
                  left: 25.0,
                  right: 20.0), // pading for whole section inside white..
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 50.0), // pading from top ....
                    child: Container(
                        height: MediaQuery.of(context).size.height - 300.0,
                        child: ListView(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/dummy.png'),
                                    height: 200,
                                    width: 300,
                                  ),
                                ),
                              )),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 165.0,
                                  width: 122.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xFF1C1428),
                                  ),
                                  child: Center(
                                      child: ListView(children: [
                                    FlatButton(
                                      onPressed: () => {},
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text('\n\n\n\n\n\nAdd Budget',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: 15.0)),
                                        ],
                                      ),
                                    ),
                                  ])),
                                ),
                                Container(
                                  height: 165.0,
                                  width: 122.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xFF1C1428),
                                  ),
                                  child: Center(
                                      child: ListView(children: [
                                    FlatButton(
                                      onPressed: () => {},
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text('\n\n\n\n\n\nAdd Expense',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: 15.0)),
                                        ],
                                      ),
                                    ),
                                  ])),
                                ),
                              ])
                        ]))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
