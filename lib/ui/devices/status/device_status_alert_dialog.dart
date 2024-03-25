import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/ui/devices/status/device_status_cubit.dart';
import 'package:rg_track/ui/devices/status/device_status_state.dart';

class DeviceStatusStatusAlertDialog extends StatefulWidget {
  const DeviceStatusStatusAlertDialog({
    super.key,
    required this.device,
  });
  final Device device;

  @override
  State<DeviceStatusStatusAlertDialog> createState() =>
      _DeviceStatusStatusAlertDialogState();
}

class _DeviceStatusStatusAlertDialogState
    extends State<DeviceStatusStatusAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 200,
        width: 400,
        child: BlocBuilder<DeviceStatusCubit, DeviceStatusState>(
          bloc: context.read<DeviceStatusCubit>()
            ..loadDeviceStatus(widget.device),
          builder: (context, state) {
            if (state is DeviceStatusLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DeviceStatusErrorState) {
              return Text(state.exception.message);
            }
            if (state is DeviceStatusSuccessfulState) {
              return Text(state.status.lastActiveFormatted);
            }
            return const Text('');
          },
        ),
      ),
    );
  }
}
