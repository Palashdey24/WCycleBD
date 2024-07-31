import 'package:flutter/material.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/widgets/loading_widget.dart';

final api = Apis();
final fontHelper = FontHelper();

class WasteMaterialChip extends StatefulWidget {
  const WasteMaterialChip(
      {super.key,
      required this.wasteMatFn,
      required this.fsCollection,
      required this.fsField});
  final void Function(List<String> waste) wasteMatFn;
  final String fsCollection;
  final String fsField;

  @override
  State<WasteMaterialChip> createState() => _WasteMaterialChipState();
}

class _WasteMaterialChipState extends State<WasteMaterialChip> {
  List<String> selectWasteMaterial = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: api.fireStore.collection(widget.fsCollection).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Some error Occured ${snapshot.hasError}"),
          );
        }
        List<String> wasteMaterials = [];

        if (!snapshot.hasData) {
          return const Center(
            child: SizedBox(width: 30, height: 30, child: LoadingWidgets()),
          );
        } else {
          final wasteMatSnapshot = snapshot.data?.docs.toList();

          if (wasteMatSnapshot != null) {
            for (var wasteMat in wasteMatSnapshot) {
              wasteMaterials.add(wasteMat[widget.fsField]);
            }
          }

          return Wrap(
            runSpacing: normalGap,
            spacing: csGap,
            children: [
              for (var wasmat in wasteMaterials)
                ChoiceChip(
                  backgroundColor: Colors.grey,
                  selectedColor: Colors.lime,
                  label: Text(
                    wasmat.toUpperCase(),
                    style: fontHelper
                        .bodyMedium(context)
                        .copyWith(color: Colors.white),
                  ),
                  onSelected: (value) {
                    setState(() {
                      if (selectWasteMaterial.contains(wasmat)) {
                        selectWasteMaterial.remove(wasmat);
                      } else {
                        selectWasteMaterial.add(wasmat);
                      }
                    });
                    widget.wasteMatFn(selectWasteMaterial);
                    return;
                  },
                  selected: selectWasteMaterial.contains(wasmat),
                ),
            ],
          );
        }
      },
    );
  }
}
