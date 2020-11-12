import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';

class ConnectionCallback extends StatefulWidget {
  ConnectionCallback({
    Key key,
    this.onlineCall,
  }) : super(key: key);

  final VoidCallback onlineCall;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ConnectionCallback> {
  void onlineCall() {
    widget.onlineCall();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      onlineCallback: onlineCall,
      //offlineCallback: offlineCall,
      showOfflineBanner: true,
      builder: (context, isOnline) => Center(),
    );
  }
}
