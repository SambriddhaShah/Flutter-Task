import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.withOpacity(0.55),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text("  Loading...", style: TextStyle(color: Colors.purple)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
