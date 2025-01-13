import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/providers/auth_user_provider.dart';
import 'package:health_buddy/providers/user_provider.dart';
import 'package:health_buddy/screens/authentication/check_loggedin.dart';

import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  void initState() {
    updateData();
    super.initState();
  }

  updateData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthUserProvider>(context);
    UserModel? userdata = Provider.of<UserProvider>(context).getuser;
    final userProvider = Provider.of<UserProvider>(context);

    if (userdata != null) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    userdata.userimage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userdata.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  userdata.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: subTxtColor,
                  ),
                ),
                Text(
                  userdata.phone,
                  style: const TextStyle(
                    fontSize: 16,
                    color: subTxtColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ProfileTiles(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Change Name?"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Type your desired new name"),
                            TextField(
                              controller: _nameController,
                            ),
                          ],
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              userProvider
                                  .changeName(_nameController.text.trim());
                              updateData();
                              _nameController.clear();
                            },
                            child: const Text("Ok"),
                          )
                        ],
                      ),
                    );
                  },
                  leadingIcon: Icons.person_2_outlined,
                  iconColor: pkColor,
                  title: "Change Name",
                  subtitle: "Tap to change name",
                ),
                ProfileTiles(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Change Phone?"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Type your desired new phone number"),
                            TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11)
                              ],
                            ),
                          ],
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              userProvider
                                  .changePhone(_phoneController.text.trim());
                              updateData();
                              _phoneController.clear();
                            },
                            child: const Text("Ok"),
                          )
                        ],
                      ),
                    );
                  },
                  leadingIcon: Icons.phone,
                  iconColor: pkColor,
                  title: "Change Phone",
                  subtitle: "Tap to change phone",
                ),
                ProfileTiles(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Logout?"),
                              content: const Text("Do you want to logout?"),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No"),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    authProvider.signOut();
                                    Get.to(() => const CheckLoggedInUser());
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            ));
                  },
                  leadingIcon: Icons.logout,
                  iconColor: redColor,
                  title: "Logout",
                  subtitle: "Tap to logout",
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class ProfileTiles extends StatelessWidget {
  const ProfileTiles({
    super.key,
    this.onTap,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  final void Function()? onTap;
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        leadingIcon,
        size: 45,
        color: iconColor,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
