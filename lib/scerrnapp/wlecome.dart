import 'package:flutter/material.dart';
import 'package:newprojectflutter/Widgte/Custem_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:newprojectflutter/scerrnapp/main_scrren.dart';

import '../savices/preferenes_manger.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تعريف المفتاح للتحكم في الـ Form
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/Frame.png", width: 30, height: 30),
            const SizedBox(width: 8),
            Text("Tasky",
                style: Theme.of(context).textTheme.displayMedium,)
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            // تغليف الـ Column بـ Form هو الحل لتفعيل الـ validator
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    "Welcome To Tasky 👋 ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your productivity journey starts here.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 16 ,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Image.asset("assets/pana.png", width: 215, height: 204),
                  const SizedBox(height: 24),

                  /// Full Name Field
                  CustemScreen(
                    TextTitle: "Full Name",
                    Controller: nameController,
                    maxLines: 1,
                    hint: "e.g. Sarah Khalid",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  /// Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        // تفعيل فحص الحقول (validator)
                        if (_formKey.currentState!.validate()) {
                          String name = nameController.text.trim();
                          PreferenesManger().init();
                          await PreferenesManger().setString('userName', name);
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context, 
                              MaterialPageRoute(builder: (context) => const MainScrren())
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2AD67B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text("Let’s Get Started", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
