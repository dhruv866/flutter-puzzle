import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;

Future<List<Image>> splitImage(List<int> input) async {
  // convert image to image from image package
  imglib.Image? image = await imglib.decodeImage(input);

  int x = 0, y = 0;
  int width = (image!.width / 3).round();
  int height = (image.height / 3).round();

  // split image to parts
  List<imglib.Image> parts = [];
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      parts.add(
        await imglib.copyCrop(image, x, y, width, height),
      );
      x += width;
    }
    x = 0;
    y += height;
  }

  // convert image from image package to Image Widget to display
  List<Image> output = [];
  if (parts.isNotEmpty) {
    for (var img in parts) {
      output.add(
        await Image.memory(
          base64Decode(base64Encode(imglib.encodeJpg(img))),
        ),
      );
    }
  }

  return output;
}
