import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class ProductFormHeader extends StatefulWidget {
  final List<String> images;
  const ProductFormHeader({super.key, required this.images});

  @override
  State<ProductFormHeader> createState() => _ProductFormHeaderState();
}

class _ProductFormHeaderState extends State<ProductFormHeader> {
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    setState(() {
      widget.images.addAll(pickedFiles.map((file) => file.path).toList());
    });
  }

  Future<void> _captureImage() async {
    final XFile? capturedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (capturedImage != null) {
      setState(() {
        widget.images.add(capturedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.images.length + 1,
          (index) {
            if (index == widget.images.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: InkWell(
                  onTap: () {
                    _showImagePickerOptions(context);
                  },
                  child: Container(
                    width: size.scaledWidth(97),
                    height: size.scaledHeight(30),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 206, 234, 207),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Add Photo",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: size.scaledWidth(90),
                  height: size.scaledHeight(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(File(widget.images[index])),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImages();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _captureImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
