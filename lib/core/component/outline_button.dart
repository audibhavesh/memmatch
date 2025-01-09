import 'package:memmatch/core/package_loader/load_modules.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white, // Background color blue
        minimumSize: Size(MediaQuery.of(context).size.width, 44),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: AppColors.primaryColor), // Border color blue
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.primaryColor), // Text color blue
      ),
    );
  }
}
