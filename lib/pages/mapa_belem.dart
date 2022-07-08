import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapaBelem extends StatefulWidget {
  const MapaBelem({Key? key}) : super(key: key);

  @override
  State<MapaBelem> createState() => _MapaBelem();
}

class _MapaBelem extends State<MapaBelem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Belem'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            tooltip: 'Show Snackbar',
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('SEMMA'),
                content: const Text(
                    'Mapa original disponivel em: \n https://semma.belem.pa.gov.br/tabela-de-coleta-seletiva/'
                    ' \n Feito por Cinbesa\n Um ofereciento Prefeitura de Belém'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: WebView(
        initialUrl:
            'https://www.google.com/maps/d/embed?mid=1XiuR6sk2cxKmke98KjRP-vq3BGo&ehbc=2E312F',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
