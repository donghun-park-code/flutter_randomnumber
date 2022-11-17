import 'package:flutter/material.dart';
// 중복되는 코드를 한번만 쓸 수 있게 하기
class number_row extends StatelessWidget {
  final int number;
  const number_row({required this.number,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: number
          .toString()
          .split('')
          .map(
            (e) => Image.asset(
          'asset/img/$e.png',
          width: 50,
          height: 70,
        ),
      )
          .toList(),
    );
  }
}
