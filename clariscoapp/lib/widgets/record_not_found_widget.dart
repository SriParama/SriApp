import 'package:flutter/material.dart';

class RecordNotFoundWidget extends StatelessWidget {
  const RecordNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.folder_off, color: Colors.grey, size: 50),
              const SizedBox(height: 8),
              Text(
                'Record not found',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          );
  }
}