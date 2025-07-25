import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tasknotate/core/constant/imageasset.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class FlagIcon extends StatelessWidget {
  final IconData? iconforflag;
  final double leftpostion;
  final Color? colorflag;
  final String typeflag;

  const FlagIcon({
    super.key,
    this.iconforflag,
    required this.leftpostion,
    this.colorflag,
    required this.typeflag,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: context.scaleConfig.scale(0),
      left: context.scaleConfig.scale(leftpostion),
      child: ClipPath(
        clipper: FlagClipper(scaleConfig: context.scaleConfig),
        child: _buildFlagContent(context, context.scaleConfig),
      ),
    );
  }

  Widget _buildFlagContent(BuildContext context, ScaleConfig scaleConfig) {
    if (typeflag == "flagged") {
      return Container(
        height: scaleConfig.scale(35),
        width: scaleConfig.scale(30),
        color: colorflag ?? Theme.of(context).colorScheme.secondary,
        alignment: Alignment.center,
        child: Icon(
          iconforflag,
          size: scaleConfig.scale(16),
          color: Colors.white,
        ),
      );
    } else if (typeflag == "imageuncheck") {
      return SizedBox(
        height: scaleConfig.scale(40),
        child: LottieBuilder.asset(
          AppImageAsset.taskunchecked,
          repeat: false,
        ),
      );
    } else {
      return SizedBox(
        height: scaleConfig.scale(40),
        child: LottieBuilder.asset(
          AppImageAsset.checked2,
          repeat: false,
        ),
      );
    }
  }
}

class FlagClipper extends CustomClipper<Path> {
  final ScaleConfig scaleConfig;

  FlagClipper({required this.scaleConfig});

  @override
  Path getClip(Size size) {
    print('Clipper Size: width=${size.width}, height=${size.height}');
    if (size.width <= 0 || size.height <= 0) {
      return Path(); // Return empty path to avoid rendering issues
    }
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - scaleConfig.scale(10));
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height - scaleConfig.scale(10));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
