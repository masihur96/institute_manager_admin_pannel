import 'package:flutter/material.dart';

import 'package:institute_manager_admin_pannel/model/provider_model/public_provider.dart';

import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final List<String> imgList = [
    'assets/images/splash_3.png',
    'assets/images/splash_3.png',
    'assets/images/splash_3.png',
    'assets/images/splash_3.png',
  ];
  List colorList = [
    Color(0xffBC9E57),
    Color(0xffcfcfcf),
    Color(0xff23cfcf),
    Color(0xff232323),
    Color(0xfffcfcfc),
    Color(0xffBC9E57),
  ];

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    return Container(
        width: publicProvider.pageWidth(size),
        child: ListView(
          children: [
            publicProvider.isWindows
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: publicProvider.pageWidth(size) * .5,
                          child: productImageList(publicProvider, size)),
                      productDetailsData(publicProvider, size)
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: publicProvider.pageWidth(size) * .5,
                          child: productImageList(publicProvider, size)),
                      productDetailsData(publicProvider, size)
                    ],
                  ),
          ],
        ));
  }

  Widget productImageList(PublicProvider publicProvider, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Stack(children: [
            Container(
              // width: size.height*.4,
              height:
                  publicProvider.isWindows ? size.height * .5 : size.width * .5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: imgList.isNotEmpty
                  ? Container(
                      child: Image.asset(
                        imgList[_currentIndex],
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(),
            ),
          ]),
          Container(
            height:
                publicProvider.isWindows ? size.height * .2 : size.width * .2,
            width: publicProvider.pageWidth(size) * .5,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: imgList.isEmpty ? 3 : imgList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      child: imgList.isNotEmpty
                          ? Container(
                              width: publicProvider.pageWidth(size) * .1,
                              height: publicProvider.isWindows
                                  ? size.height * .3
                                  : size.width * .3,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              alignment: Alignment.center,
                              child: Image.asset(
                                imgList[_currentIndex],
                                fit: BoxFit.cover,
                              ))
                          : Container(
                              width: publicProvider.pageWidth(size) * .1,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              height: 200,
                            ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget productDetailsData(PublicProvider publicProvider, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Product Details',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            width: publicProvider.pageWidth(size) * .45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Title: T-Shirt for Male',
                      style: TextStyle(
                        fontSize: publicProvider.isWindows
                            ? size.height * .03
                            : size.width * .03,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Description: Same Day Printing, Cheap Price, Place Your Order Today. Best Quality Printing. Place Your Order online, Choose Local pick up or Free Shippin on Check out Page. Call Now To Get Quote. Best Price Guratantee. Amenities: All-Inclusive Pricing, Free Expert Help, Free Design Review.',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .03
                              : size.width * .03,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Price: 250 tk',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .03
                              : size.width * .03,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Size: S, M, L ,XL, XXL,XXXL',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .03
                              : size.width * .03,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Profit Amount: 10 %',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .03
                              : size.width * .03,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Category: T-Shirt',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .03
                              : size.width * .03,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Subcategory: Baby',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .03
                              : size.width * .03,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Color: Green, Red, Blue',
                        style: TextStyle(
                          fontSize: publicProvider.isWindows
                              ? size.height * .03
                              : size.width * .03,
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Color :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: publicProvider.isWindows
                                  ? size.height * .04
                                  : size.width * .04,
                            ),
                          ),
                          Container(
                            height: size.height * .05,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    colorList.isEmpty ? 3 : colorList.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          color: colorList.isEmpty
                                              ? Colors.white70
                                              : colorList[index],
                                          shape: BoxShape.circle),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  publicProvider.subCategory = 'Add Product';
                  publicProvider.category = '';
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(width: 1, color: Colors.green)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50.0,
                        vertical: 5,
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: publicProvider.isWindows
                              ? size.height * .03
                              : size.width * .03,
                        ),
                      ),
                    ))),
          )
        ],
      ),
    );
  }
}
