import 'package:flutter/material.dart';

class AddNewsWidget extends StatefulWidget {
  final Function(String TitleNews, String TextNews,) onPollCreated;

  const AddNewsWidget({Key? key, required this.onPollCreated}) : super(key: key);

  @override
  State<AddNewsWidget> createState() => _AddNewsWidget();
}


class _AddNewsWidget extends State<AddNewsWidget> {
  late List<String> items;
  late List<TextEditingController> controllers;
  late TextEditingController TitleNewsContrloller;
  late TextEditingController TextNewsController;

  @override
  void initState() {
    super.initState();
    items = ['']; // Начальный элемент
    controllers = [TextEditingController()];
    TitleNewsContrloller = TextEditingController();
    TextNewsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white,
          child: Column(

            children: [
              SizedBox(
                width: 50,
                child: Divider(thickness: 5,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Кнопка Cancel
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'New Poll',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Пустой контейнер для отступа между кнопками
                  SizedBox(width: 7.0),
                  // Кнопка Create
                  ElevatedButton(
                    onPressed: () {
                      String Titlenews = TitleNewsContrloller.text;
                      String textnews = TextNewsController.text;
                      // Вызовите колбэк, передавая данные
                      widget.onPollCreated(Titlenews, textnews);

                      // Закройте BottomSheet
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
              // Разделительная линия
              Divider(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(

                  'Question',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: TitleNewsContrloller,
                  decoration: const InputDecoration(
                    hintText: 'Title of news',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(

                  'Question',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: TextNewsController,
                  decoration: const InputDecoration(
                    hintText: 'Text of news',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
