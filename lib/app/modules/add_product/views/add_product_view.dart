import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding : EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: controller.cNama,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            SizedBox(),
            TextField(
              controller: controller.cHarga,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Harga"),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => controller.addProduct(
                controller.cNama.text, 
                controller.cHarga.text,
                ),
              child: Text("Simpan"),
            ),
          ]),
        ),
    );
  }
}
