import 'package:flutter/material.dart';
import 'package:whatsapp_status_server/colors/colors.dart';

class DrawerWA extends StatefulWidget {
  const DrawerWA({super.key});

  @override
  State<DrawerWA> createState() => _DrawerWAState();
}

class _DrawerWAState extends State<DrawerWA> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Whatsapp Status Sever',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainColor,
                  ),
                ),
                const Divider(
                  height: 100,
                  thickness: 1,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
                      children: [
                        Icon(Icons.dark_mode_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
                      children: [
                        Icon(Icons.dark_mode_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
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
