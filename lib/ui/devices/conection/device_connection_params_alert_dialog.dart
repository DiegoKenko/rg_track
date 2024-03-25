import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/ui/devices/conection/cubit/device_connection_cubit.dart';
import 'package:rg_track/ui/devices/conection/cubit/device_connection_state.dart';

class DeviceConnectionParamsAlertDialog extends StatefulWidget {
  const DeviceConnectionParamsAlertDialog({
    super.key,
    required this.device,
  });
  final Device device;

  @override
  State<DeviceConnectionParamsAlertDialog> createState() =>
      _DeviceConnectionParamsAlertDialogState();
}

class _DeviceConnectionParamsAlertDialogState
    extends State<DeviceConnectionParamsAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        height: 200,
        width: 400,
        child: BlocBuilder<DeviceConnectionCubit, DeviceConnectionState>(
          bloc: context.read<DeviceConnectionCubit>()
            ..loadDeviceConnectionParams(widget.device),
          builder: (context, state) {
            if (state is DeviceConnectionLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DeviceConnectionLoadErrorState) {
              return Text(state.exception.message);
            }
            if (state is DeviceConnectionLoadSuccessfulState &&
                state.channel.host != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'Parâmetros para conexão'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            const Text('SERVIDOR: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(state.channel.host ?? ''),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            const Text('PORTA: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(state.channel.port ?? ''),
                          ],
                        ),
                      ],
                    ),
                  ),
                  /*       Expanded(
                      child: InkWell(
                          onTap: () => context
                              .read<DeviceConnectionCubit>()
                              .connectCommand(widget.device, state.channel),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: primaryColor, width: 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Row(
                              children: [
                                Text(
                                  'Conectar',
                                ),
                                Spacer(),
                                Icon(Icons.sms),
                              ],
                            ),
                          ),),) */
                ],
              );
            }
            return const Text('');
          },
        ),
      ),
    );
  }
}
