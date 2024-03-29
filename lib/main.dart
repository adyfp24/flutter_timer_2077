import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: TimerApp(),
    );
  }
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  TextEditingController _controller = TextEditingController();
  late Timer _timer;
  int _timeLeft = 0;
  bool _isRunning = false;

  void _startTimer(int minutes) {
    _timeLeft = minutes * 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
          _isRunning = false;
        }
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
      _isRunning = false;
    }
  }

  void _restartTimer() {
    _stopTimer();
    _startTimer(int.parse(_controller.text));
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            Text(
              'NIM: 222410102077',
            ),
            Text(
              'Nama: Ady Firdaus Pratama',
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Masukkan waktu (menit)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isRunning = true;
                      _startTimer(int.parse(_controller.text));
                    });
                  },
                  child: Text('Mulai'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isRunning = false;
                      _stopTimer();
                    });
                  },
                  child: Text('Berhenti'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isRunning = true;
                      _restartTimer();
                    });
                  },
                  child: Text('Mulai Ulang'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Sisa waktu: ${(_timeLeft ~/ 60).toString().padLeft(2, '0')}:${(_timeLeft % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
