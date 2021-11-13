import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:theme_looks_task/const/AppConstant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);
  var product;
  VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: GestureDetector(
        onTap: press,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.4,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.network(product['image']),
              ),
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
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        SmoothStarRating(
                            allowHalfRating: false,
                            onRated: (v) {},
                            starCount: 5,
                            rating: double.parse(product['rating']['rate'].toString()),
                            size: 20.0,
                            isReadOnly: true,
                            color: AppColorsConst.dPrimaryColor.withOpacity(0.6),
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
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '৳${product['price']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColorsConst.dPrimaryColor),
                      maxLines: 1,
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
