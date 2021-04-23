import 'package:flutter/material.dart';
import 'package:step_slider/step_slider.dart';

import 'dashboard_controller.dart';
import 'main_gauge.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  double _menuNow = 0.0;
  bool _blackBox = false;

  double _rpmNow = 0.0;
  double _speedNow = 0.0;
  double _tempNow = 0.0;
  double _fuelNow = 0.0;
  double _gearNow = 0.0;
  double _tripTotal = 0.0;
  int _passengerNow = 0;

  bool _brake = false;
  bool _defogger = false;
  bool _highBeam = false;
  bool _lowBeam = false;
  bool _oil = false;
  bool _wiper = false;

  double _frontCabinTempNow = 0.0;
  double _rearCabinTempNow = 0.0;

  double _frontCabinHumidityNow = 0.0;
  double _rearCabinHumidityNow = 0.0;

  double _engineVibNow = 0.0;
  double _frontCabinVibNow = 0.0;
  double _rearCabinVibNow = 0.0;

  double _accelerationNow = 0.0;

  void menuUbah(double menu) {
    setState(() {
      _menuNow = menu;
      debugPrint('Menu Slider: $_menuNow');
    });
  }

  void rpmUbah(double rpm) {
    setState(() {
      _rpmNow = rpm;
      debugPrint('RPM Slider: $_rpmNow');
    });
  }

  void speedUbah(double speed) {
    setState(() {
      _speedNow = speed;
      debugPrint('Speed Slider: $_speedNow');
    });
  }

  void tempUbah(double temp) {
    setState(() {
      _tempNow = temp;
      debugPrint('Temp Slider: $_tempNow');
    });
  }

  void fuelUbah(double fuel) {
    setState(() {
      _fuelNow = fuel;
      debugPrint('Fuel Slider: $_fuelNow');
    });
  }

  void gearUbah(double gear) {
    setState(() {
      _gearNow = gear;
      debugPrint('Gear Slider: $_gearNow');
    });
  }

  void tripUbah(double trip) {
    setState(() {
      _tripTotal = trip;
      debugPrint('Trip Slider: $_tripTotal');
    });
  }

  void passengerIncrease() {
    setState(() {
      _passengerNow++;
    });
  }

  void passengerDecrease() {
    setState(() {
      _passengerNow < 1 ? _passengerNow = 0 : _passengerNow--;
    });
  }

  void frontCabinTempUbah(double temp) {
    setState(() {
      _frontCabinTempNow = temp;
      debugPrint('Front Cabin Temp Slider: $_frontCabinTempNow');
    });
  }

  void rearCabinTempUbah(double temp) {
    setState(() {
      _rearCabinTempNow = temp;
      debugPrint('Rear Cabin Temp Slider: $_rearCabinTempNow');
    });
  }

  void frontCabinHumidityUbah(double humidity) {
    setState(() {
      _frontCabinHumidityNow = humidity;
      debugPrint('Front Cabin Humidity Slider: $_frontCabinHumidityNow');
    });
  }

  void rearCabinHumidityUbah(double humidity) {
    setState(() {
      _rearCabinHumidityNow = humidity;
      debugPrint('Rear Cabin Humidity Slider: $_rearCabinHumidityNow');
    });
  }

  void engineVibUbah(double vib) {
    setState(() {
      _engineVibNow = vib;
      debugPrint('Front Cabin Vib Slider: $_engineVibNow');
    });
  }

  void frontCabinVibUbah(double vib) {
    setState(() {
      _frontCabinVibNow = vib;
      debugPrint('Front Cabin Vib Slider: $_frontCabinVibNow');
    });
  }

  void rearCabinVibUbah(double vib) {
    setState(() {
      _rearCabinVibNow = vib;
      debugPrint('Rear Cabin Vib Slider: $_rearCabinVibNow');
    });
  }

  void accelerationUbah(double acceleration) {
    setState(() {
      _accelerationNow = acceleration;
      debugPrint('Acceleration Slider: $_accelerationNow');
    });
  }

  void brakeUbah(bool value) => setState(() => _brake = value);
  void defoggerUbah(bool value) => setState(() => _defogger = value);
  void wiperUbah(bool value) => setState(() => _wiper = value);
  void oilUbah(bool value) => setState(() => _oil = value);
  void highBeamUbah(bool value) => setState(() => _highBeam = value);
  void lowBeamUbah(bool value) => setState(() => _lowBeam = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ListView(
              children: <Widget>[
                //=============== SLIDERS ===============//
                DashboardController(
                  screenHeight: constraints.maxHeight,
                  screenWidth: constraints.maxWidth,
                  menuNow: _menuNow,
                  rpmNow: _rpmNow,
                  rpmUbah: rpmUbah,
                  speedNow: _speedNow,
                  speedUbah: speedUbah,
                  tempNow: _tempNow,
                  tempUbah: tempUbah,
                  fuelNow: _fuelNow,
                  fuelUbah: fuelUbah,
                  gearNow: _gearNow,
                  gearUbah: gearUbah,
                  passengerNow: _passengerNow,
                  passengerIncrease: passengerIncrease,
                  passengerDecrease: passengerDecrease,
                  tripTotal: _tripTotal,
                  tripUbah: tripUbah,
                  brake: _brake,
                  defogger: _defogger,
                  highBeam: _highBeam,
                  lowBeam: _lowBeam,
                  oil: _oil,
                  wiper: _wiper,
                  brakeUbah: brakeUbah,
                  defoggerUbah: defoggerUbah,
                  wiperUbah: wiperUbah,
                  oilUbah: oilUbah,
                  highBeamUbah: highBeamUbah,
                  lowBeamUbah: lowBeamUbah,
                  frontCabinTempNow: _frontCabinTempNow,
                  frontCabinTempUbah: frontCabinTempUbah,
                  rearCabinTempNow: _rearCabinTempNow,
                  rearCabinTempUbah: rearCabinTempUbah,
                  accelerationNow: _accelerationNow,
                  accelerationUbah: accelerationUbah,
                  frontCabinHumidityNow: _frontCabinHumidityNow,
                  frontCabinHumidityUbah: frontCabinHumidityUbah,
                  rearCabinHumidityNow: _rearCabinHumidityNow,
                  rearCabinHumidityUbah: rearCabinHumidityUbah,
                  engineVibNow: _engineVibNow,
                  engineVibUbah: engineVibUbah,
                  frontCabinVibNow: _frontCabinVibNow,
                  frontCabinVibUbah: frontCabinVibUbah,
                  rearCabinVibNow: _rearCabinVibNow,
                  rearCabinVibUbah: rearCabinVibUbah,
                ),
              ],
            ),

            //=============== BACKGROUND ===============//
            Positioned(
              top: 0,
              child: SizedBox.fromSize(
                size: Size(
                  constraints.maxWidth,
                  constraints.maxHeight * 0.618,
                ),
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),

            //=============== MENU SLIDER ===============//
            Positioned(
              top: (MediaQuery.of(context).size.height * 0.619) - 5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                color: Color(0xFF030515),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: SizedBox(), flex: 1),
                    Expanded(
                      child: StepSlider(
                        min: 0.0,
                        max: 100.0,
                        steps: {0, 25, 50, 75, 100},
                        initialStep: 0,
                        animDuration: Duration(seconds: 1),
                        snapMode: SnapMode.value(10),
                        activeColor: Color(0xFF142FF4),
                        inactiveColor: Color(0xFF0015F4),
                        hardSnap: true,
                        onStepChanged: menuUbah,
                      ),
                      flex: 10,
                    ),
                    Expanded(child: SizedBox(), flex: 1),
                  ],
                ),
              ),
            ),

            //=============== DASHBOARD ===============//
            MainGauge(
              screenHeight: constraints.maxHeight,
              screenWidth: constraints.maxWidth,
              menu: _menuNow,
              rpmNow: _rpmNow,
              speedNow: _speedNow,
              tempNow: _tempNow,
              fuelNow: _fuelNow,
              passengerNow: _passengerNow,
              gearNow: _gearNow,
              tripTotal: _tripTotal,
              brake: _brake,
              defogger: _defogger,
              highBeam: _highBeam,
              lowBeam: _lowBeam,
              oil: _oil,
              wiper: _wiper,
              frontCabinTemp: _frontCabinTempNow,
              rearCabinTemp: _rearCabinTempNow,
              acceleration: _accelerationNow,
              frontCabinHumidity: _frontCabinHumidityNow,
              rearCabinHumidity: _rearCabinHumidityNow,
              engineVib: _engineVibNow,
              frontCabinVib: _frontCabinVibNow,
              rearCabinVib: _rearCabinVibNow,
            ),

            //=============== BLACK BOX ===============//
            _blackBox
                ? Positioned(
                    top: (MediaQuery.of(context).size.height * 0.619) + 30,
                    right: 0,
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xFF030515),
                    ),
                  )
                : SizedBox(height: 0),

            //=============== GUIDE ===============//
            Positioned(
              top: 0,
              child: Opacity(
                opacity: 0,
                child: Image.asset(
                  "assets/guide.png",
                  width: constraints.maxWidth,
                ),
              ),
            ),
          ],
        ),
      ),

      //=============== BLACK BOX SWITCH ===============//
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            height: 80,
            width: 80,
            child: FloatingActionButton(
              elevation: 5,
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(),
              onPressed: () => setState(() => _blackBox = !_blackBox),
            ),
          )
        ],
      ),
    );
  }
}
