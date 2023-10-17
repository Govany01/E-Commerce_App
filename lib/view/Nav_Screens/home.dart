import 'package:final_project/model/ProductModel.dart';
import 'package:final_project/view/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/product_cubit.dart';

class products extends StatefulWidget {
  const products({super.key});

  @override
  State<products> createState() => _productsState();
}

class _productsState extends State<products> {
  // bool iSLoading = true;
  ProductsModel? items;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductLoaded) {
            items = state.items;
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
            return ListView.builder(
              itemCount: items?.products.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                        height: 180.0,
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
                              child: Text(items!.products[index].title,
                                  style: const TextStyle(
                                      color: Colors.purple, fontSize: 20)),
                            )),
                            Center(
                              child: Row(
                                children: [
                                  SizedBox(
                                      child: Image.network(
                                    items!.products[index].thumbnail,
                                    width: 120,
                                    height: 100,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 170,
                                          child: Column(children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "\$${items!.products[index].price}  ",
                                                style: const TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.orange),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Discount: ${items!.products[index].discountPercentage} % ",
                                                style: const TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Brand: ${items!.products[index].brand} ",
                                                style: const TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => details(
                            Index: index,
                          ),
                        ));
                  },
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
