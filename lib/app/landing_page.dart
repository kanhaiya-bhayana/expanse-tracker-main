import 'package:expense_tracker/Dashboard.dart';
import 'package:expense_tracker/app/first_time_page.dart';
import 'package:expense_tracker/app/sign_in_page.dart';
import 'package:expense_tracker/models/user_data.dart';
import 'package:expense_tracker/services/auth.dart';
import 'package:expense_tracker/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    var authStateChanges = auth.authStateChanges;
    return StreamBuilder<User?>(
      stream: authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null)
            return SignInPage();
          else
            return _buildDashboard(user);
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Some error ocurred !!")),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildDashboard(User user) => Provider<Database>(
        create: (_) => FirestoreDatabase(uid: user.uid),
        child: Builder(builder: (context) {
          final Database database = Provider.of<Database>(context);
          return StreamBuilder<UserData>(
              stream: database.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Dashboard();
                  }
                  return FirstTimePage(user: user);
                } else {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
              });
        }),
      );
}
