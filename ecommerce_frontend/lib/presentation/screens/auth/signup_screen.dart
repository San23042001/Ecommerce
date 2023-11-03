import 'package:ecommerce_frontend/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce_frontend/presentation/screens/auth/providers/signup_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/ui.dart';
import '../../widgets/gap_widget.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = "signup";

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("Ecommerce App"),
      ),
      body: SafeArea(
          child: Form(
        key: provider.formkey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              "Create Account",
              style: TextStyles.heading2,
            ),
            const GapWidget(size: -10),
            const GapWidget(),
            (provider.error != "")
                ? Text(
                    provider.error,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            const GapWidget(size: 5),
            PrimaryTextField(
                labelText: "Email Address",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email address is required!";
                  }
                  if (!EmailValidator.validate(value.trim())) {
                    return "Invalid email address";
                  }
                  return null;
                },
                controller: provider.emailController),
            const GapWidget(),
            PrimaryTextField(
                labelText: "Password",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password is required!";
                  }
                  return null;
                },
                obscureText: true,
                controller: provider.passwordController),
            const GapWidget(),
            PrimaryTextField(
                labelText: "Confirm Password",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Confirm your password!";
                  }

                  if (value.trim() != provider.passwordController.text.trim()) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                obscureText: true,
                controller: provider.cPasswordController),
            const GapWidget(),
            PrimaryButton(
                onPressed: provider.createAccount,
                text: (provider.isLoading) ? "..." : "Create Account"),
            const GapWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const GapWidget(),
                LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    text: "Log In")
              ],
            )
          ],
        ),
      )),
    );
  }
}
