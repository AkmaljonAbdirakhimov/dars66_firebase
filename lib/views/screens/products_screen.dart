import 'package:dars64_statemanagement/controllers/products_controller.dart';
import 'package:dars64_statemanagement/models/product.dart';
import 'package:dars64_statemanagement/views/screens/cart_screen.dart';
import 'package:dars64_statemanagement/views/widgets/add_product_dialog.dart';
import 'package:dars64_statemanagement/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsController = context.watch<ProductsController>();
    // Provider.of<ProductsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("D I N A M O"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const CartScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: productsController.list,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text("Mahsulot mavjud emas"),
            );
          }

          final products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (ctx, index) {
              final product = Product.fromMap(products[index]);
              return ListTile(
                onTap: () {
                  final titleController = TextEditingController();
                  titleController.text = product.title;
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text("O'zgartirish"),
                        content: TextField(
                          controller: titleController,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              productsController.editProduct(
                                  product.id, titleController.text);

                              Navigator.pop(context);
                            },
                            child: const Text("SAQLASH"),
                          ),
                        ],
                      );
                    },
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: product.color,
                ),
                title: Text(product.title),
                subtitle: Text("\$${product.price}"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return AddProductDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
