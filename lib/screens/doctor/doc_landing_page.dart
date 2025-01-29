import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/providers/auth_user_provider.dart';
import 'package:health_buddy/providers/user_provider.dart';
import 'package:health_buddy/screens/authentication/check_loggedin.dart';
import 'package:health_buddy/screens/doctor/doc_appointment_screen.dart';
import 'package:health_buddy/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class DocLandingPage extends StatefulWidget {
  const DocLandingPage({super.key});

  @override
  State<DocLandingPage> createState() => _DocLandingPageState();
}

class _DocLandingPageState extends State<DocLandingPage> {
  int pageIndex = 0;

  List pages = [
    // const DocHomeScreen(),
    const DocAppointmentScreen(),
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
              ? "Appointments"
              // : pageIndex == 1
              //     ? "Appointments"
              : "Profile"),
        ),
        // drawer: docDrawer(userdata, authProvider, context),
        drawer: Drawer(
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
                  Icons.calendar_month,
                  color: pkColor,
                ),
                title: const Text("Appointments"),
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
                          ));
                },
                leading: const Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                title: const Text("Logout"),
              ),
            ],
          ),
        ),
        body: pages[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageIndex,
            onTap: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: const [
              // BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: "Appointments"),
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

  Drawer docDrawer(
      UserModel userdata, AuthUserProvider authProvider, BuildContext context) {
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
              Icons.calendar_month,
              color: pkColor,
            ),
            title: const Text("Appointments"),
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
                      ));
            },
            leading: const Icon(
              Icons.power_settings_new,
              color: Colors.red,
            ),
            title: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
