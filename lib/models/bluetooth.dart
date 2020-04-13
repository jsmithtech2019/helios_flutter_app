/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: bluetooth.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/global.dart';
import 'package:HITCH/models/bt_widgets.dart';

// Utils
//import 'package:HITCH/utils/database_helper.dart';
import 'package:HITCH/utils/home_widget.dart';

/// Generate an instance of [GlobalHelper]
/// 
/// This is used throughout the bluetooth application
final GlobalHelper globalHelper = GetIt.instance<GlobalHelper>();

/// Class for the main Bluetooth page
/// 
/// Will either draw the [FindDevicesScreen] or an error message requesting the
/// user to enable bluetooth on the device. The error popup routes back to
/// the settings page.
class BluetoothPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
      stream: FlutterBlue.instance.state,
      initialData: BluetoothState.unknown,
      builder: (c, snapshot) {
        final state = snapshot.data;
        if (state == BluetoothState.on) {
          return FindDevicesScreen();
        }
      return Scaffold(
        appBar: AppBar(
          title: Text("Available Devices"),
        ),
        body: AlertDialog(
          title: Text('Bluetooth not enabled!\n\nPlease enable bluetooth before '
            'attempting to pair modules.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => Home(2)
                  ),
                  (Route<dynamic> route) => false
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

/// Screen used to display available devices in range
/// 
/// This screen searchs a stream of devices found by bluetooth and then displays
/// them to the user in a series of [ScanResult] objects. There is filtering
/// to only allow HITCH modules to appear in these results. Will also draw a 
/// button (as well as pull down from top) to refresh results and search again.
/// 
/// These devices can then be paired to and used for testing, pairing to a device
/// will draw a [DeviceScreen] for the selected device to gather information about
/// it before returning to the main page.
class FindDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Generate stream of bluetooth devices found
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data.map((d) => ListTile(
                    title: Text(d.name),
                    subtitle: Text(d.id.toString()),
                    trailing: StreamBuilder<BluetoothDeviceState>(
                      stream: d.state,
                      initialData: BluetoothDeviceState.disconnected,
                      builder: (c, snapshot) {
                        if (snapshot.data ==
                            BluetoothDeviceState.connected) {
                          return RaisedButton(
                            child: Text('OPEN'),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DeviceScreen(device: d))),
                          );
                        }
                        return Text(snapshot.data.toString());
                      },
                    ),
                  )).toList(),
                ),
              ),
              // Generate list of scanned devices and display them in column
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data.map((r) {
                    // Only display HITCH modules
                    if(r.advertisementData.localName.contains('HELIOS') || r.advertisementData.localName.contains('HITCH')){
                      return ScanResultTile(
                        result: r,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            return DeviceScreen(device: r.device);
                          })
                        ),
                      );
                    } else {
                      // Cannot return a null object so return empty container
                      return Container();
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}

/// Displays information about the selected HITCH module
/// 
/// Displays information such as characteristics and services for the paired
/// module. These will likely be removed in the future to not confuse the 
/// operator.
/// 
/// Also inserts a [BluetoothDevice] singleton into the [GetIt] handler to allow
/// bluetooth to be accessed by all pages of the application (if one has not been
/// created already).
class DeviceScreen extends StatelessWidget {
  /// Default constructor
  const DeviceScreen({Key key, this.device}) : super(key: key);

  /// Generate the [BluetoothDevice] object for the paired device
  final BluetoothDevice device;

  /// Testing function to change values and debug the TI-RTOS system
  List<int> _getRandomBytes() {
    //final math = Random();
    var t = [150, 150];
    return t; 
  }

  /// Create a list of services that the device offers
  /// 
  /// Useful for developement
  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services.map((s) => ServiceTile(
        service: s,
        characteristicTiles: s.characteristics.map((c) => CharacteristicTile(
            characteristic: c,
            onReadPressed: () => c.read(),
            onWritePressed: () => c.write(_getRandomBytes()),
            onNotificationPressed: () =>
                c.setNotifyValue(!c.isNotifying),
            descriptorTiles: c.descriptors.map((d) => DescriptorTile(
                descriptor: d,
                onReadPressed: () => d.read(),
                onWritePressed: () => d.write(_getRandomBytes()),
              ),
            ).toList(),
          ),
        ).toList(),
      ),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        .copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => device.discoverServices(),
                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data),
                );
              },
            ),
            RaisedButton(
                onPressed: () {
                  globalHelper.adminData.moduleUUID = device.id.toString();
                  // Add only so it doesn't screw the settings page
                  globalHelper.bluetoothDevice = device;

                  // Register device on GetIt instance
                  GetIt sl = GetIt.instance;

                  // Attempt to register singleton
                  try {
                    sl.registerSingleton<BluetoothDevice>(device);
                  } catch (e) {
                    // Singleton failed to register, may have already been registered
                    print('Failed to register singleton: $e');
                  }

                  // Return to TestingPage
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => Home(0)),
                      (Route<dynamic> route) => false);
                }, // onPressed
                child: Text('Return to Home Page'),
              ),
          ],
        ),
      ),
    );
  }
}