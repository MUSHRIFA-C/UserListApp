import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userlist/custom_widgets/custom_text.dart';
import 'package:userlist/utilities/constants.dart';

class Detailpage extends StatefulWidget {
  final String? name;
  final String? email;
  final String? phone;
  final String? street;
  final String? city;
  final String? zipcode;
  final String? website;
  final String? cname;
  final String? catchPhrase;
  final String? bs;
  final String? lat;
  final String? lng;

  Detailpage({
    this.name,
    this.email,
    this.phone,
    this.street,
    this.city,
    this.zipcode,
    this.website,
    this.cname,
    this.catchPhrase,
    this.bs,
    this.lat,
    this.lng,
  });

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  Future<void> onLocationButtonPressed() async {
    final double lat = double.parse(widget.lat ?? '0.0');
    final double lng = double.parse(widget.lng ?? '0.0');
    final mapUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Could not launch $mapUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal.shade800),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 26, left: 13, right: 13, bottom: 20),
                  child: widget.name != null
                      ? Column(
                    children: [
                      CustomText(
                        text: 'Name : ',
                        value: widget.name,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: 'Email : ',
                        value: widget.email,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: 'Address : ',
                        value: '${widget.street}, ${widget.city}, ${widget.zipcode}',
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: 'Phone Number : ',
                        value: widget.phone,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: 'Website : ',
                        value: widget.website,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: 'Company : ',
                        value: '${widget.cname}, ${widget.catchPhrase}, ${widget.bs}',
                      ),
                      const SizedBox(height: 25),
                      InkWell(
                        onTap: () {
                          onLocationButtonPressed();
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Constants.primaryColor,
                          ),
                          child: const Center(
                            child: Text(
                              'Location',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
