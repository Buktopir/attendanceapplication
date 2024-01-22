import 'package:flutter/material.dart';
import 'package:attendanceapplication/src/features/widgets/widgets.dart';

class AddPollWidget extends StatefulWidget {
  final Function(String question, List<String> options) onPollCreated;

  const AddPollWidget({Key? key, required this.onPollCreated}) : super(key: key);

  @override
  State<AddPollWidget> createState() => _AddPollWidget();
}


class _AddPollWidget extends State<AddPollWidget> {
  late List<String> items;
  late List<TextEditingController> controllers;
  late ScrollController _scrollController;
  late TextEditingController questionController;

  @override
  void initState() {
    super.initState();
    items = ['']; // Начальный элемент
    controllers = [TextEditingController()];
    _scrollController = ScrollController();
    questionController = TextEditingController();
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
                    String question = questionController.text;
                    List<String> options = items.where((option) => option.isNotEmpty).toList();

                    // Вызовите колбэк, передавая данные
                    widget.onPollCreated(question, options);

                    // Закройте BottomSheet
                    Navigator.of(context).pop();
                  },
                  child: Text('Create'),
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
                controller: questionController,
                decoration: const InputDecoration(
                  hintText: 'Ask a question',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Poll option',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(bottom: 320.0),
                child: ReorderableListView.builder(
                  itemCount: items.length,
                  scrollController: _scrollController,
                  itemBuilder: (context, index) {
                    return ReorderableDragStartListener(
                      index: index,
                      key: Key('$index'),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AddPollOption(
                                text: items[index],
                                controller: controllers[index],
                                onChanged: (value) {
                                  setState(() {
                                    // Обновляем элемент списка при изменении текста
                                    items[index] = value;

                                    // Проверяем, нужно ли добавить новый пустой элемент
                                    if (index == items.length - 1 &&
                                        value.isNotEmpty) {
                                      items.add('');
                                      controllers.add(TextEditingController());
                                    }
                                    if (value.isNotEmpty) {
                                      _scrollController.animateTo(
                                        _scrollController.position
                                            .maxScrollExtent,
                                        duration: Duration(milliseconds: 100),
                                        curve: Curves.easeOut,
                                      );
                                    }

                                    // Проверяем, нужно ли удалить текущий элемент
                                    if (index < items.length - 1 &&
                                        value.isEmpty &&
                                        items.length > 1) {
                                      items.removeAt(index);
                                      controllers.removeAt(index);
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  onReorderStart: (index) {
                    FocusScope.of(context).unfocus();
                  },
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final item = items[oldIndex];
                      final controller = controllers[oldIndex];
                      if (items[oldIndex] != '' && items[newIndex] != '') {
                        items.removeAt(oldIndex);
                        controllers.removeAt(oldIndex);
                        items.insert(newIndex, item);
                        controllers.insert(newIndex, controller);
                      }
                    });
                  },
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
