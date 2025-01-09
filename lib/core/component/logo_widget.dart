import 'package:memmatch/core/package_loader/load_modules.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppMedia.abnerLogoImage,
      height: size,
      width: size,
      fit: BoxFit.contain,
    );
  }
}
