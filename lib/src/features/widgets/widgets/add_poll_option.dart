import 'package:flutter/material.dart';

class AddPollOption extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  AddPollOption({
    required this.text,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: 'Add an option',
                border: InputBorder.none,
              ),
            ),
          ),
          ReorderableDragStartListener(
            index: 0,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.drag_handle_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}