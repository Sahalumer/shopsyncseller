import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'dart:ui';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';

class QrMainViewFooter extends StatelessWidget {
  const QrMainViewFooter({super.key});
  Future<void> _shareQrCode(BuildContext context) async {
    try {
      final boundaryKey = GlobalKey();
      await showDialog(
        context: context,
        builder: (_) => Dialog(
          child: RepaintBoundary(
            key: boundaryKey,
            child: QrImageView(
              data: globalUid!,
              size: 200,
            ),
          ),
        ),
      );

      final boundary = boundaryKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qr_code.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)],
          text: 'Scan this QR code to view my products!');
    } catch (e) {
      print("Error sharing QR code: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Padding(
      padding: size.scaledPadding(10, 0),
      child: InkWell(
        onTap: () => _shareQrCode(context),
        child: Container(
          height: size.scaledHeight(7),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(148, 2, 139, 252),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              "Share Your QR Code",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
