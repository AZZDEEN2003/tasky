import 'package:tasky/Widgte/Custem_screen.dart';
import 'package:flutter/material.dart';

import '../savices/preferenes_manger.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController QuoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      nameController.text = PreferenesManger().getString('userName');
      QuoteController.text = PreferenesManger().getString('Motivation Quote');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Details",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                const SizedBox(height: 16),
                CustemScreen(
                  TextTitle: "Motivation Quote",
                  Controller: QuoteController,
                  maxLines: 2,
                  hint: "One task at a time. One step closer.",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quote';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await PreferenesManger().setString('userName', nameController.text);
                        await PreferenesManger().setString('Motivation Quote', QuoteController.text);
                        if (context.mounted) Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2AD67B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Save Changes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
