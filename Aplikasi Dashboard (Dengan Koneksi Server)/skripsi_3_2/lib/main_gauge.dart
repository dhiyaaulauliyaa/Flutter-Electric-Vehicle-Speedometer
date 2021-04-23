import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MainGauge extends StatefulWidget {
  final BoxConstraints constraints;
  final BuildContext context;

  final double screenWidth;
  final double screenHeight;

  final double speed;
  final double rpm;
  final double temp;

  final String latitude;
  final String longitude;

  final bool connectionStatus;
  final Function connectionCallback;
  final WebSocketChannel channel;

  MainGauge({
    this.constraints,
    this.context,
    this.screenWidth,
    this.screenHeight,
    this.speed,
    this.rpm,
    this.temp,
    this.latitude,
    this.longitude,
    this.connectionStatus,
    this.connectionCallback,
    this.channel,
  });

  @override
  _MainGaugeState createState() => _MainGaugeState();
}

class _MainGaugeState extends State<MainGauge> {
//  double _rpmGauge() {
//    print(widget.rpm);
//    const int rpmMax = 16320;
//    const double rpmMid = (rpmMax * 5 / 9);
//    const double rpmWidthRatio = 0.5284375;
//    double rpmFullWidth = widget.screenWidth * rpmWidthRatio;
//    double gaugeWidth;
//
//    if (widget.rpm > rpmMax) {
//      gaugeWidth = rpmFullWidth;
//    } else if (widget.rpm > rpmMid) {
//      gaugeWidth = ((rpmFullWidth * 0.52) *
//              ((widget.rpm - rpmMid) / (rpmMax - rpmMid))) +
//          (rpmFullWidth * 0.48);
//    } else
//      gaugeWidth = (rpmFullWidth * 0.48) * (widget.rpm / (rpmMax - 4000));
//
//    print(gaugeWidth);
//    return gaugeWidth;
//  }

  //SKALA MOBIL NORMAL (0-6000 RPM)
  double _rpmGauge() {
    print(widget.rpm);
    const double rpmFirstTreshold = 3500;
    const double rpmSecondTreshold = 6000;
    const double rpmWidthRatio = 0.5284375;
    double rpmFullWidth = widget.screenWidth * rpmWidthRatio;
    double gaugeWidth;

    //RPM < 3500
    if (widget.rpm < rpmFirstTreshold) {
      gaugeWidth = (rpmFullWidth * 0.8) * (widget.rpm / rpmFirstTreshold);
    }

    //RPM < 6000
    else if (widget.rpm < rpmSecondTreshold) {
      gaugeWidth = (rpmFullWidth * 0.8) +
          ((rpmFullWidth * 0.2) *
              ((widget.rpm - rpmFirstTreshold) /
                  (rpmSecondTreshold - rpmFirstTreshold)));
    }

    //RPM > 6000
    else
      gaugeWidth = rpmFullWidth;

    return gaugeWidth;
  }

  double _torqueGauge() {
    const int rpmMax = 16320;
    const double torqueWidthRatio = 0.2106;
    double torqueFullWidth = widget.screenWidth * torqueWidthRatio;
    double torqueLeft = 1 - (widget.rpm / rpmMax);
    return torqueFullWidth * torqueLeft;
  }

  double _tempGauge() {
    const double lowestTemp = -40;
    const double highestTemp = 215;
    const double tempRange = highestTemp - lowestTemp;
    double tempGauge;

    //Normalisasi temperature
    tempGauge = ((widget.temp - lowestTemp) / tempRange);
    print("AAAAAAAAAAAAAAA $tempGauge");

    const double tempLowestRatio = 0.24706614583;
    const double tempHighestRatio = 0.385474479167;

    double tempLowestWidth = tempLowestRatio * widget.screenWidth;
    double tempHighestWidth = tempHighestRatio * widget.screenWidth;
    double tempWidth = tempHighestWidth - tempLowestWidth;

    return tempLowestWidth + (tempGauge * tempWidth);
  }

  String _powerNum() {
    const int rpmMax = 16320;
    double power = 100 * widget.rpm / rpmMax;
    String x = (100 - power).toStringAsFixed(0);
    debugPrint('Torque Left: $x%');
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //=============== BACKGROUND ===============//
        Positioned(
            top: 0,
            child: Container(
              height: widget.screenHeight,
              width: widget.screenWidth,
              color: Color.fromRGBO(0, 0, 10, 1),
            )),

        //=============== METER OFF ===============//
        Positioned(
          top: 0,
          child: Image.asset(
            'assets/meter/meterOff.png',
            width: widget.screenWidth,
          ),
        ),

        //=============== RPM ON ===============//
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox.fromSize(
            size: Size(_rpmGauge(), widget.screenHeight * 0.618),
            child: Container(
              child: Image.asset(
                'assets/meter/meterOn.png',
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ),

        //=============== POWER ON ===============//
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox.fromSize(
            size: Size(_torqueGauge(), widget.screenHeight * 0.618),
            child: Container(
              child: Image.asset(
                'assets/meter/meterOn.png',
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerRight,
              ),
            ),
          ),
        ),

        //=============== TEMP ===============//
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox.fromSize(
            size: Size(_tempGauge(), widget.screenHeight * 0.618),
            child: Container(
              child: Image.asset(
                'assets/meter/indicatorOn.png',
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ),

        //=============== UPPER ===============//
        Positioned(
          top: 0,
          child: Opacity(
            opacity: 1,
            child: Image.asset(
              'assets/meter/upperMeter.png',
              width: widget.constraints.maxWidth,
            ),
          ),
        ),

        //=============== SPEED ===============//
        Positioned(
          top: widget.screenHeight * 0.231,
          child: Container(
            height: widget.screenHeight * 0.165,
            width: widget.screenWidth,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
              child: Text(
                "${widget.speed.toStringAsFixed(0)}",
                style: TextStyle(
                  fontFamily: "Krunch",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        //=============== RPM NUM ===============//
        Positioned(
          top: widget.screenHeight * 0.094,
          left: widget.screenWidth * 0.537,
          child: Container(
            height: widget.screenHeight * 0.057,
            width: widget.screenWidth * 0.15,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerLeft,
              child: Text(
                "${widget.rpm.toStringAsFixed(0)}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Krunch",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        //=============== POWER NUM ===============//
        Positioned(
          top: widget.screenHeight * 0.094,
          left: widget.screenWidth * 0.675,
          child: Container(
            height: widget.screenHeight * 0.057,
            width: widget.screenWidth * 0.112,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerLeft,
              child: Text(
                _powerNum() + '%',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Krunch",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        //=============== DISCONNECT BUTTON ===============//
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: SizedBox(),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: <Widget>[],
              ),
            )
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: widget.screenHeight * 0.619,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                height: 35,
                child: connectionStatusTitle(),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(10, 10, 30, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),

        //Geolocation Echo
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Text(
                "Position:",
                style: TextStyle(
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -.3),
              ),
            )
          ],
        )
      ],
    );
  }

  //With Geolocation
  Row connectionStatusTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Text(
          "Latitude: ${widget.latitude}",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'MuseoSans',
              fontWeight: FontWeight.w500,
              letterSpacing: -.3),
        ),
        Text(
          "Logitude: ${widget.longitude}",
          style: TextStyle(
              fontFamily: 'MuseoSans',
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: -.3),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: RaisedButton(
              color: Color.fromRGBO(40, 40, 50, 1),
              textColor: Colors.white,
              child: Text("Disconnect"),
              onPressed: () {
                widget.connectionCallback(false);
                widget.channel.sink.close();
              }),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );

//  //Without Geolocation
//  Row connectionStatusTitle() {
//    String status;
//    if (widget.connectionStatus) {
//      status = "Connected";
//    }
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      children: <Widget>[
//        SizedBox(
//          width: 10,
//        ),
//        Text(
//          "STATUS: $status",
//          style: TextStyle(
//              color: Colors.white,
//              fontFamily: 'MuseoSans',
//              fontWeight: FontWeight.w500,
//              letterSpacing: -.3),
//        ),
//        Text(
//          "Speed: ${widget.speed.toStringAsFixed(0)} km/h",
//          style: TextStyle(
//              fontFamily: 'MuseoSans',
//              fontWeight: FontWeight.w500,
//              color: Colors.white,
//              letterSpacing: -.3),
//        ),
//        Text(
//          "RPM: ${widget.rpm.toStringAsFixed(0)} RPM",
//          style: TextStyle(
//              fontFamily: 'MuseoSans',
//              fontWeight: FontWeight.w500,
//              color: Colors.white,
//              letterSpacing: -.3),
//        ),
//        Text(
//          "Temp: ${widget.temp.toStringAsFixed(0)} °C",
//          style: TextStyle(
//              fontFamily: 'MuseoSans',
//              fontWeight: FontWeight.w500,
//              color: Colors.white,
//              letterSpacing: -.3),
//        ),
//        Padding(
//          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//          child: RaisedButton(
//              color: Color.fromRGBO(40, 40, 50, 1),
//              textColor: Colors.white,
//              child: Text("Disconnect"),
//              onPressed: () {
//                widget.connectionCallback(false);
//                widget.channel.sink.close();
//              }),
//        ),
//        SizedBox(
//          width: 10,
//        ),
//      ],
//    );
  }
}
