import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shopsyncseller/features/home/views/widgets/custom_appbar.dart';
import 'package:shopsyncseller/features/qr_code/views/componenets/qr_main_view_footer.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class QrMainView extends StatelessWidget {
  const QrMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Scaffold(
      appBar: CustomeHomeAppbar(),
      body: Padding(
        padding: size.scaledPadding(6, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: globalUid!,
            ),
            SizedBox(
              height: size.scaledHeight(2),
            ),
            Text(
              "Share this QR code with customers to let them view and purchase your products directly.",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.scaledHeight(2),
            ),
            QrMainViewFooter()
          ],
        ),
      ),
    );
  }
}
