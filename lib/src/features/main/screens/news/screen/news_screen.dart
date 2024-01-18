import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<String> data = ['']; // Изначально один пустой элемент

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return NewRowItem(
              text: data[index],
              onChanged: (newText) {
                setState(() {
                  data[index] = newText;
                });
                // Если это последний элемент и он не пустой, добавляем новый пустой элемент
                if (index == data.length - 1 && newText.isNotEmpty) {
                  data.add('');
                }

                // Удаляем все пустые элементы, кроме последнего, чтобы всегда был хотя бы один пустой элемент
                for (int i = 0; i < data.length; i++) {
                  String element = data[i];
                  if (element.isEmpty && i != data.length - 1) {
                    data.removeAt(i);
                    i--; // Уменьшаем индекс, чтобы не пропустить следующий элемент после удаления
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class NewRowItem extends StatelessWidget {
  final String text;
  final ValueChanged<String> onChanged;

  NewRowItem({
    required this.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Введите ваш ответ',
        ),
      ),
    );
  }
}
