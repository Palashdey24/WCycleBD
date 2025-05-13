import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/reusable_contianer_services_btn.dart';

final fontHelpers = FontHelper();

class BottomFloatingWidgets extends StatelessWidget {
  const BottomFloatingWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: Container(
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  radius: 5,
                  tileMode: TileMode.repeated,
                  center: Alignment.bottomRight,
                  colors: [Colors.blueGrey, Colors.white],
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.indigo,
                size: 28,
              ),
            ),
          ),
          const Gap(csGap),
          const ReusableContianerServicesBtn(btntext: "Request Now"),
        ],
      ),
    );
  }
}
