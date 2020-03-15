import 'package:meta/meta.dart';

class BarberInfo {
  BarberInfo({
    // this.uid,
    @required this.firstName,
    @required this.lastName,
    @required this.contactNumber,
    @required this.shopName,
    @required this.addressLine1,
    @required this.addressLine2,
    @required this.city,
    @required this.country,
    @required this.postCode,
    // this.preferredName,
    // this.email,
    // this.photoUrl,
  });
  // final String uid;
  final String firstName;
  final String lastName;
  final int contactNumber;
  final String shopName;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String country;
  final String postCode;
  // final String preferredName;
  // final String email;
  // final String photoUrl;
  // final String addressLine3;

  factory BarberInfo.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String _firstName = data['_firstName'];
    final String _lastName = data['_lastName'];
    final int _contactNumber = data['_contactNumber'];
    final String _shopName = data['_shopName'];
    final String _addressLine1 = data['_addressLine1'];
    final String _addressLine2 = data['_addressLine2'];
    final String _city = data['_city'];
    final String _country = data['_country'];
    final String _postCode = data['_postCode'];

    return BarberInfo(
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
  }

  Map<String, dynamic> toMap() => {
        // 'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'contactNumber': contactNumber,
        'shopName': shopName,
        'shopAddress': [
          {
            'addressLine1': addressLine1,
            'addressLine2': addressLine2,
            'city': city,
            'country': country,
            'postcode': postCode,
          },
        ],
        //     'addressLine3': addressLine3,
        // 'preferredName': preferredName,
        // 'email': email,
        // 'photoUrl': photoUrl,
      };
}
