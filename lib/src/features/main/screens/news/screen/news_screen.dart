// news_screen.dart
import 'package:attendanceapplication/src/features/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Widget> widgetsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Add News') {
                _showAddNewsBottomSheet(context);
              } else if (value == 'Add Poll') {
                _showAddPollBottomSheet(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return ['Add News', 'Add Poll'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
            TextNewsWidget(
              title: 'Important News Title',
              newsText:
                  'This is the content of the news. It can be a longer text describing the news.',
              author: 'Viktor ',
              dateTime: 'January 21, 2024 10:30 AM',
            ),
            SizedBox(height: 16.0),
            PollWidget(
              question: 'What is your favorite color?',
              options: ['Red', 'Blue', 'Green', 'Yellow'],
              author: 'Viktor',
              dateTime: 'January 21, 2024 11:45 AM',
            ),]
          )),
    );
  }

  void _showAddNewsBottomSheet(BuildContext context) {
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (BuildContext context) {
    //     return AddNewsWidget();
    //   },
    // );
  }

  void _showAddPollBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddPollWidget();
      },
    );
  }
}

class TextNewsWidget extends StatelessWidget {
  final String title;
  final String newsText;
  final String author;
  final String dateTime;

  TextNewsWidget(
      {required this.title,
      required this.newsText,
      required this.author,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(newsText),
            SizedBox(height: 8.0),
            Text('By $author • $dateTime'),
          ],
        ),
      ),
    );
  }
}

class PollWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final String author;
  final String dateTime;

  PollWidget(
      {required this.question,
      required this.options,
      required this.author,
      required this.dateTime});

  @override
  _PollWidgetState createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  String? selectedOption;
  Map<String, int> voteCount = {};

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.options
                  .map((option) => Row(
                        children: [
                          Radio(
                            value: option,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value as String?;
                              });
                            },
                          ),
                          Text(option),
                        ],
                      ))
                  .toList(),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: selectedOption != null ? _vote : null,
              child: Text('Vote'),
            ),
            SizedBox(height: 8.0),
            _buildResults(),
            SizedBox(height: 8.0),
            Text('By ${widget.author} • ${widget.dateTime}'),
          ],
        ),
      ),
    );
  }

  void _vote() {
    setState(() {
      voteCount.update(selectedOption!, (value) => value + 1,
          ifAbsent: () => 1);
      selectedOption = null;
    });
  }

  Widget _buildResults() {
    if (voteCount.isEmpty) {
      return Container();
    }

    int totalVotes =
        voteCount.values.reduce((value, element) => value + element);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.options.map((option) {
        int optionVotes = voteCount[option] ?? 0;
        double percentage =
            totalVotes > 0 ? (optionVotes / totalVotes) * 100 : 0.0;

        return Text('$option: ${percentage.toStringAsFixed(2)}%');
      }).toList(),
    );
  }
}
