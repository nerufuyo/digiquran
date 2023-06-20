import 'package:digiquran/common/color.dart';
import 'package:digiquran/common/font.dart';
import 'package:digiquran/common/gap.dart';
import 'package:digiquran/presentation/widget/navigation_widget.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const routeName = '/splash_page';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void loadData() async {
    await Future.delayed(const Duration(seconds: 3)).then(
      (value) => {
        Navigator.pushReplacementNamed(context, NavigationWidget.routeName),
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Digi',
              style: firaSansH1.copyWith(color: secondaryColor, fontSize: 40),
            ),
            const HorizontalGap5(),
            Container(
              decoration: const BoxDecoration(
                color: secondaryColor,
              ),
              padding: const EdgeInsets.all(2),
              child: Text(
                'Quran',
                style: firaSansH1.copyWith(color: primaryColor, fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
