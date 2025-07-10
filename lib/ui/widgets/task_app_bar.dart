import 'package:flutter/material.dart';

import '../screens/sing_in_screen.dart';
import '../screens/update_profile_screen.dart';

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
    final canPop = Navigator.canPop(context);

    return AppBar(
      backgroundColor: const Color(0xFF21BF73),

      leading: canPop
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            )
          : null,
      leadingWidth: canPop ? 40 : 0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: _onTapProfile,
              child: CircleAvatar(
                radius: 24,
                backgroundImage: const NetworkImage(
                  'https://i.pinimg.com/736x/92/36/b9/9236b9e8e41a5e84eb0b689614aaeddf.jpg',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
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
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),

      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          color: Colors.white,
          onPressed: _onTapSignOutButton,
        ),
      ],
    );
  }

  void _onTapSignOutButton() {
    Navigator.pushNamedAndRemoveUntil(context, SingInScreen.name, (_) => false);
  }

  void _onTapProfile() {
    if(ModalRoute.of(context)!.settings.name != UpdateProfileScreen.name){
      Navigator.pushNamed(context, UpdateProfileScreen.name);
    }

  }
}
