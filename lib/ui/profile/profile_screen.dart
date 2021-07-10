import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/controllers.dart';
import 'package:twitter_clone/routes/routes.dart';
import 'package:twitter_clone/ui/common/common.dart';
import 'package:twitter_clone/utils/utils.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.white,
          ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Consumer<UserController>(
            builder: (_, model, child) => model.isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        model.user?.email ?? '',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      AppButton(
                        label: 'Logout',
                        onPressed: () async {
                          var loggedout = await model.logout();
                          if (loggedout) {
                            context.showSnackBar('Logged out successfully');
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.auth,
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            context.showSnackBar('Something went wrong');
                          }
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
