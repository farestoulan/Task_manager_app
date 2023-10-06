import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/styles/color/color_manger.dart';

class LoadingDialog extends StatelessWidget {
  final bool isLoading;

  const LoadingDialog({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: isLoading,
      builder: (context) {
        return Stack(
          children: const [
            Opacity(
              opacity: 0.1,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
            Center(
              child: SpinKitCircle(
                color: ColorManager.primary,
                //  size: MediaQuery.of(context).size.width / 10,
              ),
            ),
          ],
        );
      },
      fallback: (context) {
        return const SizedBox();
      },
    );
  }
}
