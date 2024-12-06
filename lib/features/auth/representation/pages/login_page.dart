import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/representation/components/events_jo_logo_auth.dart';
import 'package:events_jo/features/auth/representation/components/auth_button.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//* This page allows an existing user to login to EventsJo
class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  void login() {
    //prepare email & pw
    final String email = emailController.text;
    final String pw = pwController.text;

    //auth cubit
    final AuthCubit authCubit = context.read<AuthCubit>();

    //ensure that email & pw not empty
    if (email.isNotEmpty && pw.isNotEmpty) {
      authCubit.login(email, pw);
    } else {
      GSnackBar.show(
          context: context, text: 'Please enter both email and password');
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    pwController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            shrinkWrap: true,
            children: [
              // logo
              const Center(child: EventsJoLogoAuth()),

              const SizedBox(height: 10),

              //welcome back message
              Text(
                "Login to EventsJo",
                style: TextStyle(
                  color: GColors.black,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 10),

              //email textField
              AuthTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),

              const SizedBox(height: 10),

              //pw textField
              AuthTextField(
                controller: pwController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(height: 25),

              //login button
              AuthButton(
                onTap: login,
                text: 'Login',
                icon: Icons.arrow_forward_ios,
              ),

              const SizedBox(height: 50),

              //not a member ? register now
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ?',
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: 17,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      ' Register now!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: GColors.royalBlue,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
