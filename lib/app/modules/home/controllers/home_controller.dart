import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //Mengambil Data tidak secara realtime
  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference products = firestore.collection('products');

    return products.get();
  }
  //Mengambil Data secara realtime
    Stream<QuerySnapshot<Object?>> streamData() {
      CollectionReference products = firestore.collection('products');
      return products.snapshots();
    }

  //Fungsi Untuk mendelete 
  void deleteProduct(String id) {
    DocumentReference docRef = firestore.collection('products').doc(id);
    try{
      Get.defaultDialog(
        title: "Info",
        middleText: "Apakah Anda yakin menghapus data ini ?",
        onConfirm: () {
          docRef.delete();
          Get.back();
        },
        textConfirm: "Ya",
        textCancel: "Batal",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title : "Terjadi Kesalahan",
        middleText: "Tidak Berhasil Menghapus Data",
      );
    }
  }

  }