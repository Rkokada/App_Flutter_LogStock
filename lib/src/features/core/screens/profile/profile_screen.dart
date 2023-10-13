import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logstock/src/constants/text_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tProfile,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}
