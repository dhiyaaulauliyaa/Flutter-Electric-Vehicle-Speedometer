import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainGauge extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  //NEXUS 5X screenwidth: 731.4285714285714
  //NEXUS 5X screenheight: 411.42857142857144

  final double menu;

  final double rpmNow;
  final double speedNow;
  final double tempNow;
  final double fuelNow;
  final double gearNow;
  final double tripTotal;
  final int passengerNow;

  final bool brake;
  final bool defogger;
  final bool highBeam;
  final bool lowBeam;
  final bool oil;
  final bool wiper;

  final double acceleration;

  final double lowestEngineTemp = 50;
  final double engineTempTreshold = 150;
  final double highestEngineTemp = 250;
  final double frontCabinTemp;
  final double rearCabinTemp;
  final double tempLowest = 10;
  final double tempMid = 30;
  final double tempHighest = 50;

  final double frontCabinHumidity;
  final double rearCabinHumidity;
  final double humidLowest = 0.5;
  final double humidMid = 3;
  final double humidHighest = 6;

  final double engineVib;
  final double frontCabinVib;
  final double rearCabinVib;
  final double vibLowest = 10;
  final double vibMid = 50;
  final double vibHighest = 100;

  final double maxAcceleration = 150;

  MainGauge({
    this.screenWidth,
    this.screenHeight,
    this.menu,
    this.rpmNow,
    this.speedNow,
    this.tempNow,
    this.fuelNow,
    this.passengerNow,
    this.gearNow,
    this.tripTotal,
    this.brake,
    this.defogger,
    this.highBeam,
    this.lowBeam,
    this.oil,
    this.wiper,
    this.frontCabinTemp,
    this.rearCabinTemp,
    this.acceleration,
    this.frontCabinHumidity,
    this.rearCabinHumidity,
    this.engineVib,
    this.frontCabinVib,
    this.rearCabinVib
  });

  //8000 RPM
//  double _rpmGauge() {
//    const int rpmMax = 9000;
//    const double rpmWidthRatio = 0.5284375;
//    double rpmFullWidth = screenWidth * rpmWidthRatio;
//    double rpm = rpmNow * rpmMax;
//    double gaugeWidth;
//
//    if (rpm > 9000) {
//      gaugeWidth = rpmFullWidth;
//    } else if (rpm > 5000) {
//      gaugeWidth = ((rpmFullWidth * 0.52) * ((rpm - 5000) / (rpmMax - 5000))) +
//        (rpmFullWidth * 0.48);
//    } else
//      gaugeWidth = (rpmFullWidth * 0.48) * (rpm / (rpmMax - 4000));
//    return gaugeWidth;
//  }

  double _rpmGauge() {
    //Variabel Untuk Simulator
    const int rpmMax = 9000;
    double rpm = rpmNow * rpmMax;

    //Variabel Untuk Real Car
    // double rpm = rpmNow;

    const double rpmFirstTreshold = 3500;
    const double rpmSecondTreshold = 6000;
    const double rpmWidthRatio = 0.5284375;
    double rpmFullWidth = screenWidth * rpmWidthRatio;
    double gaugeWidth;

    //RPM < 3500
    if (rpm < rpmFirstTreshold) {
      gaugeWidth = (rpmFullWidth * 0.8) * (rpm / rpmFirstTreshold);
    }

    //RPM < 6000
    else if (rpm < rpmSecondTreshold) {
      gaugeWidth = (rpmFullWidth * 0.8) +
          ((rpmFullWidth * 0.2) *
              ((rpm - rpmFirstTreshold) /
                  (rpmSecondTreshold - rpmFirstTreshold)));
    }

    //RPM > 6000
    else
      gaugeWidth = rpmFullWidth;

    return gaugeWidth;
  }

  double _torqueGauge() {
    const int rpmMax = 9000;
    const double torqueWidthRatio = 0.2106;
    double torqueFullWidth = screenWidth * torqueWidthRatio;
    double rpm = rpmNow * rpmMax;
    double torqueLeft = 1 - (rpm / rpmMax);
    return torqueFullWidth * torqueLeft;
  }

  double _tempGauge() {
    const double tempLowestRatio = 0.24706614583;
    const double tempHighestRatio = 0.385474479167;

    double tempLowestWidth = tempLowestRatio * screenWidth;
    double tempHighestWidth = tempHighestRatio * screenWidth;
    double tempWidth = tempHighestWidth - tempLowestWidth;

    return tempLowestWidth + (tempNow * tempWidth);
  }

  double _fuelGauge() {
    const double fuelLowestRatio = 0.2424494791666667;
    const double fuelHighestRatio = 0.3808567708333333;

    double fuelLowestWidth = fuelLowestRatio * screenWidth;
    double fuelHighestWidth = fuelHighestRatio * screenWidth;
    double fuelWidth = fuelHighestWidth - fuelLowestWidth;

    return fuelLowestWidth + (fuelNow * fuelWidth);
  }

  String _rpmNum() {
    const int rpmMax = 9000;
    String x = (rpmNow * rpmMax).toStringAsFixed(0);
    debugPrint('RPM: $x');
    return x;
  }

  String _torqueNum() {
    double rpm = rpmNow * 100;
    String x = (100 - rpm).toStringAsFixed(0);
    debugPrint('Torque Left: $x%');
    return x;
  }

  String _speedGauge() {
    const int maxSpeed = 199;
    String x = (speedNow * maxSpeed).toStringAsFixed(0);
    debugPrint('Speed: $x');
    return x;
  }

  String _fuelNum() {
    String x = (fuelNow * 100).toStringAsFixed(0);
    debugPrint('Battery: $x%');
    return x;
  }

  String _kmRemaining() {
    const int maxKM = 250;
    String x = (fuelNow * maxKM).toStringAsFixed(0);
    debugPrint('Battery: $x%');
    return x;
  }

  String _tripNum() {
    double maxTrip = 200000.00;
    final formatter = NumberFormat("#,###.##");
    String trip = formatter.format(tripTotal * maxTrip);
    return trip;
  }

  String _numOfPassenger() {
    return passengerNow > 1 ? 'PASSENGERS' : 'PASSENGER';
  }

  double _gearOpacity(String gear) {
    double opacity;
    if (gearNow <= 0.2) {
      gear == 'p' ? opacity = 1.0 : opacity = 0.0;
    } else if (gearNow <= 0.4) {
      gear == 'r' ? opacity = 1.0 : opacity = 0.0;
    } else if (gearNow <= 0.6) {
      gear == 'n' ? opacity = 1.0 : opacity = 0.0;
    } else if (gearNow <= 0.8) {
      gear == 'd' ? opacity = 1.0 : opacity = 0.0;
    } else {
      gear == 'l' ? opacity = 1.0 : opacity = 0.0;
    }
    return opacity;
  }

  double _engineTemp() {
    double tempRange = highestEngineTemp - lowestEngineTemp;
    double engineTemp = (tempNow * tempRange) + lowestEngineTemp;
    return engineTemp;
  }

  double _frontCabinTemp() {
    double tempRange = tempHighest - tempLowest;
    double frontCabin = (frontCabinTemp * tempRange) + tempLowest;
    return frontCabin;
  }

  double _rearCabinTemp() {
    double tempRange = tempHighest - tempLowest;
    double rearCabin = (rearCabinTemp * tempRange) + tempLowest;
    return rearCabin;
  }

  double _graphTempOpacity(
      double reference, double lowestTemp, double midTemp, double highestTemp) {
    double lowestOpacity = 0.4;
    double highestOpacity = 0.8;
    double opacityRange = highestOpacity - lowestOpacity;
    double opacity;

    if (reference < midTemp)
      opacity = highestOpacity -
          ((reference - lowestTemp) / (midTemp - lowestTemp) * (opacityRange));
    else
      opacity = lowestOpacity +
          ((reference - midTemp) / (highestTemp - midTemp) * (opacityRange));

    print("Opacity: $opacity");
    return opacity;
  }

  Widget _frontCabinHumidity(humidity) {
    double value = humidity * 10;
    if (value < humidLowest) {
      return SizedBox();
    } else if (value < humidMid) {
      return Positioned(
        top: 0.225 * screenHeight,
        left: 0.4 * screenWidth,
        child: Image.asset(
          "assets/humidity/Humid-Cabin1-1.png",
          height: 0.21 * screenHeight,
        ),
      );
    } else if (value < humidHighest) {
      return Positioned(
        top: 0.22 * screenHeight,
        left: 0.4 * screenWidth,
        child: Image.asset(
          "assets/humidity/Humid-Cabin1-2.png",
          height: 0.215 * screenHeight,
        ),
      );
    } else
      return Positioned(
        top: 0.219 * screenHeight,
        left: 0.4 * screenWidth,
        child: Image.asset(
          "assets/humidity/Humid-Cabin1-3.png",
          height: 0.22 * screenHeight,
        ),
      );
  }

  Widget _rearCabinHumidity(humidity) {
    double value = humidity * 10;
    if (value < humidLowest) {
      return SizedBox();
    } else if (value < humidMid) {
      return Positioned(
        top: 0.225 * screenHeight,
        left: 0.48 * screenWidth,
        child: Image.asset(
          "assets/humidity/Humid-Cabin2-1.png",
          height: 0.19 * screenHeight,
        ),
      );
    } else if (value < humidHighest) {
      return Positioned(
        top: 0.227 * screenHeight,
        left: 0.478 * screenWidth,
        child: Image.asset(
          "assets/humidity/Humid-Cabin2-2.png",
          height: 0.19 * screenHeight,
        ),
      );
    } else
      return Positioned(
        top: 0.227 * screenHeight,
        left: 0.478 * screenWidth,
        child: Image.asset(
          "assets/humidity/Humid-Cabin2-3.png",
          height: 0.19 * screenHeight,
        ),
      );
  }

  double _carVib(double vib) {
    double vibRange = vibHighest - vibLowest;
    double vibration = (vib * vibRange) + vibLowest;
    return vibration;
  }

  double _graphVibOpacity(
      double reference, double lowestVib, double midVib, double highestVib) {
    double lowestOpacity = 0.4;
    double highestOpacity = 0.8;
    double opacityRange = highestOpacity - lowestOpacity;
    double opacity;

    if (reference < midVib)
      opacity = highestOpacity -
          ((reference - lowestVib) / (midVib - lowestVib) * (opacityRange));
    else
      opacity = lowestOpacity +
          ((reference - midVib) / (highestVib - midVib) * (opacityRange));

    print("Opacity: $opacity");
    return opacity;
  }

  double _acceleration(){
    return acceleration*maxAcceleration;
  }

  Widget _accelerationBar(){
    if (_acceleration() == maxAcceleration * 0.0) {
      return Image.asset(
        "assets/acceleration/acceleration-bar-0.png",
        width: screenWidth,
      );
    } else if (_acceleration() < maxAcceleration * 0.1) {
      return Image.asset(
        "assets/acceleration/acceleration-bar-1.png",
        width: screenWidth,
      );
    } else if (_acceleration() < maxAcceleration * 0.2) {
      return Image.asset(
        "assets/acceleration/acceleration-bar-2.png",
        width: screenWidth,
      );
    } else if (_acceleration() < maxAcceleration * 0.3) {
      return Image.asset(
        "assets/acceleration/acceleration-bar-3.png",
        width: screenWidth,
      );
    } else if (_acceleration() < maxAcceleration * 0.4) {
      return Image.asset(
        "assets/acceleration/acceleration-bar-4.png",
        width: screenWidth,
      );
    } else if (_acceleration() < maxAcceleration * 0.5) {
      return Image.asset(
        "assets/acceleration/acceleration-bar-5.png",
        width: screenWidth,
      );
    } else if (_acceleration() < maxAcceleration * 0.6) {
      return Image.asset(
        "assets/acceleration/acceleration-bar-6.png",
        width: screenWidth,
      );
    } else if (_acceleration() < maxAcceleration * 0.7) {
      return Image.asset(
        "assets/acceleration/acceleration-bar-7.png",
        width: screenWidth,
      );
    } else if (_acceleration() < maxAcceleration * 0.8) {
      return Image.asset(
        "assets/acceleration/acceleration-bar-8.png",
        width: screenWidth,
      );
    } else if (_acceleration() < maxAcceleration * 0.9) {
      return Image.asset(
        "assets/acceleration/acceleration-bar-9.png",
        width: screenWidth,
      );
    } else {
      return Image.asset(
        "assets/acceleration/acceleration-bar-10.png",
        width: screenWidth,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //=============== METER OFF ===============//
        Positioned(
          top: 0,
          child: Image.asset(
            'assets/meter/meterOff.png',
            width: screenWidth,
          ),
        ),

        //=============== RPM ON ===============//
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox.fromSize(
            size: Size(_rpmGauge(), screenHeight * 0.618),
            child: Container(
              child: Image.asset(
                'assets/meter/meterOn.png',
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ),

        //=============== TORQUE ON ===============//
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox.fromSize(
            size: Size(_torqueGauge(), screenHeight * 0.618),
            child: Container(
              child: Image.asset(
                'assets/meter/meterOn.png',
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerRight,
              ),
            ),
          ),
        ),

        //=============== MAIN MENU ===============//
        menu == 0.0
            ? Stack(
                children: <Widget>[
                  //=============== TEMP ===============//
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox.fromSize(
                      size: Size(_tempGauge(), screenHeight * 0.618),
                      child: Container(
                        child: Image.asset(
                          'assets/meter/indicatorOn.png',
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                  ),

                  //=============== FUEL ===============//
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SizedBox.fromSize(
                      size: Size(_fuelGauge(), screenHeight * 0.618),
                      child: Container(
                        child: Image.asset(
                          'assets/meter/indicatorOn.png',
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),

                  //=============== GEAR ===============//
                  Positioned(
                    top: screenHeight * 0.4410703703703704,
                    child: Container(
                      height: screenHeight * 0.0480203703703704,
                      width: screenWidth,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Opacity(
                            opacity: _gearOpacity('p'),
                            child: Image.asset(
                              "assets/indicator/gearOn.png",
                              height: screenHeight * 0.0480203703703704,
                              width: screenWidth * 0.031728125,
                            ),
                          ),
                          Opacity(
                            opacity: _gearOpacity('r'),
                            child: Image.asset(
                              "assets/indicator/gearOn.png",
                              height: screenHeight * 0.0480203703703704,
                              width: screenWidth * 0.031728125,
                            ),
                          ),
                          Opacity(
                            opacity: _gearOpacity('n'),
                            child: Image.asset(
                              "assets/indicator/gearOn.png",
                              height: screenHeight * 0.0480203703703704,
                              width: screenWidth * 0.031728125,
                            ),
                          ),
                          Opacity(
                            opacity: _gearOpacity('d'),
                            child: Image.asset(
                              "assets/indicator/gearOn.png",
                              height: screenHeight * 0.0480203703703704,
                              width: screenWidth * 0.031728125,
                            ),
                          ),
                          Opacity(
                            opacity: _gearOpacity('l'),
                            child: Image.asset(
                              "assets/indicator/gearOn.png",
                              height: screenHeight * 0.0480203703703704,
                              width: screenWidth * 0.031728125,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //=============== UPPER ===============//
                  Positioned(
                    top: 0,
                    child: Opacity(
                      opacity: 1,
                      child: Image.asset(
                        'assets/meter/upperMeter2.png',
                        width: screenWidth,
                      ),
                    ),
                  ),

                  //=============== SPEED ===============//
                  Positioned(
                    top: screenHeight * 0.231,
                    child: Container(
                      height: screenHeight * 0.165,
                      width: screenWidth,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center,
                        child: Text(
                          _speedGauge(),
                          style: TextStyle(
                            fontFamily: "Krunch",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //=============== BATTERY NUM ===============//
                  Positioned(
                    top: screenHeight * 0.268,
                    right: screenWidth * 0.215,
                    child: Container(
                      height: screenHeight * 0.12,
                      width: screenWidth * 0.11,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: screenWidth * 0.015,
                              ),
                              Container(
                                height: screenHeight * 0.065,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment.center,
                                  child: Text(
                                    _fuelNum(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Krunch",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: screenHeight * 0.035,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    "%",
                                    style: TextStyle(
                                      fontFamily: "Krunch",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.025,
                          ),
                          Container(
                            height: screenHeight * 0.029,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              alignment: Alignment.center,
                              child: Text(
                                _kmRemaining() + " KM remaining",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "MuseoSans",
                                  fontWeight: FontWeight.w100,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //=============== PASSANGER ON BOARD ===============//
                  Positioned(
                    top: screenHeight * 0.268,
                    left: screenWidth * 0.227121875,
                    child: Container(
                      height: screenHeight * 0.095,
                      width: screenWidth * 0.0894921875,
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: screenHeight * 0.065,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              alignment: Alignment.center,
                              child: Text(
                                "$passengerNow",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Krunch",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.03,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              alignment: Alignment.center,
                              child: Text(
                                _numOfPassenger(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "MuseoSans",
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: -0.4,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  //=============== TRIP METER ===============//
                  Positioned(
                    top: screenHeight * 0.54,
                    child: Container(
                      height: screenHeight * 0.035,
                      width: screenWidth,
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "TRIP: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "MuseoSans",
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.4,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _tripNum() + " KM",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "MuseoSans",
                                fontWeight: FontWeight.w300,
                                letterSpacing: -0.4,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //=============== INDICATORS ===============//
                  Positioned(
                    top: screenHeight * 0.5214138888888889,
                    child: Container(
                      height: screenHeight * 0.0705231481481481,
                      width: screenWidth,
                      alignment: Alignment.center,
                      // color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //=============== HIGH BEAM ===============//
                          Image.asset(
                            "assets/indicator/high_beam.png",
                            height: screenHeight * 0.0224805555555556,
                            color: highBeam
                                ? Color.fromRGBO(242, 184, 68, 1.0)
                                : Color.fromRGBO(6, 1, 94, 1.0),
                          ),
                          SizedBox(
                            width: screenWidth * 0.0074255208333333,
                          ),

                          //=============== LOW BEAM ===============//
                          Image.asset(
                            "assets/indicator/low_beam.png",
                            height: screenHeight * 0.0224805555555556,
                            color: lowBeam
                                ? Color.fromRGBO(242, 184, 68, 1.0)
                                : Color.fromRGBO(6, 1, 94, 1.0),
                          ),
                          SizedBox(
                            width: screenWidth * 0.0074255208333333,
                          ),

                          //=============== BRAKE ===============//
                          Image.asset(
                            "assets/indicator/brake.png",
                            height: screenHeight * 0.0224805555555556,
                            color: brake
                                ? Color.fromRGBO(242, 184, 68, 1.0)
                                : Color.fromRGBO(6, 1, 94, 1.0),
                          ),
                          SizedBox(
                            width: screenWidth * 0.0074255208333333,
                          ),

                          //=============== SPACER ===============//
                          Container(
                            width: screenWidth * 0.16,
                            // color: Colors.black,
                          ),

                          //=============== DEFOGGER ===============//
                          SizedBox(
                            width: screenWidth * 0.0074255208333333,
                          ),
                          Image.asset(
                            "assets/indicator/defogger.png",
                            height: screenHeight * 0.0224805555555556,
                            color: defogger
                                ? Color.fromRGBO(242, 184, 68, 1.0)
                                : Color.fromRGBO(6, 1, 94, 1.0),
                          ),

                          //=============== WIPER ===============//
                          SizedBox(
                            width: screenWidth * 0.0074255208333333,
                          ),
                          Image.asset(
                            "assets/indicator/wiper.png",
                            height: screenHeight * 0.0224805555555556,
                            color: wiper
                                ? Color.fromRGBO(242, 184, 68, 1.0)
                                : Color.fromRGBO(6, 1, 94, 1.0),
                          ),

                          //=============== OIL ===============//
                          SizedBox(
                            width: screenWidth * 0.0074255208333333,
                          ),
                          Image.asset(
                            "assets/indicator/oil.png",
                            height: screenHeight * 0.018,
                            color: oil
                                ? Color.fromRGBO(255, 45, 85, 1.0)
                                : Color.fromRGBO(6, 1, 94, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(height: 0),

        //=============== UPPER ===============//
        menu != 0.0
            ? Positioned(
                top: 0,
                child: Opacity(
                  opacity: 1,
                  child: Image.asset(
                    'assets/meter/upperMeter2-Plain.png',
                    width: screenWidth,
                  ),
                ),
              )
            : SizedBox(height: 0.0),

        //=============== TEMPERATURE ===============//
        AnimatedOpacity(
          opacity: menu == 25.0 ? 1 : 0,
          duration: Duration(milliseconds: 500),
          child: Stack(
            children: <Widget>[
              //=============== CAR IMG TEMP ===============//
              Image.asset(
                "assets/temp/car-neon-full.png",
                width: screenWidth,
              ),

              //=============== TEMP TEXT ===============//
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 0.67 * screenWidth,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 0.24 * screenHeight,
                      ),
                      Text(
                        "ENGINE",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.4,
                          color: Colors.white,
                          fontSize: 10,
                          height: 0.5,
                        ),
                      ),
                      Text(
                        "${_engineTemp().toStringAsFixed(0)}°C",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: _engineTemp() > engineTempTreshold
                              ? Color(0xFFFB5842)
                              : Color(0xFF00E7FF),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "FRONT CABIN",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.4,
                          color: Colors.white,
                          fontSize: 10,
                          height: 0.5,
                        ),
                      ),
                      Text(
                        "${_frontCabinTemp().toStringAsFixed(0)}°C",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: _frontCabinTemp() > tempMid
                              ? Color(0xFFFB5842)
                              : Color(0xFF00E7FF),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "REAR CABIN",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.4,
                          color: Colors.white,
                          fontSize: 10,
                          height: 0.5,
                        ),
                      ),
                      Text(
                        "${_rearCabinTemp().toStringAsFixed(0)}°C",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: _rearCabinTemp() > tempMid
                              ? Color(0xFFFB5842)
                              : Color(0xFF00E7FF),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                ],
              ),

              //=============== ENGINE TEMP GRAPH ===============//
              Positioned(
                top: 0.285 * screenHeight,
                left: 0.27 * screenWidth,
                child: Opacity(
                  opacity: _graphTempOpacity(_engineTemp(), lowestEngineTemp,
                      engineTempTreshold, highestEngineTemp),
                  child: Image.asset(
                    _engineTemp() > engineTempTreshold
                        ? "assets/temp/redtemp-engine.png"
                        : "assets/temp/bluetemp-engine.png",
                    width: 0.09 * screenWidth,
                  ),
                ),
              ),

              //=============== FRONT CABIN TEMP GRAPH ===============//
              Positioned(
                top: 0.225 * screenHeight,
                left: 0.37 * screenWidth,
                child: Opacity(
                  opacity: _graphTempOpacity(
                      _frontCabinTemp(), tempLowest, tempMid, tempHighest),
                  child: Image.asset(
                    _frontCabinTemp() > tempMid
                        ? "assets/temp/redtemp-cabin-1.png"
                        : "assets/temp/bluetemp-cabin-1.png",
                    width: 0.13 * screenWidth,
                  ),
                ),
              ),

              //=============== REAR CABIN TEMP GRAPH ===============//
              Positioned(
                top: 0.233 * screenHeight,
                left: 0.48 * screenWidth,
                child: Opacity(
                  opacity: _graphTempOpacity(
                      _rearCabinTemp(), tempLowest, tempMid, tempHighest),
                  child: Image.asset(
                    _rearCabinTemp() > tempMid
                        ? "assets/temp/redtemp-cabin-2.png"
                        : "assets/temp/bluetemp-cabin-2.png",
                    width: 0.07 * screenWidth,
                  ),
                ),
              ),

              //=============== TEMPERATURE TITLE ===============//
              Positioned(
                top: screenHeight * 0.54,
                child: Container(
                  height: screenHeight * 0.035,
                  width: screenWidth,
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "CAR TEMPERATURE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "MuseoSans",
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //=============== HUMIDITY ===============//
        AnimatedOpacity(
          opacity: menu == 50.0 ? 1 : 0,
          duration: Duration(milliseconds: 500),
          child: Stack(
            children: <Widget>[
              //=============== CAR IMG HUMIDITY ===============//
              Image.asset(
                "assets/temp/car-neon-full.png",
                width: screenWidth,
              ),

              //=============== HUMID TEXT ===============//
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 0.67 * screenWidth,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 0.27 * screenHeight,
                      ),
                      Text(
                        "FRONT CABIN",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.4,
                          color: Colors.white,
                          fontSize: 10,
                          height: 0.5,
                        ),
                      ),
                      Text(
                        "${(frontCabinHumidity * 10).toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: _frontCabinTemp() > tempMid
                              ? Color(0xFFFB5842)
                              : Color(0xFF00E7FF),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "REAR CABIN",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.4,
                          color: Colors.white,
                          fontSize: 10,
                          height: 0.5,
                        ),
                      ),
                      Text(
                        "${(rearCabinHumidity * 10).toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: _rearCabinTemp() > tempMid
                              ? Color(0xFFFB5842)
                              : Color(0xFF00E7FF),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                ],
              ),

              //=============== FRONT CABIN HUMIDITY GRAPH ===============//
              _frontCabinHumidity(frontCabinHumidity),

              //=============== REAR CABIN HUMIDITY  GRAPH ===============//
              _rearCabinHumidity(rearCabinHumidity),

              //=============== HUMIDITY TITLE ===============//
              Positioned(
                top: screenHeight * 0.54,
                child: Container(
                  height: screenHeight * 0.035,
                  width: screenWidth,
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "CAR HUMIDITY",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "MuseoSans",
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //=============== VIBRATION ===============//
        AnimatedOpacity(
          opacity: menu == 75.0 ? 1 : 0,
          duration: Duration(milliseconds: 500),
          child: Stack(
            children: <Widget>[
              //=============== CAR IMG VIB ===============//
              Image.asset(
                "assets/vibration/vibereshon.png",
                width: screenWidth,
              ),

              //=============== VIB TEXT ===============//
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 0.67 * screenWidth,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 0.24 * screenHeight,
                      ),
                      Text(
                        "ENGINE",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.4,
                          color: Colors.white,
                          fontSize: 10,
                          height: 0.5,
                        ),
                      ),
                      Text(
                        "${_carVib(engineVib).toStringAsFixed(2)} Hz",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: _carVib(engineVib) > vibMid
                              ? Color(0xFFFB5842)
                              : Color(0xFF00E7FF),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "FRONT CABIN",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.4,
                          color: Colors.white,
                          fontSize: 10,
                          height: 0.5,
                        ),
                      ),
                      Text(
                        "${_carVib(frontCabinVib).toStringAsFixed(2)} Hz",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: _carVib(frontCabinVib) > vibMid
                              ? Color(0xFFFB5842)
                              : Color(0xFF00E7FF),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "REAR CABIN",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.4,
                          color: Colors.white,
                          fontSize: 10,
                          height: 0.5,
                        ),
                      ),
                      Text(
                        "${_carVib(rearCabinVib).toStringAsFixed(2)} Hz",
                        style: TextStyle(
                          fontFamily: "MuseoSans",
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          color: _carVib(rearCabinVib) > vibMid
                              ? Color(0xFFFB5842)
                              : Color(0xFF00E7FF),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                ],
              ),

              //=============== ENGINE VIB GRAPH ===============//
              Positioned(
                top: 0.263 * screenHeight,
                left: 0.285 * screenWidth,
                child: Opacity(
                  opacity: _graphVibOpacity(_carVib(engineVib), vibLowest,
                      vibMid, vibHighest),
                  child: Image.asset(
                    _carVib(engineVib) > vibMid
                        ? "assets/vibration/redvib-engine.png"
                        : "assets/vibration/bluevib-engine.png",
                    height: 0.175 * screenHeight,
                  ),
                ),
              ),

              //=============== FRONT CABIN TEMP GRAPH ===============//
              Positioned(
                top: 0.267   * screenHeight,
                left: 0.42 * screenWidth,
                child: Opacity(
                  opacity: _graphVibOpacity(_carVib(frontCabinVib), vibLowest, vibMid, vibHighest),
                  child: Image.asset(
                    _carVib(frontCabinVib) > vibMid
                        ? "assets/vibration/redvib-cabin-1.png"
                        : "assets/vibration/bluevib-cabin-1.png",
                    height: 0.17 * screenHeight,
                  ),
                ),
              ),

              //=============== REAR CABIN TEMP GRAPH ===============//
              Positioned(
                top: 0.267   * screenHeight,
                left: 0.465 * screenWidth,
                child: Opacity(
                  opacity: _graphVibOpacity(_carVib(rearCabinVib), vibLowest, vibMid, vibHighest),
                  child: Image.asset(
                    _carVib(rearCabinVib) > vibMid
                        ? "assets/vibration/redvib-cabin-2.png"
                        : "assets/vibration/bluevib-cabin-2.png",
                    height: 0.17 * screenHeight,
                  ),
                ),
              ),

              //=============== TEMPERATURE TITLE ===============//
              Positioned(
                top: screenHeight * 0.54,
                child: Container(
                  height: screenHeight * 0.035,
                  width: screenWidth,
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "CAR VIBRATION",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "MuseoSans",
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //=============== ACCELERATION ===============//
        AnimatedOpacity(
          opacity: menu == 100.0 ? 1 : 0,
          duration: Duration(milliseconds: 500),
          child: Stack(
            children: <Widget>[
              //=============== ACCELERATION BASE ===============//
              Image.asset(
                "assets/acceleration/acceleration-base.png",
                width: screenWidth,
              ),
              Positioned(
                top: 0.22 * screenHeight,
                child: Container(
                  width: screenWidth,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "acceleration",
                        style: TextStyle(
                          fontFamily: "Krunch",
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 60),
                      Text(
                        _acceleration().toStringAsFixed(2) + " KM/H",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Krunch",
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //=============== ACCELERATION GRAPH ===============//
              _accelerationBar(),

              //=============== ACCELERATION TITLE ===============//
              Positioned(
                top: screenHeight * 0.54,
                child: Container(
                  height: screenHeight * 0.035,
                  width: screenWidth,
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "CAR ACCELERATION",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "MuseoSans",
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.4,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //=============== RPM NUM ===============//
        Positioned(
          top: screenHeight * 0.094,
          left: screenWidth * 0.537,
          child: Container(
            height: screenHeight * 0.057,
            width: screenWidth * 0.112,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerLeft,
              child: Text(
                _rpmNum(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Krunch",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        //=============== TORQUE NUM ===============//
        Positioned(
          top: screenHeight * 0.094,
          left: screenWidth * 0.675,
          child: Container(
            height: screenHeight * 0.057,
            width: screenWidth * 0.112,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerLeft,
              child: Text(
                _torqueNum() + '%',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Krunch",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
