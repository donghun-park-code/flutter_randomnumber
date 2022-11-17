import 'package:flutter/material.dart';
import 'package:randomnumber/component/number_row.dart';
import 'package:randomnumber/style/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;
  const SettingScreen({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;
  @override
  void initState() { //settingscreenstate가 생성되는 순간 실행될때 불려간다. =>
    //  그 순간에 맥스넘버를 변경해주면 적용됨
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Body(maxNumber: maxNumber),
                _footer(
                  onSildeChaged: onSilderChaged,
                  maxNumber: maxNumber,
                  onButtonPressed: onButtonPressed,
                )
              ],
            ),
          ),
        ));
  }

  void onSilderChaged(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onButtonPressed() {
    Navigator.of(context)
        .pop(maxNumber.toInt()); //  pop=뒤로가기 값을 전달해주려면 pop에 값을 넣으면됨
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;
  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: number_row(number: maxNumber.toInt(),),
    );
  }
}

class _footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onSildeChaged;
  final VoidCallback onButtonPressed;
  const _footer(
      {required this.onSildeChaged,
      required this.maxNumber,
      required this.onButtonPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
            // 최소값 최대값 정해주는 바
            value: maxNumber,
            min: 1000,
            max: 99999,
            onChanged: onSildeChaged), //
        ElevatedButton(
          onPressed: onButtonPressed,
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          child: Text('저장!'),
        ),
      ],
    );
  }
}
