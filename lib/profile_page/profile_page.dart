import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/profile/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../profile-wodget/options.dart';
import 'package:myapp/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
  String? email;
  String? birth;
  String? age;

  @override
  void initState() {
    super.initState();
    loadSignupData();
  }

  Future<void> loadSignupData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'No name';
      email = prefs.getString('email') ?? 'No email';
      birth = prefs.getString('birthdate') ?? 'No birthdate';
      age = prefs.getString('age') ?? 'No age';
    });
  }

  Future<void> updateField(String key, String currentValue) async {
    final controller = TextEditingController(text: currentValue);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit $key"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Enter new $key"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(key, controller.text);
              Navigator.pop(context);
              loadSignupData(); // Refresh data
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  Widget buildEditableTile(
      String title, String? value, IconData icon, String key) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value ?? ''),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => updateField(key, value ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Consumer<userModel>(
        builder: (context, model, child) {
          final user = model.user;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 100,
                      child: user?.image == null
                          ? const Icon(Icons.person,
                              size: 100, color: Colors.white)
                          : ClipOval(
                              child: Image.memory(
                                user!.image!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      radius: 25,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt,
                            size: 25, color: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                                top: 20,
                                left: 20,
                                right: 20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Profile Image",
                                      style: TextStyle(fontSize: 20)),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Options(
                                        title: "Camera",
                                        icon: Icons.camera_alt,
                                        color: Colors.green,
                                        onPressesd: () {
                                          model.imageSelector(
                                              ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Options(
                                        title: "Gallery",
                                        icon: Icons.image,
                                        color: Colors.green,
                                        onPressesd: () {
                                          model.imageSelector(
                                              ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Options(
                                        title: "Delete",
                                        icon: Icons.delete,
                                        color: Colors.red,
                                        onPressesd: () {
                                          model.removeImage();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                buildEditableTile("Name", name, Icons.person, 'name'),
                buildEditableTile("Email", email, Icons.email, 'email'),
                buildEditableTile("Birthdate", birth, Icons.cake, 'birthdate'),
                buildEditableTile("Age", age, Icons.numbers, 'age'),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
