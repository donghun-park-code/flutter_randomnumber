import 'dart:math';

import 'package:flutter/material.dart';
import 'package:randomnumber/component/number_row.dart';
import 'package:randomnumber/screen/setting_screen.dart';
import 'package:randomnumber/style/color.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int maxNumber = 1000;
  List<int> randomnumber = [
    123,
    456,
    789,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(
                onPressed: onSettingsPop,
              ),
              _body(
                randomnumber: randomnumber,
              ),
              _footer(onpressed: onRandomNumberGenerate),
            ],
          ),
        ),
      ),
    );
  }

  void onSettingsPop() async {
    // list - add
    // [HomeScreen() => SettingScreen()]
    // navigator 쓸때 받아오는 값은 null값이 올수 있다고 생각하고 생각해야한다.
    final int? result = await Navigator.of(context).push<int>( // 아무것도 안돌려줄수도있어서(null) int?
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingScreen(
            maxNumber: maxNumber,
          );
        },
      ),
    );
    if(result != null){
      setState(() {
        maxNumber = result;
      });
    }
  }

  void onRandomNumberGenerate() {
    final rand = Random(); // 랜덤 숫자
    final Set<int> newNumbers = {}; // 중복되는 값을 만들지 않기위해 set로 바꿈
    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);
      newNumbers.add(number);
    }
    setState(() {
      randomnumber = newNumbers.toList();
    });
  }
}

class _header extends StatelessWidget {
  final VoidCallback onPressed;
  const _header({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '추첨 번호 생성기',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        ),
      ],
    );
  }
}

class _body extends StatelessWidget {
  final List<int> randomnumber;
  const _body({required this.randomnumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomnumber
            .asMap()
            .entries
            .map(
              (x) => Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                child: number_row(number: x.value,),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _footer extends StatelessWidget {
  final VoidCallback onpressed;
  const _footer({required this.onpressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          onPressed: onpressed,
          child: Text('생성하기'),
        ));
  }
}
