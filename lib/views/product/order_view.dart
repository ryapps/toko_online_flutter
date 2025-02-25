import 'package:flutter/material.dart';
import 'package:online_shop_app/widgets/bottom_nav.dart';


class OrderView extends StatefulWidget {
  const OrderView({super.key});


  @override
  State<OrderView> createState() => _OrderViewState();
}


class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesan"),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
      ),
      body: Text("Pesan"),
      bottomNavigationBar: BottomNav(1),
    );
  }
}
