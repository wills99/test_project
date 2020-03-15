import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/app/home/barber/shop_details.dart';
import 'package:test_project/app/home/models/barber.dart';
import 'package:test_project/common_widgets/form_submit_button.dart';
import 'package:test_project/services/database.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key key, @required this.database}) : super(key: key);

  final Database database;

// Pushes new route inside the navigation stack
  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PersonalDetails(database: database),
      ),
    );
  }

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  // var _textController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _firstName;
  String _lastName;
  int _contactNumber;
  String _shopName;
  String _addressLine1;
  String _addressLine2;
  String _city;
  String _country;
  String _postCode;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

// VALIDATE AND SAVES AND SUBMITS TO FIREBASE

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      final barber = BarberInfo(
        firstName: _firstName,
        lastName: _lastName,
        contactNumber: _contactNumber,
        shopName: _shopName,
        addressLine1: _addressLine1,
        addressLine2: _addressLine2,
        city: _city,
        country: _country,
        postCode: _postCode,
      );
      await widget.database.setBarber(barber);
      // TODO: navigate to next page

      print('form saved, first name: $_firstName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('personal details'),
      ),
      body: Column(
        children: <Widget>[
          _buildContents(),
          FormSubmitButton(
            text: 'Continue',
            onPressed: _submit,
            // onPressed: () {
            //   var route = new MaterialPageRoute(
            //       builder: (BuildContext context) =>
            //           ShopDetails(database: database, value: _textController.text));
            //   Navigator.of(context).push(route);
            // },
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'First Name'),
        // controller: _textController,
        initialValue: _firstName,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _firstName = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Last Name'),
        initialValue: _lastName,
        onSaved: (value) => _lastName = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Contact Number'),
        initialValue: '$_contactNumber',
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _contactNumber = int.parse(value),
      ),
    ];
  }
}
