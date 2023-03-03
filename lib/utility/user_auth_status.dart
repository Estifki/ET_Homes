import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/screen/auth.dart';

import '../screen/profile/profile.dart';
import '../services/auth/auth.dart';

class UserAuthStatus extends StatelessWidget {
  const UserAuthStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Provider.of<AuthProvider>(context).tokenStatus,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return const ProfileScreen();
          } else {
            return const AuthScreen();
          }
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Unknown error Occured!'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
