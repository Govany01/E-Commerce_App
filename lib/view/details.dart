import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/cartmodel.dart';
import 'package:final_project/view/Nav_Screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../itemsModel.dart';
import '../model.dart';
import '../model/ProductModel.dart';
import 'Nav_Screens/Cubit/product_cubit.dart';

class details extends StatefulWidget {
  int Index;
  details({super.key, required this.Index});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  ProductsModel? items;
  // CartModel cart = CartModel();
  List<String> images = [];
  double discountAmount = 0;
  String rounded = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: const Text(
            "City Shop",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: BlocProvider(
        create: (context) => ProductCubit(),
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductLoaded) {
              items = state.items;
              images = items!.products[widget.Index].images;
              discountAmount = items!.products[widget.Index].price *
                  items!.products[widget.Index].discountPercentage /
                  100;
              rounded = discountAmount.toStringAsFixed(2);
            }
            if (state is ProductError) {
              SnackBar snack = SnackBar(content: Text(state.ErrorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snack);
            }
          },
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(items!.products[widget.Index].title,
                            style: const TextStyle(
                              color: Colors.purple,
                              fontSize: 25,
                            )),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Brand : ${items!.products[widget.Index].brand}",
                              style: const TextStyle(color: Colors.orange)),
                        ),
                        const Spacer(),
                        Text("Rating : ${items!.products[widget.Index].rating}",
                            style: const TextStyle(color: Colors.orange)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 300.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (position, reason) {
                          print(reason);
                          print(CarouselPageChangedReason.controller);
                        },
                        enableInfiniteScroll: false,
                      ),
                      items: images.map<Widget>((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(i))));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      items!.products[widget.Index].description,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "\$ ${items!.products[widget.Index].price}",
                            style:
                                TextStyle(fontSize: 35, color: Colors.orange),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            "Discount : ${items!.products[widget.Index].discountPercentage} %",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Discount Amount : \$ $rounded",
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: 250,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          final cart =
                              Provider.of<CartProduct>(context, listen: false);
                          final item = CartItem(
                            name: items!.products[widget.Index].title,
                            price: items!.products[widget.Index].price,
                          );
                          cart.addToCart(item);
                           SnackBar snack = const SnackBar(
                            content:
                             Center(child: Text("Item added to cart")),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);

                          // getIndex(widget.Index);
                          // Cart().getIndexesFromDetails();
                          // cart.setInd(widget.Index);
                          // print(cart.getInd());
                        },
                        child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Add to Cart",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            )),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }


}
