import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../Core/Constants/app_Assets.dart';
import '../core/model/userModel.dart';
import 'Widget/formScreen.dart';
import 'Widget/userCard.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<UserModel> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff29384D),

      appBar: AppBar(
        leadingWidth: 115,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(AppAssets.routeImage),
        ),
        backgroundColor: const Color(0xff29384D),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: users.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(AppAssets.homeImage, height: 300),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "There is No Contacts Added Here",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                )
              : GridView.builder(
                  itemCount: users.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return UserCard(
                      user: users[index],
                      onDelete: () {
                        setState(() {
                          users.removeAt(index);
                        });
                      },
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (users.isNotEmpty)
            Bounceable(
              onTap: () async {
                setState(() {
                  users.removeLast();
                });
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color(0xffF93E3E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.delete, color: Colors.white, size: 30),
              ),
            ),
          const SizedBox(height: 10),
          if (users.length < 6)
            Bounceable(
              onTap: () async {
                final newUser = await showModalBottomSheet<UserModel>(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: FormScreen(),
                    );
                  },
                );

                if (newUser != null) {
                  setState(() {
                    users.add(newUser);
                  });
                }
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color(0xffFFF1D4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.add,
                  color: Color(0xff29384D),
                  size: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
