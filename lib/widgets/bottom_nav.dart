import 'package:flutter/material.dart';
import 'package:online_shop_app/models/user_login.dart';


class BottomNav extends StatefulWidget {
  int activePage;
  BottomNav(this.activePage);


  @override
  State<BottomNav> createState() => _BottomNavState();
}


class _BottomNavState extends State<BottomNav> {
  UserLogin userLogin = UserLogin();
  String? role;
  getDataLogin() async {
    var user = await userLogin!.getUserLogin();
    if (user!.status != false) {
      setState(() {
        role = user.role;
      });
    } else {
      Navigator.popAndPushNamed(context, '/login');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataLogin();
  }


  void getLink(index) {
    if (role == "admin") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/product');
      }
    } else if (role == "kasir") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/order');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return role == "admin"
        ? BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            currentIndex: widget.activePage,
            onTap: (index) => {getLink(index)},
            items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'Product',
                ),
              ])
        : role == "kasir"
            ? BottomNavigationBar(
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                currentIndex: widget.activePage,
                onTap: (index) => {getLink(index)},
                items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.receipt_long),
                      label: 'Pesan',
                    ),
                  ])
            : Text("");
  }
}
