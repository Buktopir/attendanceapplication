import 'package:flutter/material.dart';
import 'package:attendanceapplication/src/features/widgets/widgets.dart';

class AddPollWidget extends StatefulWidget {
  const AddPollWidget({Key? key}) : super(key: key);

  @override
  State<AddPollWidget> createState() => _AddPollWidget();
}

class _AddPollWidget extends State<AddPollWidget> {
  late List<String> items;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    items = ['']; // Начальный элемент
    controllers = [TextEditingController()];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Question',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
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
          child: ReorderableListView.builder(
            itemCount: items.length,
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
      ],
    );
  }
}
