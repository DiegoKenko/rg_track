import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ShowLoading extends StatefulWidget {
  final Future Function()? tryAgain;
  final Duration duration;

  const ShowLoading({
    super.key,
    this.tryAgain,
    this.duration = const Duration(seconds: 5),
  });

  @override
  State<ShowLoading> createState() => _ShowLoadingState();
}

class _ShowLoadingState extends State<ShowLoading> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(widget.duration),
      builder: (BuildContext con, AsyncSnapshot snap) =>
          snap.connectionState == ConnectionState.waiting
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('Carregando...'),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      MdiIcons.closeOctagonOutline,
                      color: Colors.black26,
                      size: 100,
                    ),
                    const SizedBox(height: 8),
                    if (widget.tryAgain != null)
                      TextButton(
                          onPressed: () async {
                            setState(() {});
                            await widget.tryAgain?.call();
                          },
                          child: const Text('Tentar novamente')),
                  ],
                ),
    );
  }
}
