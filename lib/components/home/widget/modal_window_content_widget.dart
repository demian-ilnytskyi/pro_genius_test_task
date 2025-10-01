import 'package:flutter/material.dart';

class ModalWindowContentWidget extends StatelessWidget {
  const ModalWindowContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        if (index == 20) {
          return const TextField();
        }
        return Container(
          height: 80,
          color: index.isEven ? Colors.blue : Colors.green,
          alignment: Alignment.center,
          child: Text('Item $index'),
        );
      },
    );
  }
}
