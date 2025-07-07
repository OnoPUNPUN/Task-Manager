import 'package:flutter/material.dart';

import '../screens/sing_in_screen.dart';

class TaskAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TaskAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<TaskAppBar> createState() => _TaskAppBarState();
}

class _TaskAppBarState extends State<TaskAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(33, 191, 115, 1),
      flexibleSpace: Container(
        margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 24,
              child: ClipOval(
                child: Image.network(
                  "https://i.pinimg.com/736x/92/36/b9/9236b9e8e41a5e84eb0b689614aaeddf.jpg",
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wasimul Bari Tonmoy',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'tonmoy@gmail.com',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [IconButton(onPressed: _onTapSingOutButton, icon: Icon(Icons.logout))],
      actionsIconTheme: IconThemeData(color: Colors.white),
    );
  }

  void _onTapSingOutButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SingInScreen.name,
      (predicate) => false,
    );
  }
}
