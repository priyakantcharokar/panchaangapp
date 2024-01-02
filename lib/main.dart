import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this line for date formatting

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panchaang for the day',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          //backgroundColor: Colors.purple,
          titleTextStyle: TextStyle(color: Colors.black, fontFamily: 'Lato', fontSize: 20), // Updated line
        ),
        // Set the default font family to Lato
        fontFamily: 'Lato',
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
    "Abhijit Muhurat": "Abhijit Muhurat is considered a very auspicious time period in Vedic Astrology. Unlike other inauspicious Kaals, this Muhurat is believed to be highly favorable for starting new endeavors, making important decisions, or conducting auspicious ceremonies. It typically occurs around midday and lasts for around 48 minutes. The exact timing of Abhijit Muhurat can vary slightly based on geographical location and day-to-day celestial movements.",
    "Rahu Kaal": "Rahu Kaal is an inauspicious period in Vedic Astrology. It is believed that this time is under the influence of Rahu, the malefic planetary aspect in Hindu mythology. Starting any new venture, important tasks, or auspicious activities during this time is generally avoided. The duration of Rahu Kaal lasts for approximately 90 minutes every day, but its occurrence varies throughout the week.",
    "Gulika Kaal": "Gulika Kaal, also known as Gulik, is another inauspicious time period determined by Vedic Astrology. Similar to Rahu Kaal, it is considered unfavorable for initiating any new business, trades, or important deals. This period is believed to be governed by Saturn's son, Gulika, and is thought to bring challenges or obstacles. The timing of Gulika Kaal changes daily and lasts for around 90 minutes.",
    "Yamaganda Kaal": "Yamaganda Kaal is an inauspicious period that occurs every day for a duration of approximately 90 minutes. It is believed to be ruled by Yama, the god of death according to Hindu mythology. It is advised to avoid starting any auspicious work or important activities during this time, as it is considered to bring failure or setbacks.",
    // Add more Kaals and their descriptions here
  };

  DateTime _selectedDate = DateTime.now();
  String _formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()); // Format including the day of the week


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
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0), // Adjust the padding as needed
              child: Image.asset(
                'assets/images/logo.png',  // Path to your logo image
                height: 40,  // Adjust the size as needed
              ),
            ),
            Text('Panchaang'),
          ],
        ),
        //backgroundColor: Colors.purple,
      )
      ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20), // Add padding using SizedBox
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
                    _formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(picked); // Format with full month name
                  });
                }
              },
              child: Text('Select Date'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                foregroundColor: Colors.white, // Text color
              ),
            ),
            SizedBox(height: 20),
            Text(
              _formattedDate,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: kaals.length,
                itemBuilder: (context, index) {
                  String key = kaals.keys.elementAt(index);
                  Color textColor;

                  // Change text color based on the key
                  if (key == 'Rahu Kaal' || key == 'Gulika Kaal' || key == 'Yamaganda Kaal') {
                    textColor = Colors.red; // Set text color to red for specific Kaals
                  } else {
                    textColor = Colors.green; // Set text color to green for other Kaals
                  }
                  return ListTile(
                    // leading: Icon(Icons.lock_clock_rounded), // Icon for the Kaal
                    leading: IconButton(
                      icon: Icon(Icons.question_mark_outlined),
                      iconSize: 20.0, // Adjust the size as needed, 20.0 is an example for a smaller icon
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(key,
                                textAlign: TextAlign.center),
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
                    title: Text(key,
                      style: TextStyle(
                        color: textColor, // Change this to your desired color
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(kaals[key]!,
                          style: TextStyle(color: textColor)),

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
