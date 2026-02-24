import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/features/welcome/wlecome.dart';
import '../../main.dart';
import '../../savices/preferenes_manger.dart';
import '../../theme/theme_controller.dart';
import 'User_Details.dart';

class ProfileScrren extends StatefulWidget {
  const ProfileScrren({super.key});

  @override
  State<ProfileScrren> createState() => _ProfileScrrenState();
}

class _ProfileScrrenState extends State<ProfileScrren> {
  late String userName;
  late String motivationQuote;
  String? userImage;

  @override
  void initState() {
    super.initState();
    _loaduserName();
  }

  Future<void> _loaduserName() async {
    setState(() {
      userName = PreferenesManger().getString('userName');
      if (userName.isEmpty) userName = "User";
      
      motivationQuote = PreferenesManger().getString('Motivation Quote');
      if (motivationQuote.isEmpty) motivationQuote = "One task at a time. One step closer.";
      
      String savedImage = PreferenesManger().getString('user_image');
      userImage = savedImage.isEmpty ? null : savedImage;
    });
  }

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('Motivation Quote');
    await prefs.remove('tasks');
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "My Profile",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      // التصحيح: الـ Key يأخذ قيمة النص مباشرة
                      key: ValueKey(userImage),
                      radius: 60,
                      backgroundImage: userImage == null
                          ? const AssetImage("assets/ezz.jpg") as ImageProvider
                          : FileImage(File(userImage!)),
                      backgroundColor: Colors.transparent,
                    ),
                    GestureDetector(
                      onTap: () async {
                        showImageSourceDialog(context, (XFile image) {
                          _savaImage(image);
                          setState(() {
                            userImage = image.path;
                          });
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ThemeController.themeNotifier.value == ThemeMode.dark
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: const Color(0xFF181818),
                            width: 3,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: ThemeController.themeNotifier.value == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(userName, style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 2),
                Text(
                  motivationQuote,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Profile Info",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserDetails()),
              ).then((value) => _loaduserName());
            },
            leading: SvgPicture.asset(
              'assets/user-03.svg',
              colorFilter: ColorFilter.mode(
                ThemeController.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            title: Text(
              "User Details",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: SvgPicture.asset(
              'assets/Trailing element.svg',
              colorFilter: ColorFilter.mode(
                ThemeController.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
          const Divider(thickness: 1),
          ListTile(
            leading: SvgPicture.asset(
              'assets/Dark Mode.svg',
              colorFilter: ColorFilter.mode(
                ThemeController.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            title: Text(
              "Dark Mode",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: ValueListenableBuilder(
              valueListenable: ThemeController.themeNotifier,
              builder: (BuildContext context, value, Widget? child) {
                return Switch(
                  value: ThemeController.themeNotifier.value == ThemeMode.dark,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF2AD67B),
                  onChanged: (bool value) async {
                    ThemeController.toggleTheme();
                  },
                );
              },
            ),
          ),
          const Divider(thickness: 1),
          ListTile(
            onTap: () => _logout(),
            leading: SvgPicture.asset(
              'assets/LogOut.svg',
              colorFilter: ColorFilter.mode(
                ThemeController.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            title: Text(
              "Log Out",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: SvgPicture.asset(
              'assets/Trailing element.svg',
              colorFilter: ColorFilter.mode(
                ThemeController.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _savaImage(XFile image) async {
    PreferenesManger().setString('user_image', image.path);
  }
}

void showImageSourceDialog(BuildContext context, Function(XFile) selectedImage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          "Choose Image Source",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
              if (image != null) {
                selectedImage(image);
              }
            },
            child: const Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text("Camera"),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                selectedImage(image);
              }
            },
            child: const Row(
              children: [
                Icon(Icons.photo_library_outlined),
                SizedBox(width: 8),
                Text("Gallery"),
              ],
            ),
          ),
        ],
      );
    },
  );
}
