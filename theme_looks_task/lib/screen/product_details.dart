import 'package:flutter/material.dart';
import 'package:theme_looks_task/const/AppConstant.dart';
import 'package:theme_looks_task/helper/apihelper.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var product;

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  getProduct() async {
    product = await ApiHelper.getProductDetails(widget.id);
    print(product);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            GestureDetector(onTap: () {Navigator.pop(context);}, child: const Icon(Icons.arrow_back)),
        title: const Text("Product Details"),
      ),
      body: SafeArea(
        child: product == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    height: 250,
                    padding: const EdgeInsets.all(8),
                    child: Image.network(product['image']),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 8.0),
                          child: Text(
                            '৳${product['price']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColorsConst.dPrimaryColor),
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Row(
                            children: [
                              SmoothStarRating(
                                  allowHalfRating: false,
                                  onRated: (v) {},
                                  starCount: 5,
                                  rating: double.parse(
                                      product['rating']['rate'].toString()),
                                  size: 20.0,
                                  isReadOnly: true,
                                  color: AppColorsConst.dPrimaryColor
                                      .withOpacity(0.6),
                                  borderColor: AppColorsConst.dPrimaryColor,
                                  spacing: 0.0),
                              Text(
                                '(${product['rating']['count']})',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product['description'],
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
