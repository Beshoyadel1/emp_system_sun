import 'package:flutter/material.dart';

import '../../../../core/utilies/map_of_all_app.dart';
import 'login_page/login_widgets/login_image.dart';
import 'login_page/login_widgets/version_widget.dart';

class AuthFormLayout extends StatelessWidget {
  const AuthFormLayout({
    super.key,
    required this.child,
    this.header,
    this.showImage = true,
    this.showVersion = true,
  });

  final Widget child;
  final Widget? header;
  final bool showImage;
  final bool showVersion;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              if (header != null) header!,
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (showVersion)
                const SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: VersionWidget(),
                  ),
                ),
            ],
          ),
        ),
        if (showImage &&
            MediaQuery.sizeOf(context).width > ValuesOfAllApp.mobileWidth)
          const LoginImage(),
      ],
    );
  }
}
