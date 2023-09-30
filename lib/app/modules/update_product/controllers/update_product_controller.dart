import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProductController extends GetxController {
  late TextEditingController cNama;
  late TextEditingController cHarga;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> GetData(String id) async {
    DocumentReference docRef = firestore.collection("products").doc(id);

    return docRef.get();
  }

  void UpdateProduct(String nama, String harga, String id) async{}
  
  @override
  void onInit() {
    // TODO: implement onInit
    cNama = TextEditingController();
    cHarga = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNama.dispose();
    cHarga.dispose();
    super.onClose();
  }
}
