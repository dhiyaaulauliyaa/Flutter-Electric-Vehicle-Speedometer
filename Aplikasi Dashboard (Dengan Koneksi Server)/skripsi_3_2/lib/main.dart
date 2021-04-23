import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import 'main_gauge.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //----------------- WEBSOCKET VARIABLES -----------------//
  WebSocketChannel _channel =
      IOWebSocketChannel.connect('ws://echo.websocket.org');

  //----------------- ADDRESS INPUT -----------------//
  TextEditingController hostnameInput = TextEditingController();
  TextEditingController portInput = TextEditingController();
  TextEditingController wsInput =
      TextEditingController(text: 'ws://192.168.43.237:8000');
  TextEditingController messageInput = TextEditingController();
  String _hostname = '192.168.43.237';
  String _port = '7500';
  String _wsAddress = 'ws://192.168.43.237:8000';

  //----------------- SEND TO REST HTTP -----------------//
  void sendDataToServer(String speed, String rpm, String temp) {
    const url = 'https://flutter-update-5e4c6.firebaseio.com/vehicledata.json';
    http.post(url,
        body: json.encode({'speed': speed, 'rpm': rpm, 'temp': temp}));
  }

  //----------------- GET POSITION FROM GPS -----------------//
//  Position _position;
//  StreamSubscription<Position> _positionStreamSubscription;
//  var locationOptions =
//      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
//
//  void _toggleListening() {
//    print('$_position');
//    print("TONGLGINGGG");
//    if (_positionStreamSubscription == null) {
//      final Stream<Position> positionStream =
//          Geolocator().getPositionStream(locationOptions);
//
//      _positionStreamSubscription = positionStream
//          .listen((Position position) => setState(() => _position = position));
//
//      print('${_position.latitude.toString()}');
//
//      _positionStreamSubscription.pause();
//      _positionStreamSubscription.cancel();
//
//    }
//
//    setState(() {
//      if (_positionStreamSubscription.isPaused) {
//        print("toggling");
//        _positionStreamSubscription.resume();
//      } else {
//        _positionStreamSubscription.pause();
//      }
//    });
//  }
//
//  void cekPermisi() async {
//    try {
//      await Geolocator().checkGeolocationPermissionStatus().then((status) {
//        print('status: $status');
//      });
//
//      await Geolocator()
//          .checkGeolocationPermissionStatus(
//              locationPermission: GeolocationPermission.locationAlways)
//          .then((status) {
//        print('always status: $status');
//      });
//
//      await Geolocator()
//          .checkGeolocationPermissionStatus(
//              locationPermission: GeolocationPermission.locationWhenInUse)
//          .then((status) {
//        print('whenInUse status: $status');
//      });
//    } catch (e) {
//      print('Error: ${e.toString()}');
//    }
//  }
//
//  void updateLocation() async {
//    print('$_position');
//    print("UPDATEINGGGGG");
//    try {
//      Position newPosition = await Geolocator()
//          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//          .timeout(Duration(seconds: 5));
//
//      setState(() {
//        _position = newPosition;
//        print('${_position.latitude.toString()}');
//      });
//    } catch (e) {
//      print('Error: ${e.toString()}');
//    }
//  }

  //----------------- STATUS MONITOR -----------------//
  int _dataCount = 0;
  String _dataReceived = 'Not Yet Receiving';
  String _status = 'Not Connected';
  String kirim;

  bool _connected = false;
  _connectionCallback(newState) {
    setState(() {
      _connected = newState;
      if (newState) {
        _status = 'Connected';
      } else
        _status = 'Not Connected';
    });
  }

  //----------------- DATAS -----------------//
  Map data;
  String speed = '10';
  String rpm = '1000';
  String temp = '20';

  //----------------- LAYOUTS -----------------//
  double addressSpacer = 1.0;

  //----------------- STATE INITIALIZATION -----------------//
  @override
  void initState() {
    super.initState();

//    cekPermisi();
//    _toggleListening();
//    updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'MuseoSans'),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) => _connected
              ? streamBuilder(constraints, context)
              : addressInputForm(),
        ),
      ),
    );
  }

  StreamBuilder streamBuilder(
      BoxConstraints constraints, BuildContext context) {
    return StreamBuilder(
      stream: _channel.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _status = "Connected";

          _dataReceived = snapshot.data;
          print("Debug: $_dataReceived"); //debugging

          // JSON decoding
          data = jsonDecode(_dataReceived);
          speed = data['speed'];
          rpm = data['rpm'];
          temp = data['temp'];

          // Send data to REST HTTP
          sendDataToServer(speed, rpm, temp);

          //Send ping
          _sendPing();

          //Update location
//          updateLocation();

          _dataCount++;
        } else {
          _status = "Not Yet Connected";
        }

        return MainGauge(
          constraints: constraints,
          context: context,
          screenWidth: constraints.maxWidth,
          screenHeight: constraints.maxHeight,
          speed: double.parse(speed),
          rpm: double.parse(rpm),
          temp: double.parse(temp),
//          latitude: _position.latitude.toString() ?? "Geolocation Failed",
//          longitude: _position.longitude.toString() ?? "Geolocation Failed",
          connectionStatus: _connected,
          connectionCallback: _connectionCallback,
          channel: _channel,
        );
      },
    );
  }

  ListView addressInputForm() {
    Flexible _inputAddressSpacer(int flex, double width) {
      return Flexible(
        flex: flex,
        child: SizedBox(width: 10),
      );
    }

    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "Connect to server to access dashboard.",
              textScaleFactor: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "MuseoSans",
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _inputAddressSpacer(1, 10),
                Flexible(
                  flex: 5,
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Host Address",
                      ),
                      controller: hostnameInput,
                    ),
                  ),
                ),
                _inputAddressSpacer(1, 10),
                Flexible(
                  flex: 3,
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Port",
                      ),
                      controller: portInput,
                    ),
                  ),
                ),
                _inputAddressSpacer(1, 10),
                Flexible(
                  flex: 6,
                  child: Form(
                    child: TextField(
                      controller: wsInput,
                      decoration: InputDecoration(
                        labelText: "Websocket Address",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FloatingActionButton(
                    child: Icon(Icons.add_circle),
                    onPressed: _setSocketAddress,
                  ),
                ),
                Flexible(
                  child: FloatingActionButton(
                    child: Icon(Icons.play_circle_filled),
                    onPressed: _connectWS,
                  ),
                ),
                Flexible(
                  child: FloatingActionButton(
                    child: Icon(Icons.stop),
                    onPressed: _closeWS,
                  ),
                ),
                _inputAddressSpacer(1, 10),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Connection Status: $_status",
              textScaleFactor: 1.2,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Container(
                height: 2,
                color: Colors.black12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Copyright Universitas Indonesia 2019",
              style: TextStyle(color: Colors.black26),
            ),
            Text(
              "Evaluation Version 1.0",
              style: TextStyle(color: Colors.black26),
            ),
          ],
        )
      ],
    );
  }

  void _setSocketAddress() {
    setState(() {
      if (hostnameInput.text.isNotEmpty) {
        _hostname = hostnameInput.text;
      }

      if (portInput.text.isNotEmpty) {
        _port = ':${portInput.text}';
      } else
        _port = '';

      wsInput.text = "ws://$_hostname$_port";
      _wsAddress = "ws://$_hostname$_port";
    });
  }

  void _connectWS() {
    print(_wsAddress);
    _channel = IOWebSocketChannel.connect(_wsAddress);
    _channel.sink.add(messageInput.text);

    setState(() {
      _status = "Connected";
      _connected = true;
      kirim = _dataReceived;
    });
  }

  void _sendPing() {
    String send = _dataCount.toString();
    _channel.sink.add(send);
  }

  void _closeWS() {
    _channel.sink.close();
    _status = "Disconnected";
    setState(() {
      _connected = false;
    });
  }

  @override
  void dispose() {
//    //Close position subscribing
//    if (_positionStreamSubscription != null) {
//      _positionStreamSubscription.cancel();
//      _positionStreamSubscription = null;
//    }

    //Close websocket connection
    _channel.sink.close();
    super.dispose();
  }
}
