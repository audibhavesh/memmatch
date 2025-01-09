import 'dart:convert';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:path/path.dart' as p;

String getFileNameFromUrl(String url) {
  return p.basename(url);
}

void download(String url) {
  // Encode our file in base64
  // final _base64 = base64Encode(url.codeUnits);
  // // Create the link with the file
  // final anchor =
  //     AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
  //       ..target = 'blank';
  //
  var downloadName = getFileNameFromUrl(url);
  // print("DOWNLOADD $downloadName");
  // // add the name
  // if (downloadName != null) {
  //   anchor.download = downloadName;
  // }
  // // trigger download
  // document.body?.append(anchor);
  // anchor.click();
  // anchor.remove();
  AnchorElement anchorElement =AnchorElement(href: url);
  anchorElement.download = downloadName;
  anchorElement.click();
  // window.open(url, downloadName);

  return;
}
