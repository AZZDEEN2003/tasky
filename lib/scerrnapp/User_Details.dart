import 'package:flutter/material.dart';
import 'package:newprojectflutter/Widgte/Custem_screen.dart';
import '../savices/preferenes_manger.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController MotivationQuoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    MotivationQuoteController.dispose();
    super.dispose();
  }

  void _loadUserData() async {
    await PreferenesManger().init();
    setState(() {
      nameController.text = PreferenesManger().getString('userName') ?? "";
      MotivationQuoteController.text = PreferenesManger().getString('Motivation Quote') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "User Details",
        ),
        elevation: 0,
        iconTheme:  IconThemeData(),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // الجزء العلوي: الحقول قابلة للتمرير
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustemScreen(
                          TextTitle: 'User Name',
                          Controller: nameController,
                          maxLines: 1,
                          hint: PreferenesManger().getString('userName')!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustemScreen(
                          TextTitle: 'Motivation Quote',
                          Controller: MotivationQuoteController,
                          maxLines: 5,
                          hint: PreferenesManger().getString('Motivation Quote')!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Motivation Quote';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // الجزء السفلي: الزر ثابت في مكانه
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool savedName = await PreferenesManger().setString('userName', nameController.text);
                        bool savedQuote = await PreferenesManger().setString('Motivation Quote', MotivationQuoteController.text);

                        if (savedName && savedQuote && context.mounted) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2AD67B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
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
