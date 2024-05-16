import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo_api/add_update_form.dart';
import 'package:odoo_api/card.dart';
import 'package:odoo_api/controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Controller controller = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    controller.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data from Odoo'),
        ),
        body: RefreshIndicator(
            onRefresh: () => controller.getAllUsers(),
            child: Obx(() {
              if (controller.loading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.009,
                          left: 10,
                          right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "",
                                  content: AddUpdateForm(form: "Add User"),
                                );
                              },
                              child: const Text("Add User")),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.065,
                          left: 10,
                          right: 10),
                      child: ListView.builder(
                        itemCount: controller.user.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UserCard(
                                  id: controller.user[index].id!,
                                  name: controller.user[index].name!,
                                  email: controller.user[index].email!)
                              // Card.filled(
                              //   child: ListTile(
                              //     title:
                              //         Text("Name: ${controller.user[index].name!}"),
                              //     leading: Text(
                              //       "ID: ${controller.user[index].id!}",
                              //       style: const TextStyle(
                              //         fontSize: 15,
                              //       ),
                              //     ),
                              //     subtitle: Text(
                              //         "Email: ${controller.user[index].email!}"),
                              //     trailing: IconButton(
                              //         onPressed: () {},
                              //         icon: const Icon(
                              //           Icons.edit,
                              //           size: 15,
                              //         )),
                              //   ),
                              // );
                              ;
                        },
                      ),
                    ),
                  ],
                );
              }
            })));
  }
}
