import 'package:flutter/material.dart';

import '../widgets/task_card.dart';

class CanceledTaskList extends StatefulWidget {
  const CanceledTaskList({super.key});

  @override
  State<CanceledTaskList> createState() => _CanceledTaskListState();
}

class _CanceledTaskListState extends State<CanceledTaskList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      chipColor: Colors.redAccent,
                      chipTitle: 'Canceled',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
