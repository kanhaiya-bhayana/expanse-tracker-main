import 'package:expense_tracker/services/auth.dart';
import 'package:expense_tracker/widgets/custom_outline_social_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'email_sign_in_form.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  void _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInWithGoogle();
    } on SignInException {} finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF6EBF3), Color(0xFFFFFFFF)],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                    child: SvgPicture.asset(
                      'images/undraw_Savings_re_eq4w.svg',
                      height: 300,
                    ),
                    height: 220,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        EmailSignInForm(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 1.0,
                              color: Colors.black,
                            ),
                            Text(' OR ',
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              width: 150,
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: CustomOutLineSocialButton(
                            assetName: "images/google-logo.png",
                            text: "Sign In With Google",
                            onPressed: _isLoading ? null : _signInWithGoogle,
                            outlineColor: Theme.of(context).accentColor,
                            textColor: Theme.of(context).accentColor,
                          ),
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
