import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:expense_tracker/homeaddbudgetexpense.dart';
import 'package:expense_tracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: getBody(),
      bottomNavigationBar: getFooter(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setTabs(4);
        },
        child: Icon(Icons.add, size: 25),
        backgroundColor: Colors.blue[600],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getBody() {
    final AuthBase auth = Provider.of<AuthBase>(context);

    return IndexedStack(
      index: pageIndex,
      children: [
        Center(
          child: Home(),
          //child: Text("home"),
        ),
        Center(
          child: Text("download"),
        ),
        Center(
          child: Text("delete"),
        ),
        Center(
          child: TextButton(
            onPressed: auth.signOut,
            child: Text(
              "Sign Out",
            ),
          ),
        ),
        HomeAddBudgetExpense(),
      ],
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Icons.home,
      Icons.download_rounded,
      Icons.delete,
      Icons.settings

      // Ionicons.md_home,
      // Ionicons.md_download,
      // Ionicons.md_trash,
      // Ionicons.md_settings,
    ];
    return AnimatedBottomNavigationBar(
      activeColor: Colors.blue[600],
      splashColor: Colors.blue[600],
      inactiveColor: Colors.grey[400],
      icons: iconItems,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      activeIndex: pageIndex,
      onTap: (index) {
        setTabs(index);
      },
    );
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selection = null;
  String sort = "Recent";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29.5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome,",
                          style: TextStyle(
                            fontFamily: ('Monserrat'),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Here's your spending dashboard,",
                          style: TextStyle(
                            fontFamily: ('Monserrat'),
                            fontWeight: FontWeight.normal,
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 150,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[500] ?? Colors.grey,
                                offset: const Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ),
                            ]),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 110, 30, 10),
                              child: Text(
                                "What you've spent",
                                style: TextStyle(
                                  fontFamily: ('Monserrat'),
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: VerticalDivider(thickness: 1.5),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(35, 30, 15, 20),
                                  child: Container(
                                    child: DropdownButton(
                                      value: selection,
                                      iconSize: 50,
                                      dropdownColor: Colors.blue[200],
                                      iconDisabledColor: Colors.grey[200],
                                      iconEnabledColor: Colors.blue[600],
                                      style: TextStyle(
                                        color: Colors.blue[600],
                                        fontFamily: ('Monserrat'),
                                        fontSize: 10.0,
                                      ),
                                      items: listItems.map((e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: new Text(
                                            e.toString(),
                                            style: TextStyle(
                                              color: Colors.blue[600],
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
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 15, 0, 10),
                                  child: Text(
                                    "Last Days",
                                    style: TextStyle(
                                      fontFamily: ('Monserrat'),
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 180),
                        Text(
                          "Last Transactions",
                          style: TextStyle(
                            fontFamily: "Monserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 100),
                        Text(
                          "Sort By",
                          style: TextStyle(
                            fontFamily: "Monserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        DropdownButton(
                          value: sort,
                          icon: Icon(Icons.sort),
                          iconSize: 30,
                          dropdownColor:
                              Colors.grey[200]?.withOpacity(0.5) ?? Colors.grey,
                          iconDisabledColor: Colors.grey[200],
                          iconEnabledColor: Colors.blue[600],
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontFamily: ('Monserrat'),
                            fontSize: 10.0,
                          ),
                          items: SortItems.map((x) {
                            return DropdownMenuItem(
                              value: x,
                              child: new Text(
                                x,
                                style: TextStyle(
                                  color: Colors.blue[600],
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              // TODO: arbitrary fix ... value is Object?
                              sort = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<int> listItems = new List<int>.generate(31, (i) => i + 1);
List<String> SortItems = [
  "Recent",
  "Amount",
  "Date",
];
