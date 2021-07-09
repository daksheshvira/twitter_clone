import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/controllers.dart';
import 'package:twitter_clone/data/images.dart';
import 'package:twitter_clone/routes/routes.dart';
import 'package:twitter_clone/ui/common/common.dart';

class AuthHomeScreen extends StatefulWidget {
  @override
  _AuthHomeScreenState createState() => _AuthHomeScreenState();
}

class _AuthHomeScreenState extends State<AuthHomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final ValueNotifier<bool> _isObscurePassword = ValueNotifier(true);
  late UserController _notifier;

  @override
  void initState() {
    super.initState();
    // _notifier = Provider.of<UserController>(context, listen: false);
    _notifier = context.read<UserController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 64,
              ),
              Image(
                image: AssetImage(Images.instance.logo),
                width: 150,
              ),
              SizedBox(
                height: 64,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        hintText: 'Email Address',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isObscurePassword,
                      builder: (_, val, __) => TextFormField(
                        controller: _passwordController,
                        obscureText: val,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          suffixIcon: InkWell(
                            onTap: () => _isObscurePassword.value = !val,
                            child: Icon(
                              val ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    AppButton(
                      label: 'Sign In',
                      onPressed: _signIn,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      var isEmailExists =
          await _notifier.checkIfUserExists(_emailController.text);
      if (isEmailExists) {
        var responser = await _notifier.signInUser(
          _emailController.text,
          _passwordController.text,
        );
        if (responser.isSuccess) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else {}
      } else {
        var responser = await _notifier.signUpUser(
          _emailController.text,
          _passwordController.text,
        );
        if (responser.isSuccess) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else {}
      }
    }
  }
}
