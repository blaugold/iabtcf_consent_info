// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:iabtcf_consent_info/iabtcf_consent_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IABTCF Consent Info Example',
      home: IabtcfConsentInfoViewer(),
    );
  }
}

class IabtcfConsentInfoViewer extends StatefulWidget {
  @override
  _IabtcfConsentInfoViewerState createState() =>
      _IabtcfConsentInfoViewerState();
}

class _IabtcfConsentInfoViewerState extends State<IabtcfConsentInfoViewer> {
  late Stream<BasicConsentInfo?> _consentInfoStream;

  @override
  void initState() {
    _consentInfoStream = IabtcfConsentInfo.instance.consentInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IABTCF Consent Info Example'),
      ),
      body: StreamBuilder<BasicConsentInfo?>(
        stream: _consentInfoStream,
        builder: (context, snapshot) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              snapshot.hasData
                  ? snapshot.data.toString()
                  : snapshot.hasError
                      ? 'Error: ${snapshot.error}'
                      : 'Loading...',
            ),
          ),
        ),
      ),
    );
  }
}
