import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 2,
      ),
      children: List.generate(
          4,
          (index) => Container(
                decoration: BoxDecoration(
                  color: Color(0xffD8D8D8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width / 5.5),
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xffC6C6C6),
                    color: Color(0xffB3B3B3),
                  ),
                ),
              )),
    );
  }
}
