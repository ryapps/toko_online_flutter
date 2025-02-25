import 'package:flutter/material.dart';
import 'package:online_shop_app/widgets/bottom_nav.dart';


class ProductView extends StatefulWidget {
  const ProductView({super.key});


  @override
  State<ProductView> createState() => _ProductViewState();
}


class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
      ),
      body: Text("Product"),
            bottomNavigationBar: BottomNav(1),

    );
  }
}
