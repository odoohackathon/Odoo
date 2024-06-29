import 'package:flutter/material.dart';

class InternetExceptionWidget extends StatefulWidget {
  const InternetExceptionWidget({super.key});

  @override
  State<InternetExceptionWidget> createState() => _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map My Health"),
      ),
      body: WillPopScope(
        onWillPop: () => onWillPopScope(),
        child: Center(
          child: Text("No Internet")
        ),
      ),
    );
  }

  onWillPopScope() {
    setState(() {
      Navigator.pop(context);
    });
  }
}