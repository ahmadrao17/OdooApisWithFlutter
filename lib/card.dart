import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:odoo_api/add_update_form.dart';
import 'package:odoo_api/controller.dart';

// ignore: must_be_immutable
class UserCard extends StatelessWidget {
  UserCard({
    super.key,
    required this.id,
    required this.name,
    required this.email,
  });

  Controller controller = Get.put(Controller());

  int id;
  String name, email;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ID: $id",
                  style: const TextStyle(fontSize: 12),
                )),
            const SizedBox(width: 10),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 61, 61, 61)),
                        children: [
                          TextSpan(
                              text: 'Name: $name\n',
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          TextSpan(
                              text: 'Email: $email',
                              style: const TextStyle(fontSize: 10)),
                        ]),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: "",
                          content: AddUpdateForm(
                            form: "Update User",
                            id: id,
                            name: name,
                            email: email,
                          ));
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: "Are you sure you want to delete user:",
                          middleText: name,
                          textConfirm: "Yes",
                          onConfirm: () async {
                            Get.back();
                            await controller.deleteUser(id);
                          },
                          onCancel: () => Get.back());
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
