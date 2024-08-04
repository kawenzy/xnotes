import 'dart:io';
import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

class Editor extends StatefulWidget {
  final String path;
  const Editor({super.key, required this.path});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    return ProImageEditor.file(
      File(widget.path),
      callbacks: ProImageEditorCallbacks(
        onImageEditingComplete: (bytes) async {
          var random = Random.secure();
          int masa = random.nextInt(120);
          int nums = random.nextInt(200) * masa;
          final dir = await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DCIM);
          final Directory dirf = Directory('$dir/xenotes');
          File filed =
              await File('${dirf.path}/$nums.jpg').create(recursive: true);
          await filed.writeAsBytes(bytes);
          Navigator.pop(context);
        },
      ),
      configs: ProImageEditorConfigs(
        imageGenerationConfigs: ImageGeneratioConfigs(jpegQuality: 100,pngLevel: 0,outputFormat: OutputFormat.png),
          textEditorConfigs: TextEditorConfigs(
              autocorrect: false,
              initialBackgroundColorMode: LayerBackgroundMode.backgroundAndColorWithOpacity,
              customTextStyles: [
                GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ]),
          theme: ThemeData.dark(useMaterial3: true),
          designMode: ImageEditorDesignModeE.material,
          imageEditorTheme: ImageEditorTheme(
              background: Color.fromARGB(255, 8, 8, 8),
              blurEditor:
                  BlurEditorTheme(background: Color.fromARGB(255, 8, 8, 8)),
              cropRotateEditor: CropRotateEditorTheme(
                  background: Color.fromARGB(255, 8, 8, 8)),
              filterEditor:
                  FilterEditorTheme(background: Color.fromARGB(255, 8, 8, 8)),
              paintingEditor:
                  PaintingEditorTheme(background: Color.fromARGB(255, 8, 8, 8)),
              textEditor: TextEditorTheme(
                  inputCursorColor: Colors.white,
                  inputHintColor: Colors.blueGrey.shade400,
                  textFieldMargin: EdgeInsets.all(20),
                  fontSizeBottomSheetTitle:
                      GoogleFonts.ubuntu(fontWeight: FontWeight.w600))),
          customWidgets: const ImageEditorCustomWidgets(
              loadingDialog: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
              circularProgressIndicator: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              )),
    );
  }
}
