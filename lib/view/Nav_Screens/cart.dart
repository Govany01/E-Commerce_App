import 'package:final_project/cartmodel.dart';
import 'package:final_project/model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model.dart';
import 'Cubit/product_cubit.dart';

class Cart extends StatefulWidget {
  Cart({super.key});

  // int index = 0;
  // List<int> indexes = [];
  // Future<List<int>> getIndexesFromDetails() async {
  //   SharedPreferences shared = await SharedPreferences.getInstance();
  //   index = shared.getInt("cartIndex")!;
  //   print(index);
  //   indexes.add(index);
  //   print(indexes);
  //   return indexes;
  // }

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  ProductsModel? items;
  List<int> indexes = [];

  @override
  void initState() {
    super.initState();
    // Cart().getIndexesFromDetails();
    indexes = CartModel().getInd();
    print(indexes);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProduct>(context);

    return BlocProvider(
      create: (context) => ProductCubit(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductLoaded) {
            items = state.items;
            print("loaded");
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
            if (cart.items.length == 0) {
              return Center(
                child: Column(
                  children: [
                    Image.asset("assets/empty-cart.png"),
                    const Text("No Products added to cart" ,
                     style:TextStyle(fontSize: 20 , color: Colors.orange)),
                  ],
                ),
              );
            } else {
              print(indexes.length);
              return ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = cart.items[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                        height: 100.0,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffDDDDDD),
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                              offset: Offset(0.0, 0.0),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.name,
                                  style: const TextStyle(
                                      color: Colors.purple, fontSize: 20)),
                            )),
                            Center(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: 250,
                                            child: Column(children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Price: \$ ${item.price.toStringAsFixed(2)}  ",
                                                  style: const TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.orange),
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                IconButton(
                        onPressed: () {
                          cart.removeFromCart(item);
                        },
                        icon: Icon(Icons.remove_circle_outline),
                      )
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                },
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
