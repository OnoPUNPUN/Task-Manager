import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Color chipColor;
  final String chipTitle;
  const TaskCard({super.key, required this.chipColor, required this.chipTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lorem Ipsum is simply dummy',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.black),
            ),
            Text(
              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
              style: TextStyle(color: Colors.black45),
            ),
            Text(
              "Date: 02/02/2020",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(chipTitle, style: TextStyle(color: Colors.white)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: chipColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit_calendar, color: Colors.greenAccent),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.redAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
