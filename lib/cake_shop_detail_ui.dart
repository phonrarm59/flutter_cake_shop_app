// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_cake_shop_app/models/case_shop.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CakeShopDetailUi extends StatefulWidget {
  //สร้างตัวแปรรับข้อมูลที่ส่งมาจากอีกหน้าหนึ่ง
  CakeShop? cakeShop;

  //เอาตัวแปรที่สร้างมารับค่าที่ส่งมา
  CakeShopDetailUi({super.key, this.cakeShop});

  @override
  State<CakeShopDetailUi> createState() => _CakeShopDetailUiState();
}

class _CakeShopDetailUiState extends State<CakeShopDetailUi> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  //เมมธอด เว็บ เฟส google map
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ส่วนของ AppBar
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.cakeShop!.name!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      //ส่วนของ Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(30.0),
          child: Center(
            child: Column(
              children: [
                //ส่วนของรูปภาพรูปที่1
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/${widget.cakeShop!.image1!}',
                    width: 140,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                //ส่วนของรูปภาพรูปที่2และ3
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/${widget.cakeShop!.image2!}',
                        width: 140,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/${widget.cakeShop!.image3!}',
                        width: 140,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                //ส่วนขื่อร้าน
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    'ชื่อร้าน 📛',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    widget.cakeShop!.name!,
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    'รายละเอียดของร้าน 💩',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    widget.cakeShop!.description!,
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    'ที่อยู่ของร้าน 🗺️',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    widget.cakeShop!.address!,
                  ),
                ),
                SizedBox(height: 20),
                //ส่วนเบอร์โทรร้าน
                ElevatedButton(
                  onPressed: () {
                    _makePhoneCall(widget.cakeShop!.phone!);
                  },
                  child: Text(
                    '📞 ${widget.cakeShop!.phone!}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
                //ส่วนแสดงชื่อเว๋บและเปืดเว็บได้
                SizedBox(height: 20),
                ListTile(
                  onTap: (){
                    _launchInBrowser(Uri.parse(widget.cakeShop!.website!));
                  },
                  leading: Icon(
                    FontAwesomeIcons.globe,
                    color: Colors.red,
                  ),
                  title: Text(
                    widget.cakeShop!.website!,
                  ),
                  trailing: Icon(
                    Icons.link,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  onTap: (){
                    _launchInBrowser(Uri.parse(widget.cakeShop!.facebook!));
                  },
                  leading: Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.red,
                  ),
                  title: Text(
                    widget.cakeShop!.facebook!,
                  ),
                  trailing: Icon(
                    Icons.link,
                    color: Colors.red,
                  ),
                ),
                //ส่วนของแผนที่และเปิดgooglo map ได้
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400.0,
                  child: FlutterMap(                    
                    options: MapOptions(
                      //กำหนดตำแหน่งที่แสดงบนแผนที่  *****
                      initialCenter: LatLng(
                        double.parse(widget.cakeShop!.latitude!),
                        double.parse(widget.cakeShop!.longitude!),
                       ),
                      //ระยะ Zoom บนแผนที่
                      initialZoom: 20.0,
                    ),
                    //วาดแผนที่ (ไม่ต้องแก้อะไร
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.google.com/vt/lyrs=m,h&x={x}&y={y}&z={z}&hl=ar-MA&gl=MA',
                            subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                        userAgentPackageName: 'com.example.app',
                      ),
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution(
                            'OpenStreetMap contributors',
                            onTap: () {
                              launchUrl(
                                Uri.parse('https://openstreetmap.org/copyright'),
                              );
                            },
                          ),
                        ],
                      ),
                      //ส่วนของ Marker
                      MarkerLayer(
                        markers: [
                          Marker(
                            //กำหนดตำแหน่ง Marker ที่แสดงบนแผนที่  *****
                            point: LatLng(
                              double.parse(widget.cakeShop!.latitude!),
                              double.parse(widget.cakeShop!.longitude!),
                             ),
                            child: InkWell(
                              onTap: () {
                                //เปิด Google Maps โดยต้องกำหนดตำแหน่งที่แสดงบนแผนที่  *****
                                String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${ widget.cakeShop!.latitude!},${widget.cakeShop!.longitude! }';
                                _launchInBrowser(Uri.parse(googleMapsUrl));
                              },
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
