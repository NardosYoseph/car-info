import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          // shadows: [
          //   Shadow(
          //     offset: Offset(1, 1),
          //     blurRadius: 3,
          //     color: Colors.black38,
          //   ),
          // ],
        ),
      ),
      // centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 3,
      flexibleSpace: Container(
        decoration: BoxDecoration(
    color: const Color.fromARGB(255, 90, 147, 245),
 
           borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 2,
        //     blurRadius: 10,
        //     offset: const Offset(0, 3), // Shadow position
        //   ),
        // ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
