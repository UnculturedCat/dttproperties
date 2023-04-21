import 'package:dttproperties/Shared.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

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
                child: Text(
                  "Lremm oinaso incoasinocnoauscbkvidak dspofuvhbfduvnlksjac  adusbvkdvsbnvkds  ohiubdskhjvbkudsbluibvdsiu oubdsv pbnodvsubiuvdsbo dvsbioubdosiubouzdsboiubasdouidbviuzbvdsouzu  oiuobubdskvuzbouzbdsvou  oiuhbdvoisoiubokasdbuo o ubsdoiuvbo oibijdsvbohbdsikbdv obdkvhjbvadphnasdov ",
                  style: Theme.of(context).textTheme.bodyLarge,
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
                                style: Theme.of(context).textTheme.labelLarge,
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
