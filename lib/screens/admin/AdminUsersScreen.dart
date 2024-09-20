import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/utils/constant.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({Key? key}) : super(key: key);

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  TextEditingController controller = TextEditingController();
  List<User> list = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      List<User> users = await UserService().fetchUsers();
      setState(() {
        list = users;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CupertinoSearchTextField(
                    placeholder: 'Search',
                    onChanged: (value) {
                      print(value);
                      setState(() {});
                    },
                    onSubmitted: (value) {},
                    controller: controller,
                  ),
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : errorMessage != null
                        ? Text('Error: $errorMessage')
                        : Expanded(
                            child: ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                String name =
                                    "${list[index].firstName} ${list[index].lastName}";
                                if (controller.text.isEmpty) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      child: ClipOval(
                                          child: Image.network(
                                        'http://127.0.0.1:5000/uploads/1723414584634.jpeg',
                                        // 'http://127.0.0.1:5000/${list[index].photo}',
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          print(
                                              '$backendUrl/${list[index].photo}');
                                          return Icon(
                                              Icons.error); // Placeholder icon
                                        },
                                      )),
                                    ),
                                    title: Text(
                                        "${list[index].firstName} ${list[index].lastName}"),
                                    subtitle: Text(list[index].role),
                                    trailing: list[index].isVerified
                                        ? Icon(Icons.account_circle,
                                            color: Colors.red.shade600)
                                        : const Icon(Icons.no_accounts),
                                  );
                                } else if (name.toLowerCase().contains(
                                        controller.text.toLowerCase()) ||
                                    list[index].role.toLowerCase().contains(
                                        controller.text.toLowerCase())) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      child: ClipOval(
                                          child: Image.network(
                                        'http://127.0.0.1:5000/uploads/1723414584634.jpeg',
                                        // 'http://127.0.0.1:5000/${list[index].photo}',
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          print(
                                              '$backendUrl/${list[index].photo}');
                                          return Icon(
                                              Icons.error); // Placeholder icon
                                        },
                                      )),
                                    ),
                                    title: Text(
                                        "${list[index].firstName} ${list[index].lastName}"),
                                    subtitle: Text(list[index].role),
                                    trailing: list[index].isVerified
                                        ? Icon(Icons.account_circle,
                                            color: Colors.red.shade600)
                                        : const Icon(Icons.no_accounts),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
