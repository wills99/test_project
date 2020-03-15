import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/app/home/jobs/jobs_page.dart';
import 'package:test_project/app/sign_in/sign_in_page.dart';
import 'package:test_project/services/auth.dart';
import 'package:test_project/services/database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      // initialData: used for what should be there

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: JobsPage());
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
