import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CountDownTimerPage extends StatefulWidget {
  const CountDownTimerPage({super.key});

  @override
  CountDownTimerPageState createState() => CountDownTimerPageState();
}

class CountDownTimerPageState extends State<CountDownTimerPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(
      0,
    ),
    onChange: (value) => debugPrint('onChange $value'),
    onChangeRawSecond: (value) => debugPrint('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => debugPrint('onChangeRawMinute $value'),
    onStopped: () {
      debugPrint('onStopped');
    },
    onEnded: () {
      debugPrint('onEnded');
    },
  );

  final _minuteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen(
      (value) =>
          debugPrint('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
    _minuteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data!;
                  final displayTime =
                      StopWatchTimer.getDisplayTime(value, hours: false);
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      displayTime,
                      style: const TextStyle(
                        fontSize: 40,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _minuteController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Digite os minutos',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  final minutes = int.tryParse(_minuteController.text);
                  if (minutes != null) {
                    _stopWatchTimer.onResetTimer();
                    _stopWatchTimer.setPresetMinuteTime(
                      minutes,
                    );
                    _stopWatchTimer.onStartTimer();
                    _minuteController.clear();
                  }
                  if (minutes == null) {
                    _stopWatchTimer.onStartTimer();
                  }
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.play_arrow_outlined,
                        size: 35,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'Start',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.blue,
                          ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: _stopWatchTimer.onStopTimer,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.orange,
                          width: 2.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.stop,
                        size: 35,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      'Stop',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.orange,
                          ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: _stopWatchTimer.onResetTimer,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.restart_alt_outlined,
                        size: 35,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      'Reset',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.red,
                          ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => _stopWatchTimer.clearPresetTime(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.redAccent,
                          width: 2.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.restore,
                        size: 35,
                        color: Colors.redAccent,
                      ),
                    ),
                    Text(
                      'Zerar',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.redAccent,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
