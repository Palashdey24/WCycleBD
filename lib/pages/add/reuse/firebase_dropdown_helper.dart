import 'package:flutter/material.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/widgets/loading_widget.dart';

final api = Apis();

class FirebaseDropdownHelper extends StatefulWidget {
  const FirebaseDropdownHelper(
      {super.key,
      required this.onDropdownFn,
      required this.fsCollection,
      required this.dropLevel,
      required this.dropHint,
      required this.fsField});

  final void Function(String value) onDropdownFn;
  final String fsCollection;
  final String dropLevel;
  final String dropHint;
  final String fsField;

  @override
  State<FirebaseDropdownHelper> createState() => _FirebaseDropdownHelperState();
}

class _FirebaseDropdownHelperState extends State<FirebaseDropdownHelper> {
  String? selectValue;
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
        List<DropdownMenuItem> impactItems = [];

        if (!snapshot.hasData) {
          return const Center(
            child: SizedBox(width: 30, height: 30, child: LoadingWidgets()),
          );
        } else {
          final dropSnapshot = snapshot.data?.docs.toList();
          if (dropSnapshot != null) {
            for (var dropSnapshots in dropSnapshot) {
              impactItems.add(
                DropdownMenuItem(
                  value: dropSnapshots[widget.fsField],
                  child: Text(dropSnapshots[widget.fsField]),
                ),
              );
            }
          }
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DropdownButtonFormField(
              value: selectValue,
              hint: Text(
                widget.dropHint,
                style: const TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.orangeAccent),
              //this line for DropDown Dialog background color or Radius
              dropdownColor: Colors.black,
              borderRadius: BorderRadius.circular(30),

              //Decoration refer for hint and other outer
              decoration: InputDecoration(
                  label: Text(
                    widget.dropLevel,
                    style: const TextStyle(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              items: impactItems,
              onChanged: (value) {
                widget.onDropdownFn(value);
                setState(() {
                  selectValue = value;
                });
              },
            ),
          );
        }
      },
    );
  }
}
