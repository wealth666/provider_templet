import 'package:flutter/cupertino.dart';
import 'package:provider_templet/src/widget/config_processor.dart';
import 'package:provider_templet/src/widget/provider_templet.dart';

class ProviderTempletConfiguration extends StatefulWidget {
  Widget child;

  ConfigProcessor? processor;

  ProviderTempletConfiguration({Key? key, required this.child, this.processor})
      : super(key: key);

  @override
  _ProviderTempletConfigurationState createState() =>
      _ProviderTempletConfigurationState();
}

class _ProviderTempletConfigurationState
    extends State<ProviderTempletConfiguration> {
  @override
  void initState() {
    ProviderTemplet.setUp(widget.processor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
