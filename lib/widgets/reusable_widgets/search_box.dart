import 'package:flutter/material.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';

final api = Apis();

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 15,
          child: BackCustomButton(),
        ),
        Expanded(
          flex: 85,
          child: SizedBox(
            width: api.deviceWidth(context) * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueAccent,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Search for course',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.indigo,
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: Colors.grey,
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: Colors.blueGrey),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
