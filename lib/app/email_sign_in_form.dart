import 'package:expense_tracker/services/auth.dart';
import 'package:expense_tracker/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  SignInFormType signInFormType = SignInFormType.signIn;
  bool _isLoading = false;

  String get _email => _emailTextController.value.text;
  String get _password => _passwordTextController.value.text;

  void _submit() async {
    setState(() => _isLoading = true);
    try {
      final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
      if (signInFormType == SignInFormType.register) {
        await auth.createAccountWithEmailAndPassword(_email, _password);
      } else {
        await auth.signInWithEmailAndPassword(_email, _password);
      }
      // Navigator.of(context).pop();
    } on SignInException {} finally {
      setState(() => _isLoading = false);
    }
  }

  void _toggleForm() async {
    setState(() {
      signInFormType = signInFormType == SignInFormType.register ? SignInFormType.signIn : SignInFormType.register;
    });
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String primaryText = signInFormType == SignInFormType.signIn ? 'Sign In With Account' : 'Register Account';
    final String secondaryText = signInFormType == SignInFormType.signIn ? 'Need an account? Register' : 'Have an account? Sign In';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            controller: _emailTextController,
            onChanged: (value) => {},
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'test@test.com',
              enabled: !_isLoading,
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            controller: _passwordTextController,
            decoration: InputDecoration(
              labelText: 'Password',
              enabled: !_isLoading,
            ),
          ),
          SizedBox(height: 20),
          CustomElevatedButton(
            child: Text(primaryText, style: TextStyle(fontSize: 20.0)),
            color: Theme.of(context).accentColor,
            outlineColor: Colors.white,
            textColor: Colors.white,
            onPressed: _isLoading ? null : _submit,
            borderRadius: 40,
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: _toggleForm,
            child: Text(
              secondaryText,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
