import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late int currentMonth;
  late int currentYear;
  int? selectedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    currentMonth = now.month;
    currentYear = now.year;
  }

  String getMonthLabel() {
    return DateFormat('MMMM yyyy').format(DateTime(currentYear, currentMonth));
  }

  void updateCalendarLayout() {
    setState(() {});
  }

  void prevMonth() {
    setState(() {
      currentMonth--;
      if (currentMonth == 0) {
        currentMonth = 12;
        currentYear--;
      }
    });
  }

  void nextMonth() {
    setState(() {
      currentMonth++;
      if (currentMonth == 13) {
        currentMonth = 1;
        currentYear++;
      }
    });
  }

  void onDayClick(int day, LongPressStartDetails details) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);
    print('Нажатие на день $day в точке $localPosition');
    showDayMenu(context, details, day);
    setState(() {
      selectedDay = day;
    });
  }

  void showDayMenu(BuildContext context, details, day) {
    if (day != 0) {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          MediaQuery.of(context).size.width - details.globalPosition.dx,
          MediaQuery.of(context).size.height - details.globalPosition.dy,
        ),
        items: [
          PopupMenuItem<int>(
            value: 1,
            child: Text('Option 1 for $day'),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Text('Option 2 for $day'),
          ),
        ],
        elevation: 8.0,
      ).then((value) {
        // Обработка выбора опции
        if (value != null) {
          // Ваш код обработки выбранной опции
          print('Selected option: $value for day $day');
        }
      });
    }
  }

  List<List<int>> generateMonthMatrix() {
    // Получаем матрицу календаря для текущего месяца
    return List<List<int>>.generate(6, (row) {
      return List<int>.generate(7, (col) {
        final firstDayOfMonth = DateTime(currentYear, currentMonth, 1);
        final offset = firstDayOfMonth.weekday - 1;
        final dayOfMonth = row * 7 + col + 1 - offset;

        return (dayOfMonth > 0 &&
            dayOfMonth <= daysInMonth(currentMonth, currentYear))
            ? dayOfMonth
            : 0;
      });
    });
  }

  int daysInMonth(int month, int year) {
    final date = DateTime(year, month + 1, 0);
    return date.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getMonthLabel(),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => prevMonth(),
                    child: Text('Предыдущий месяц'),
                  ),
                  ElevatedButton(
                    onPressed: () => nextMonth(),
                    child: Text('Следующий месяц'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Table(
                defaultColumnWidth: FixedColumnWidth(50),
                children: generateMonthMatrix().map((row) {
                  return TableRow(
                    children: row.map((day) {
                      return CalendarDayButton(
                        dayNumber: day,
                        onDayClick: (details) => onDayClick(day, details as LongPressStartDetails),

                        currentMonth: currentMonth,
                        currentYear: currentYear,
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarDayButton extends StatelessWidget {
  final int dayNumber;
  final Function(LongPressStartDetails) onDayClick;
  final int currentMonth;
  final int currentYear;

  CalendarDayButton({
    required this.dayNumber,
    required this.onDayClick,
    required this.currentMonth,
    required this.currentYear,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {},
      child: GestureDetector(
        onLongPressStart: (details) => onDayClick(details),
        child: Container(
          height: 60,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                    color: (dayNumber != 0) ? Colors.yellow[300] : Colors.white,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(dayNumber != 0 ? 'B Shift' : '', textAlign: TextAlign.center,),)
                ),
              ),
              Positioned.fill(
                child: Container(

                  margin: EdgeInsets.only(top: 30),
                  color: (dayNumber != 0) ? Colors.blue[300] : Colors.white,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(dayNumber != 0 ? 'A Shift' : ''),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(dayNumber != 0 ? '$dayNumber' : '', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


