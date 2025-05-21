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
  //cubit
  late final AuthCubit authCubit;

  //fields
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //todo remove later
    emailController.text = 'test1@gmail.com';
    pwController.text = '123456';

    //get cubit
    authCubit = context.read<AuthCubit>();
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
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView(
              shrinkWrap: true,
              children: [
                // logo
                const Center(child: EventsJoLogoAuth()),

                const SizedBox(height: 10),

                //login message
                GestureDetector(
                  onTap: () {
                    emailController.text = 'yahya@gmail.com';
                    pwController.text = '123456';
                    setState(() {});
                  },
                  child: Text(
                    "Login to EventsJo",
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: 22,
                    ),
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
                  onTap: () => authCubit.login(
                    context,
                    email: emailController.text.trim(),
                    pw: pwController.text,
                  ),
                  text: 'Login',
                  icon: Icons.arrow_forward_ios,
                ),

                const SizedBox(height: 50),

                //go to register page
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
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
