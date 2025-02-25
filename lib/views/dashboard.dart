import 'package:flutter/material.dart';
import 'package:online_shop_app/models/user_login.dart';
import 'package:online_shop_app/services/user.dart';
import 'package:online_shop_app/models/response_data_map.dart';
import 'package:online_shop_app/widgets/alert.dart';
import 'package:online_shop_app/widgets/bottom_nav.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final UserService userService = UserService();

  UserLogin userLogin = UserLogin();
  String? nama;
  String? role;

  getUserLogin() async {
    var user = await userLogin.getUserLogin();
    if (user.status == true) {
      setState(() {
        nama = user.nama_user;
        role = user.role;
      });
    }
  }

  void _logout() async {
    ResponseDataMap response = await userService.logoutUser();
    if (response.status) {
      Future.delayed(Duration(seconds: 2), () {
        AlertMessage().showAlert(context, response.message, true);

        Navigator.popUntil(context, (route) => route.isFirst);
      }); // Redirect ke halaman login
    } else {
      AlertMessage().showAlert(context, response.message, false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: _logout, icon: Icon(Icons.logout))],
      ),
      body: Center(child: Column(
        children: [
          Text("Selamat Datang $nama role anda $role"),
        ],
      )),
            bottomNavigationBar: BottomNav(0),
    );
  }
}
