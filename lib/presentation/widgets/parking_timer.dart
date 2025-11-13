import 'dart:async';
import 'package:flutter/material.dart';

class ParkingTimer extends StatefulWidget {
  final DateTime date;
  const ParkingTimer({Key? key,required this.date}) : super(key: key);

  @override
  State<ParkingTimer> createState() => _ParkingTimerState();
}

class _ParkingTimerState extends State<ParkingTimer> {
  late DateTime startTime;
  late Timer _timer;
  Duration difference = Duration.zero;

  @override
  void initState() {
    super.initState();
    startTime = widget.date;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateDifference(),
    );
  }

  void _updateDifference() {
    final now = DateTime.now();
    setState(() {
      difference = now.difference(startTime);
    });
  }

  List<String> _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = twoDigits(d.inDays);
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));

    return [days.toString(), hours, minutes, seconds];
  }

  final List<String> timeLabels = ["Kun", "Soat", "Daqiqa", "Soniya"];
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget timeContainer(String timeUnit, String timeLabel) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              timeUnit,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
        Text(timeLabel, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,

        itemBuilder: (context, index) {
          return timeContainer(
            _formatDuration(difference)[index],
            timeLabels[index],
          );
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              ":",
              style: TextStyle(fontSize: 22, color: Colors.grey),
            ),
          );
        },
        itemCount: 4,
      ),
    );
  }
}
