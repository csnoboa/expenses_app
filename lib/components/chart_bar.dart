import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double percentage;
  final double value;
  final String label;

  const ChartBar({
    this.percentage,
    this.value,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrainsts) {
        return Column(
          children: [
            Container(
              height: constrainsts.maxHeight * 0.15,
              child: FittedBox(
                child: Text('${value.toStringAsFixed(2)}'),
              ),
            ),
            SizedBox(height: constrainsts.maxHeight * 0.05),
            Container(
              height: constrainsts.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                      heightFactor: percentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: constrainsts.maxHeight * 0.05),
            Container(
              height: constrainsts.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
