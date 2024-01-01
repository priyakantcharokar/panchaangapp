import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this line for date formatting

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kaal Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KaalCalculator(),
    );
  }
}

class KaalCalculator extends StatefulWidget {
  @override
  _KaalCalculatorState createState() => _KaalCalculatorState();
}

class _KaalCalculatorState extends State<KaalCalculator> {
  final Map<String, String> kaalDescriptions = {
    "Rahu Kaal": "Inauspicious time period which is avoided for any auspicious work. Occurs for about 1.5 hours every day.",
    "Gulika Kaal": "Considered inauspicious, it is believed that any activity initiated during this period will face obstacles.",
    "Yamaganda Kaal": "Another inauspicious period, similar to Rahu Kaal, avoided for starting new ventures.",
    "Abhijit Muhurat": "Very auspicious time of the day. It is considered good for new beginnings and lasts for about 48 minutes around midday.",
    // Add more Kaals and their descriptions here
  };

  DateTime _selectedDate = DateTime.now();

  Map<String, String> calculateKaals(DateTime date) {
    // Placeholder logic for Kaal calculations
    // In a real application, replace this with actual astrological calculations

    // Example: Assume each Kaal lasts for a certain duration and starts at different times based on the weekday
    final weekdays = [
      'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
    ];
    final rahuKaalStartHours = [8, 7.5, 6, 10.5, 9, 10.5, 9]; // Example start times for Rahu Kaal
    final gulikaKaalStartHours = [6.5, 9, 7.5, 6, 10.5, 8, 10.5]; // Example start times for Gulika Kaal
    final yamagandaKaalStartHours = [10.5, 6, 9, 7.5, 6, 8, 7.5]; // Example start times for Yamaganda Kaal
    // Add more Kaals here with their respective start times

    int weekdayIndex = date.weekday % 7; // Dart's DateTime.weekday is 1-based, and Monday is 1

    // Calculate start and end times for each Kaal
    double rahuKaalStart = rahuKaalStartHours[weekdayIndex].toDouble();
    double rahuKaalEnd = rahuKaalStart + 1.5; // Rahu Kaal lasts for 1.5 hours

    double gulikaKaalStart = gulikaKaalStartHours[weekdayIndex].toDouble();
    double gulikaKaalEnd = gulikaKaalStart + 1.5; // Gulika Kaal lasts for 1.5 hours

    double yamagandaKaalStart = yamagandaKaalStartHours[weekdayIndex].toDouble();
    double yamagandaKaalEnd = yamagandaKaalStart + 1.5; // Yamaganda Kaal lasts for 1.5 hours

    // Simplified approach for Abhijit Muhurat calculation
    // Assuming standard day duration from 6:00 AM to 6:00 PM
    DateTime sunrise = DateTime(date.year, date.month, date.day, 6, 0); // 6:00 AM
    DateTime sunset = DateTime(date.year, date.month, date.day, 18, 0); // 6:00 PM

    Duration dayDuration = sunset.difference(sunrise);
    Duration midDayDuration = Duration(minutes: (dayDuration.inMinutes / 2).round());
    DateTime midDay = sunrise.add(midDayDuration);
    DateTime abhijitStart = midDay.subtract(Duration(minutes: 24));
    DateTime abhijitEnd = midDay.add(Duration(minutes: 24));

    String abhijitMuhuratTimeString = formatDateTime(abhijitStart) + " - " + formatDateTime(abhijitEnd);


    // Format the times in a readable format
    String rahuKaalTimeString = formatKaalTime(rahuKaalStart) + " - " + formatKaalTime(rahuKaalEnd);
    String gulikaKaalTimeString = formatKaalTime(gulikaKaalStart) + " - " + formatKaalTime(gulikaKaalEnd);
    String yamagandaKaalTimeString = formatKaalTime(yamagandaKaalStart) + " - " + formatKaalTime(yamagandaKaalEnd);

    return {
      "Rahu Kaal": rahuKaalTimeString,
      "Gulika Kaal": gulikaKaalTimeString,
      "Yamaganda Kaal": yamagandaKaalTimeString,
      "Abhijit Muhurat": abhijitMuhuratTimeString
      // Add more Kaals here
    };
  }

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
  String formatKaalTime(double time) {
    int hours = time.toInt();
    int minutes = ((time - hours) * 60).toInt();
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
  }


  @override
  Widget build(BuildContext context) {
    Map<String, String> kaals = calculateKaals(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kaal Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            Text(
              DateFormat('yyyy-MM-dd').format(_selectedDate),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: kaals.length,
                itemBuilder: (context, index) {
                  String key = kaals.keys.elementAt(index);
                  return ListTile(
                    leading: Icon(Icons.access_time), // Icon for the Kaal
                    title: Text(key),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(kaals[key]!),
                        IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(key),
                                  content: Text(kaalDescriptions[key] ?? "No description available."),
                                  actions: [
                                    TextButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
