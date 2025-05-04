import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/file_pick.dart';
import 'package:wcycle_bd/helper/font_helper.dart';

final fontHelper = FontHelper();

class OrganizationDocs extends StatefulWidget {
  const OrganizationDocs({super.key, required this.onDocs});
  final void Function(String? name, File? file) onDocs;

  @override
  State<OrganizationDocs> createState() => _OrganizationDocsState();
}

class _OrganizationDocsState extends State<OrganizationDocs> {
  String? fileName;
  File? filePath;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              fileName ?? "Upload Docs: ",
              style:
                  fontHelper.bodyMedium(context).copyWith(color: Colors.green),
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
                onPressed: () async {
                  final fileNames = await FilePick.uploadDoc(context, ['pdf']);
                  widget.onDocs(fileNames?[0], fileNames?[1]);
                  setState(() {
                    fileName = fileNames?[0];
                  });
                },
                child: const FaIcon(
                  FontAwesomeIcons.solidEnvelopeOpen,
                  color: Colors.orange,
                )),
          ),
        ],
      ),
    );
  }
}
