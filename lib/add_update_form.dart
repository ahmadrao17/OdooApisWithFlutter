import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo_api/controller.dart';

class AddUpdateForm extends StatelessWidget {
  AddUpdateForm(
      {required this.form, this.id, this.name, this.email, super.key});
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Controller controller = Get.put(Controller());
  String form;
  String? name;
  String? email;
  int? id;

  bool validate() {
    return formkey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    if (form == 'Update User') {
      controller.emailController.value.text = email!;
      controller.nameController.value.text = name!;
    }
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  form,
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.emailController.value,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: controller.nameController.value,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: id == null
                  ? () async {
                      if (formkey.currentState!.validate()) {
                        print("Validated");
                        Get.back();
                        await controller.addUsers();
                      } else {
                        print("Not Validated");
                      }
                    }
                  : () async {
                      if (formkey.currentState!.validate()) {
                        print("Validated");
                        Get.back();
                        await controller.updateUser(id!);
                      } else {
                        print("Not Validated");
                      }
                    },
              child: Text(
                form,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
