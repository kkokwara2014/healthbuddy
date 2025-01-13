import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/providers/auth_user_provider.dart';
import 'package:health_buddy/providers/user_provider.dart';
import 'package:health_buddy/screens/authentication/check_loggedin.dart';
import 'package:health_buddy/screens/dashboard/appointment_screen.dart';
import 'package:health_buddy/screens/dashboard/home_screen.dart';
import 'package:health_buddy/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int pageIndex = 0;
  List pages = [
    const HomeScreen(),
    const AppointmentScreen(),
    const Center(
      child: Icon(
        Icons.notifications,
        size: 32,
        color: pkColor,
      ),
    ),
    const ProfileScreen(),
  ];

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
  Widget build(BuildContext context) {
    UserModel? userdata = Provider.of<UserProvider>(context).getuser;
    final authProvider = Provider.of<AuthUserProvider>(context);

    if (userdata != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(pageIndex == 0
              ? "Health Buddy"
              : pageIndex == 1
                  ? "Appointments"
                  : pageIndex == 2
                      ? "Notifications"
                      : "Profile"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ),
            )
          ],
        ),
        drawer: myDrawer(userdata, context, authProvider),
        body: pages[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: "Appointments"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: "Notifications"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined), label: "Profile"),
            ]),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Drawer myDrawer(
      UserModel userdata, BuildContext context, AuthUserProvider authProvider) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: pkColor),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    userdata.userimage,
                    width: 85,
                    height: 85,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userdata.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  userdata.email,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                pageIndex = 0;
              });
              Navigator.pop(context);
            },
            leading: const Icon(
              Icons.home,
              color: pkColor,
            ),
            title: const Text("Home"),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              setState(() {
                pageIndex = 1;
              });
              Navigator.pop(context);
            },
            leading: const Icon(
              Icons.calendar_month,
              color: pkColor,
            ),
            title: const Text("Appointments"),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              setState(() {
                pageIndex = 2;
              });
              Navigator.pop(context);
            },
            leading: const Icon(
              Icons.local_activity,
              color: pkColor,
            ),
            title: const Text("Activities"),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              setState(() {
                pageIndex = 3;
              });
              Navigator.pop(context);
            },
            leading: const Icon(
              Icons.person_2_outlined,
              color: pkColor,
            ),
            title: const Text("Profile"),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
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
                ),
              );
            },
            leading: const Icon(
              Icons.logout,
              color: redColor,
            ),
            title: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
