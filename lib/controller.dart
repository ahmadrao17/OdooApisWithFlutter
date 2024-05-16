import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo_api/test_services.dart';
import 'package:odoo_api/user_model.dart';

class Controller extends GetxController {
  final Testservice testService = Testservice();
  final emailController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  var user = <users>[].obs;
  RxBool loading = true.obs;
  RxString errorMessage = ''.obs;
  dynamic result;

  getAllUsers() async {
    try {
      loading.value = true;
      if (user.isNotEmpty) {
        user.clear();
      }
      result = await testService.fetchdata();
      errorMessage.value = '';
      for (var element in result) {
        user.add(users.fromJson(element));
      }
      // user.value.addAll(result);
      // user = result.foreach((v) {
      //   user.add(users.fromJson(v));
      //   print(v['id']);
      // });
      // user.value = result.map((e) => users.fromJson(e)).toList();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  addUsers() async {
    var result = {};
    loading.value = true;
    try {
      result = await testService.createdata(
          nameController.value.text, emailController.value.text);
      getAllUsers();
      if (result['status']) {
        Get.defaultDialog(
          title: "Congratulations 🥱",
          content: const ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            subtitle: Text("User added successfully"),
          ),
          textConfirm: "Ok".tr,
          onConfirm: () {
            Get.back();
            emailController.value.clear();
            nameController.value.clear();
          },
        );
      }
    } catch (e) {
      errorMessage.value = result['message'] + " e";
      Get.defaultDialog(
        title: "Cannot add the user",
        content: const ListTile(
          leading: Icon(
            Icons.person,
            size: 30,
          ),
          subtitle: Text("Please check your internet connection."),
        ),
        textConfirm: "Try Again".tr,
        onConfirm: () {
          Get.back();
        },
      );
    } finally {
      loading.value = false;
    }
  }

  updateUser(int id) async {
    var result = {};
    loading.value = true;
    try {
      result = await testService.updateData(
          nameController.value.text, emailController.value.text, id);
      getAllUsers();
      if (result['status']) {
        Get.defaultDialog(
          title: "Congratulations 🥱",
          content: const ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            subtitle: Text("User updated successfully"),
          ),
          textConfirm: "Ok".tr,
          onConfirm: () {
            Get.back();
            emailController.value.clear();
            nameController.value.clear();
          },
        );
      }
    } catch (e) {
      errorMessage.value = result['message'] + " e";
      Get.defaultDialog(
        title: "Cannot add the user",
        content: const ListTile(
          leading: Icon(
            Icons.person,
            size: 30,
          ),
          subtitle: Text("Please check your internet connection."),
        ),
        textConfirm: "Try Again".tr,
        onConfirm: () {
          Get.back();
        },
      );
    } finally {
      loading.value = false;
    }
  }

  deleteUser(int id) async {
    var result = {};
    loading.value = true;
    try {
      result = await testService.deleteData(id);
      getAllUsers();
      if (result['status']) {
        Get.defaultDialog(
          title: "Congratulations 🥱",
          content: const ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            subtitle: Text("Record Deleted Successful"),
          ),
          textConfirm: "Ok".tr,
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      errorMessage.value = result['message'] + " e";
      Get.defaultDialog(
        title: "Cannot add the user",
        content: const ListTile(
          leading: Icon(
            Icons.person,
            size: 30,
          ),
          subtitle: Text("Please check your internet connection."),
        ),
        textConfirm: "Try Again".tr,
        onConfirm: () {
          Get.back();
        },
      );
    } finally {
      loading.value = false;
    }
  }
}
