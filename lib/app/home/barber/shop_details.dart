import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/app/home/models/barber.dart';
import 'package:test_project/common_widgets/form_submit_button.dart';
import 'package:test_project/services/database.dart';

class ShopDetails extends StatefulWidget {
  const ShopDetails({Key key, @required this.database}) : super(key: key);
  final Database database;

// Pushes new route inside the navigation stack
  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShopDetails(database: database),
      ),
    );
  }

  // ShopDetails({Key key}) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<ShopDetails> {
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
      // Navigator.of(context).pop();
    }

    // SUBMIT TO FIRESTORE
    // final database = Provider.of<Database>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Details'),
      ),
      body: Column(
        children: <Widget>[
          _buildContents(),
          FormSubmitButton(
            text: 'Continue',
            onPressed: _submit,
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
        decoration: InputDecoration(labelText: 'Shop Name'),
        initialValue: _shopName,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _shopName = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Address Line 1'),
        initialValue: _addressLine1,
        onSaved: (value) => _addressLine1 = value,
      ),
      TextFormField(
          decoration: InputDecoration(labelText: 'Address Line 2'),
          initialValue: _addressLine2,
          onSaved: (value) => _addressLine2 = value),
      TextFormField(
          decoration: InputDecoration(labelText: 'City'),
          initialValue: _city,
          onSaved: (value) => _city = value),
      TextFormField(
          decoration: InputDecoration(labelText: 'Country'),
          initialValue: _country,
          onSaved: (value) => _country = value),
      TextFormField(
          decoration: InputDecoration(labelText: 'Postcode'),
          initialValue: _postCode,
          onSaved: (value) => _postCode = value),
    ];
  }
}
