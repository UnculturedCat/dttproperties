import 'package:dttproperties/shared.dart';
import 'package:flutter/material.dart';
import 'package:dttproperties/PropertyWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff7f7f7),
        body: Container(
          padding: standardPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DTT REAL ESTATE",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search for a home",
                    hintStyle: Theme.of(context).textTheme.titleSmall,
                    filled: true,
                    fillColor: inactiveColor,
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PropertyWidget(),
                      PropertyWidget(),
                      PropertyWidget(),
                      PropertyWidget(),
                      PropertyWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
