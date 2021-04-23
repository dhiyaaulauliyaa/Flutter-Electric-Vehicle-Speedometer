import 'package:flutter/material.dart';

class DashboardController extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final double menuNow;

  final double rpmNow;
  final double speedNow;
  final double tempNow;
  final double fuelNow;
  final double gearNow;
  final double tripTotal;
  final int passengerNow;
  final double frontCabinTempNow;
  final double rearCabinTempNow;
  final double accelerationNow;
  final double frontCabinHumidityNow;
  final double rearCabinHumidityNow;
  final double engineVibNow;
  final double frontCabinVibNow;
  final double rearCabinVibNow;

  final Function rpmUbah;
  final Function speedUbah;
  final Function tempUbah;
  final Function fuelUbah;
  final Function gearUbah;
  final Function tripUbah;
  final Function passengerIncrease;
  final Function passengerDecrease;
  final Function frontCabinTempUbah;
  final Function rearCabinTempUbah;
  final Function accelerationUbah;
  final Function frontCabinHumidityUbah;
  final Function rearCabinHumidityUbah;
  final Function engineVibUbah;
  final Function frontCabinVibUbah;
  final Function rearCabinVibUbah;

  final bool brake;
  final bool defogger;
  final bool highBeam;
  final bool lowBeam;
  final bool oil;
  final bool wiper;

  final Function brakeUbah;
  final Function defoggerUbah;
  final Function wiperUbah;
  final Function oilUbah;
  final Function highBeamUbah;

  DashboardController({
    this.screenHeight,
    this.screenWidth,
    this.menuNow,
    this.rpmNow,
    this.rpmUbah,
    this.speedNow,
    this.speedUbah,
    this.tempNow,
    this.tempUbah,
    this.fuelNow,
    this.fuelUbah,
    this.passengerNow,
    this.passengerIncrease,
    this.passengerDecrease,
    this.gearNow,
    this.gearUbah,
    this.tripTotal,
    this.tripUbah,
    this.brake,
    this.defogger,
    this.highBeam,
    this.lowBeam,
    this.oil,
    this.wiper,
    this.brakeUbah,
    this.defoggerUbah,
    this.wiperUbah,
    this.oilUbah,
    this.highBeamUbah,
    this.lowBeamUbah,
    this.frontCabinTempNow,
    this.frontCabinTempUbah,
    this.rearCabinTempNow,
    this.rearCabinTempUbah,
    this.accelerationNow,
    this.accelerationUbah,
    this.frontCabinHumidityNow,
    this.frontCabinHumidityUbah,
    this.rearCabinHumidityNow,
    this.rearCabinHumidityUbah,
    this.engineVibNow,
    this.engineVibUbah,
    this.frontCabinVibNow,
    this.frontCabinVibUbah,
    this.rearCabinVibNow,
    this.rearCabinVibUbah,
  });

  final Function lowBeamUbah;

  @override
  Widget build(BuildContext context) {
    //=============== CONTROLLER ===============//
    return Column(
      children: <Widget>[
        SizedBox(
          height: (MediaQuery.of(context).size.height * 0.619) + 45,
          width: double.infinity,
        ),

        //=============== SLIDER RPM, SPEED, & ACCELERATION ===============//
        menuNow == 0.0
            ? Row(
                children: <Widget>[
                  Expanded(child: SizedBox(), flex: 1),

                  Expanded(child: Text("Speed"), flex: 4),
                  Expanded(
                      child: Container(
                        child: Slider(
                          value: speedNow,
                          onChanged: speedUbah,
                        ),
                      ),
                      flex: 15),

                  //=============== SLIDER RPM ===============//
                  Expanded(child: Text("RPM"), flex: 3),
                  Expanded(
                      child: Slider(
                        value: rpmNow,
                        onChanged: rpmUbah,
                      ),
                      flex: 15),

                  //=============== SLIDER ACCELERATION===============//
                  Expanded(child: Text("Acceleration"), flex: 7),
                  Expanded(
                      child: Slider(
                        value: accelerationNow,
                        onChanged: accelerationUbah,
                      ),
                      flex: 15),
                ],
              )
            : SizedBox(
                height: 0.0,
              ),

        //=============== SLIDER GEAR, PASSANGER & FUEL ===============//
        menuNow == 0.0
            ? Row(
                children: <Widget>[
                  Expanded(child: SizedBox(), flex: 1),

                  //=============== SLIDER GEAR ===============//
                  Expanded(child: Text("Gear"), flex: 3),
                  Expanded(
                      child: Slider(
                        value: gearNow,
                        onChanged: gearUbah,
                      ),
                      flex: 15),

                  //=============== SLIDER TRIP ===============//
                  Expanded(child: Text("Trip"), flex: 3),
                  Expanded(
                      child: Container(
                        child: Slider(
                          value: tripTotal,
                          onChanged: tripUbah,
                        ),
                      ),
                      flex: 15),

                  //=============== SLIDER FUEL ===============//
                  Expanded(child: Text("Fuel"), flex: 3),
                  Expanded(
                      child: Container(
                        child: Slider(
                          value: fuelNow,
                          onChanged: fuelUbah,
                        ),
                      ),
                      flex: 15),
                ],
              )
            : SizedBox(
                height: 0.0,
              ),

        //=============== MENU SWITCHER ===============//
        menuNow == 0.0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //=============== HIGHBEAM ===============//
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text("Highbeam"),
                      ),
                      Container(
                        height: screenHeight * 0.0607638888888891,
                        child: Switch(
                          value: highBeam,
                          onChanged: highBeamUbah,
                        ),
                      )
                    ],
                  ),

                  //=============== LOWBEAM ===============//
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text("Lowbeam"),
                      ),
                      Container(
                        height: screenHeight * 0.0607638888888891,
                        child: Switch(
                          value: lowBeam,
                          onChanged: lowBeamUbah,
                        ),
                      )
                    ],
                  ),

                  //=============== BRAKE ===============//
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text("Brake"),
                      ),
                      Container(
                        height: screenHeight * 0.0607638888888891,
                        child: Switch(
                          value: brake,
                          onChanged: brakeUbah,
                        ),
                      )
                    ],
                  ),

                  //=============== PASSENGER ===============//
                  Column(
                    children: <Widget>[
                      Text("Passenger"),
                      SizedBox(
                        height: screenHeight * 0.0121527777777778,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox.fromSize(
                            size: Size.square(
                                screenHeight * 0.0121527777777778 * 5),
                            child: FloatingActionButton(
                              onPressed: passengerIncrease,
                              tooltip: 'Increment',
                              child: Icon(
                                Icons.add,
                                size: screenHeight * 0.0121527777777778 * 3,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenHeight * 0.0121527777777778,
                          ),
                          SizedBox.fromSize(
                            size: Size.square(
                                screenHeight * 0.0121527777777778 * 5),
                            child: FloatingActionButton(
                              onPressed: passengerDecrease,
                              tooltip: 'Increment',
                              child: Icon(
                                Icons.remove,
                                size: screenHeight * 0.0121527777777778 * 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //=============== DEFOGGER ===============//
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text("Defogger"),
                      ),
                      Container(
                        height: screenHeight * 0.0607638888888891,
                        child: Switch(
                          value: defogger,
                          onChanged: defoggerUbah,
                        ),
                      )
                    ],
                  ),

                  //=============== WIPER ===============//
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text("Wiper"),
                      ),
                      Container(
                        height: screenHeight * 0.0607638888888891,
                        child: Switch(
                          value: wiper,
                          onChanged: wiperUbah,
                        ),
                      )
                    ],
                  ),

                  //=============== OIL ===============//
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text("Oil"),
                      ),
                      Container(
                        height: screenHeight * 0.0607638888888891,
                        child: Switch(
                          value: oil,
                          onChanged: oilUbah,
                        ),
                      )
                    ],
                  ),
                ],
              )
            : SizedBox(
                height: 0.0,
              ),

        //=============== SLIDER TEMP ===============//
        menuNow == 25.0
            ? Row(
                children: <Widget>[
                  Expanded(child: SizedBox(), flex: 1),

                  //=============== ENGINE ===============//
                  Expanded(
                      child: Text(
                        "Engine Temperature",
                        style: TextStyle(fontSize: 12),
                      ),
                      flex: 8),
                  Expanded(
                      child: Slider(
                        value: tempNow,
                        onChanged: tempUbah,
                      ),
                      flex: 18),

                  //=============== FRONT CABIN ===============//
                  Expanded(child: SizedBox(), flex: 1),
                  Expanded(
                      child: Text(
                        "Front Cabin Temperature",
                        style: TextStyle(fontSize: 12),
                      ),
                      flex: 8),
                  Expanded(
                      child: Container(
                        child: Slider(
                          value: frontCabinTempNow,
                          onChanged: frontCabinTempUbah,
                        ),
                      ),
                      flex: 18),
                  Expanded(child: SizedBox(), flex: 1),

                  //=============== REAR CABIN ===============//
                  Expanded(child: SizedBox(), flex: 1),
                  Expanded(
                      child: Text(
                        "Rear Cabin Temperature",
                        style: TextStyle(fontSize: 12),
                      ),
                      flex: 8),
                  Expanded(
                      child: Container(
                        child: Slider(
                          value: rearCabinTempNow,
                          onChanged: rearCabinTempUbah,
                        ),
                      ),
                      flex: 18),
                  Expanded(child: SizedBox(), flex: 1),
                ],
              )
            : SizedBox(
                height: 0.0,
              ),

        //=============== SLIDER HUMID ===============//
        menuNow == 50.0
            ? Row(
                children: <Widget>[
                  Expanded(child: SizedBox(), flex: 1),

                  //=============== FRONT CABIN ===============//
                  Expanded(child: SizedBox(), flex: 1),
                  Expanded(child: Text("Front Cabin Humidity"), flex: 6),
                  Expanded(
                      child: Container(
                        child: Slider(
                          value: frontCabinHumidityNow,
                          onChanged: frontCabinHumidityUbah,
                        ),
                      ),
                      flex: 18),
                  Expanded(child: SizedBox(), flex: 1),

                  //=============== REAR CABIN ===============//
                  Expanded(child: SizedBox(), flex: 1),
                  Expanded(child: Text("Rear Cabin Humidity"), flex: 6),
                  Expanded(
                      child: Container(
                        child: Slider(
                          value: rearCabinHumidityNow,
                          onChanged: rearCabinHumidityUbah,
                        ),
                      ),
                      flex: 18),
                  Expanded(child: SizedBox(), flex: 1),
                ],
              )
            : SizedBox(
                height: 0.0,
              ),

        //=============== SLIDER VIB ===============//
        menuNow == 75.0
            ? Row(
          children: <Widget>[
            Expanded(child: SizedBox(), flex: 1),

            //=============== ENGINE ===============//
            Expanded(
                child: Text(
                  "Engine Vibration",
                  style: TextStyle(fontSize: 12),
                ),
                flex: 8),
            Expanded(
                child: Slider(
                  value: engineVibNow,
                  onChanged: engineVibUbah,
                ),
                flex: 18),

            //=============== FRONT CABIN ===============//
            Expanded(child: SizedBox(), flex: 1),
            Expanded(
                child: Text(
                  "Front Cabin Vibration",
                  style: TextStyle(fontSize: 12),
                ),
                flex: 8),
            Expanded(
                child: Container(
                  child: Slider(
                    value: frontCabinVibNow,
                    onChanged: frontCabinVibUbah,
                  ),
                ),
                flex: 18),
            Expanded(child: SizedBox(), flex: 1),

            //=============== REAR CABIN ===============//
            Expanded(child: SizedBox(), flex: 1),
            Expanded(
                child: Text(
                  "Rear Cabin Vibration",
                  style: TextStyle(fontSize: 12),
                ),
                flex: 8),
            Expanded(
                child: Container(
                  child: Slider(
                    value: rearCabinVibNow,
                    onChanged: rearCabinVibUbah,
                  ),
                ),
                flex: 18),
            Expanded(child: SizedBox(), flex: 1),
          ],
        )
            : SizedBox(
          height: 0.0,
        ),

        //=============== SLIDER ACCEL ===============//
        menuNow == 100.0
            ? Row(
                children: <Widget>[
                  Expanded(child: SizedBox(), flex: 1),

                  //=============== FRONT CABIN ===============//
                  Expanded(child: SizedBox(), flex: 1),
                  Expanded(child: Text("Car Acceleration"), flex: 5),
                  Expanded(
                      child: Container(
                        child: Slider(
                          value: accelerationNow,
                          onChanged: accelerationUbah,
                        ),
                      ),
                      flex: 25),
                  Expanded(child: SizedBox(), flex: 1),
                ],
              )
            : SizedBox(
                height: 0.0,
              ),

        //=============== SIGNATURE ===============//
//        SizedBox(
//          height: 20,
//        ),
//        Container(
//          height: 30,
//          color: Colors.black12,
//          alignment: Alignment.center,
//          child: Text(
//            "Copyright 2019 - Ahmad Dhiyaaul Auliyaa",
//            textAlign: TextAlign.center,
//            style: TextStyle(
//              fontFamily: "MuseoSans",
//              fontWeight: FontWeight.w500,
//              fontStyle: FontStyle.italic,
//              letterSpacing: -0.3,
//            ),
//          ),
//        ),
      ],
    );
  }
}
