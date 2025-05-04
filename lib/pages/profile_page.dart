import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/provider/user_fs_provider.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/profile_page_kpi_data.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFs = ref.watch(userFSProvider);
    return Column(
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.all(csGap),
            color: Colors.black12,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              children: [
                ProfilePageKpiData(
                  tittle: "Name",
                  kpiName: userFs.userName,
                  iconColor: Colors.orange,
                  iconData: FontAwesomeIcons.diamond,
                ),
                ProfilePageKpiData(
                  tittle: "Email Address",
                  kpiName: userFs.email,
                  iconColor: Colors.yellow,
                  iconData: FontAwesomeIcons.envelopeOpen,
                ),
                ProfilePageKpiData(
                  tittle: "Number",
                  kpiName: userFs.phoneNumber,
                  iconColor: Colors.green,
                  iconData: FontAwesomeIcons.squarePhoneFlip,
                ),
                ProfilePageKpiData(
                  tittle: "BirthDate",
                  kpiName: userFs.birthDate,
                  iconColor: Colors.purple,
                  iconData: FontAwesomeIcons.cakeCandles,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
