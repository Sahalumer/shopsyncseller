import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
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
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    for (var file in pickedFiles) {
      final imageUrl = await _uploadImageToFirebase(File(file.path));
      if (imageUrl != null) {
        setState(() {
          widget.images.add(imageUrl);
        });
      }
    }
    setState(() {
      widget.images.addAll(pickedFiles.map((file) => file.path).toList());
    });
  }

  Future<String?> _uploadImageToFirebase(File file) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = _storage.ref().child('product_images/$fileName');
      final uploadTask = await ref.putFile(file);
      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> _captureImage() async {
    final XFile? capturedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (capturedImage != null) {
      final imageUrl = await _uploadImageToFirebase(File(capturedImage.path));

      if (imageUrl != null) {
        setState(() {
          widget.images.add(imageUrl);
        });
      }
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
