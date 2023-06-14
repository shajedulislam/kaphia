// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

String? fileNameFinder(String? filePath) {
  if (filePath != null) {
    return filePath.split(Platform.pathSeparator).last;
  }
  return null;
}
