import 'package:dttproperties/AppManagement/Shared.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: backgroundColor,
        height: MediaQuery.of(context).size.height,
        padding: standardPagePadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: contentPadding,
                child: Text("About",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text:
                              "DTT is not your average software development company because besides technical knowledge we also have a solid marketing background. With passion, we work on a perfect mix of technology, strategy,and creativity.\nDTT was established in 2010, and in a short period we have made significant steps forward; a substantial"),
                      TextSpan(
                          text: " portfolio",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: secondaryColor)),
                      TextSpan(text: ", excellent"),
                      TextSpan(
                          text: " credentials",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: secondaryColor)),
                      TextSpan(text: ", respectable"),
                      TextSpan(
                          text: " clients",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: secondaryColor)),
                      TextSpan(
                          text: ", most importantly a competent and driven"),
                      TextSpan(
                          text: "team",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: secondaryColor)),
                      TextSpan(text: "."),
                    ],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Container(
                padding: contentPadding,
                child: Text(
                  "Design and Development",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Image.asset(
                            "assets/Images/dtt_banner/xxxhdpi/dtt_banner.png")),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(left: 30),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "by DTT\n",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              TextSpan(
                                  text: "d-tt.nl",
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      Uri dttWebsite =
                                          Uri.parse("https://www.d-tt.nl/");
                                      if (await canLaunchUrl(dttWebsite)) {
                                        launchUrl(dttWebsite);
                                      }
                                    })
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
