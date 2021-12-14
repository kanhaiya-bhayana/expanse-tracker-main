import 'package:expense_tracker/models/user_data.dart';
import 'package:expense_tracker/services/auth.dart';
import 'package:expense_tracker/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FirstTimePage extends StatefulWidget {
  FirstTimePage({required this.user});
  final User user;
  @override
  _FirstTimePageState createState() => _FirstTimePageState();
}

class _FirstTimePageState extends State<FirstTimePage> {
  bool _isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  String get _name => _nameController.text;
  final _formKey = GlobalKey<FormState>();

  int _currencyIndex = 0;
  List<String> _currencyText = ['₹ Rupee', '\$ Dollar', '€ Euro', '£ Pound', '¥ Yuan', '¥ Yen'];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.displayName ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> setUserData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final Database database = Provider.of<Database>(context, listen: false);
      try {
        await database.setUserData(userData: UserData(name: _name, email: (widget.user.email as String), currency: _currencyText[_currencyIndex]));
      } catch (_) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<bool> _signOut() async {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    setState(() => _isLoading = true);
    await auth.signOut();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _signOut,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: _buildForm(),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _isLoading ? null : setUserData,
          child: Icon(Icons.navigate_next),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_outlined,
          color: Colors.black,
        ),
        onPressed: _signOut,
      ),
      shadowColor: Colors.transparent,
    );
  }

  List<Widget> _buildForm() {
    return [
      Text(
        'Welcome !',
        style: GoogleFonts.pacifico(fontSize: 50.0),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          'Please provide details to continue into the application. These details will be used to provide personalised experience.',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 18.0,
          ),
          maxLines: 4,
        ),
      ),
      SizedBox(height: 20),
      Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _roundedPic()),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    widget.user.email ?? '',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16.0),
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                autocorrect: false,
                controller: _nameController,
                onChanged: (value) => {},
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Harshad Mehta',
                  enabled: !_isLoading,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Choose currency'),
              ),
              Wrap(children: _radioGroup()),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _radioGroup() {
    List<Widget> _return = [];
    for (int i = 0; i < _currencyText.length; i++) {
      _return.add(_radioButton(i));
    }
    return _return;
  }

  Widget _radioButton(int index) {
    bool _isSelected = _currencyIndex == index;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 40,
          maxHeight: 50,
        ),
        child: TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              backgroundColor: Colors.blueAccent[100]?.withOpacity(0.1),
              primary: _isSelected ? Colors.blue[900] : Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  side: BorderSide(
                    color: _isSelected ? Colors.blue[900] ?? Colors.blue : Colors.grey,
                  ))),
          child: Text(_currencyText[index]),
          onPressed: _isLoading
              ? null
              : () => setState(() {
                    _currencyIndex = index;
                  }),
        ),
      ),
    );
  }

  CircleAvatar _roundedPic() {
    String text = '😄';
    if (_name != '') {
      text = _name[0];
    }
    String _url = widget.user.photoURL ?? '';
    return CircleAvatar(
      maxRadius: 60,
      minRadius: 40,
      foregroundImage: _url != '' ? NetworkImage(_url) : null,
      backgroundColor: Theme.of(context).primaryColor,
      child: Text(
        text,
        style: TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
  }
}
