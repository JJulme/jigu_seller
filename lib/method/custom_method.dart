import 'dart:io';

class CustomMethod {
  assetEntity2File(List<dynamic> assetImages) async {
    // List<dynamic> imageFiles = assetImages.map((asset) => asset.file).toList();
    // return imageFiles;
    var imageFiles = [];
    for (var image in assetImages) {
      File imagePath = await image.file;
      imageFiles.add(imagePath);
    }
    return imageFiles;
  }
}
