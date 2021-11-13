import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theme_looks_task/helper/apihelper.dart';
import 'package:theme_looks_task/screen/product_card.dart';
import 'package:theme_looks_task/screen/product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = new ScrollController();
  int end_limit = 0;
  int startl_limit = 4;
  List _products = [];
  bool updating = false;

  fetchAppProducts() async {
    end_limit = await ApiHelper.getAllProducts();
    _products = await ApiHelper.getProductByLimit(startl_limit);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAppProducts();

    // _scrollController.addListener(() async {
    //
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //
    //     print("Scoll");
    //     startl_limit = startl_limit + 4;
    //
    //     if (startl_limit <= end_limit) {
    //       _products.clear();
    //       _products = await ApiHelper.getProductByLimit(startl_limit);
    //       setState(() {});
    //
    //     } else {
    //       print('no more data found');
    //     }
    //
    //   }
    //
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_products.isEmpty)
      return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Looks Task"),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            getPaging();
          }
          return true;
        },
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  controller: _scrollController,
                  itemCount: _products.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: .7),
                  itemBuilder: (context, index) => ProductCard(
                        press: () {Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context)=>ProductDetails(id: _products[index]['id'])));},
                        product: _products[index],
                      )),
            ),
            if (updating) const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }

  void getPaging() async {
    setState(() {
      updating = true;
    });

    var scrollpositin = _scrollController.position;
    if (scrollpositin.pixels == scrollpositin.maxScrollExtent) {

      startl_limit = startl_limit + 4;
      if (startl_limit <= end_limit) {
        _products = await ApiHelper.getProductByLimit(startl_limit);
      }

    }
    setState(() {
      updating = false;
    });
  }
}
