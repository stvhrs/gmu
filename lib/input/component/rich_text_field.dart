import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

/// A text-field that uses the `flutter_quill` package to create rich-text.
/// The rich-text can be saved in a `Delta` object which can be converted
/// to a JSON list.
/// ```dart
/// json = controller.document.toDelta().toJson();
/// ```
///
/// In turn, the JSON list can be converted into a quill document object using
/// ```dart
/// document = Document.fromJson(json);
/// ```
///
/// See also:
/// * [QuillRichText], widget for displaying a Quill rich-text
class RichTextField extends StatefulWidget {
  final QuillController controller;
  final String hintText;

  /// Creates a text-field for writing a Quill rich-text widget.
  /// The `controller` parameter must be provided.
  const RichTextField(
      {super.key,
      required this.controller,
      this.hintText = "Silakan mengetik"});

  @override
  State<RichTextField> createState() => _RichTextFieldState();
}

class _RichTextFieldState extends State<RichTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _showHint = true;

  @override
  void initState() {
    _updateShowHint();
    widget.controller.document.changes.listen(
      (_) => setState(_updateShowHint),
    );
    super.initState();
  }

  void _updateShowHint() {
    _showHint = widget.controller.document.toPlainText().trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        QuillToolbar.simple(
          controller: widget.controller,
          configurations: QuillSimpleToolbarConfigurations(
            embedButtons: FlutterQuillEmbeds.toolbarButtons(),
          ),
        ),
        const Divider(
          height: 0,
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _focusNode.requestFocus(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  if (_showHint)
                    Text(
                      widget.hintText,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  QuillEditor.basic(
                    focusNode: _focusNode,
                    controller: widget.controller,
                    configurations: QuillEditorConfigurations(
                      embedBuilders: kIsWeb
                          ? FlutterQuillEmbeds.editorWebBuilders()
                          : FlutterQuillEmbeds.editorBuilders(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

const toolbarToggleButtonStyle = QuillToolbarToggleStyleButtonOptions(
    iconSize: 10,
    iconTheme: QuillIconTheme(
        iconButtonSelectedData: IconButtonData(color: Colors.white),
        iconButtonUnselectedData: IconButtonData(color: Colors.grey)));

const config = QuillSimpleToolbarConfigurations(
    toolbarIconAlignment: WrapAlignment.start,
    headerStyleType: HeaderStyleType.buttons,
    toolbarSectionSpacing: 0,
    // customButtons: [QuillToolbarCustomButtonOptions()],
    toolbarIconCrossAlignment: WrapCrossAlignment.start,
    buttonOptions: QuillSimpleToolbarButtonOptions(
      underLine: toolbarToggleButtonStyle,
      strikeThrough: toolbarToggleButtonStyle,
      bold: toolbarToggleButtonStyle,
      inlineCode: toolbarToggleButtonStyle,
      italic: toolbarToggleButtonStyle,
    ),
    showDividers: true,
    showFontFamily: true,
    showFontSize: true,
    showBoldButton: true,
    showItalicButton: true,
    showSmallButton: true,
    showUnderLineButton: true,
    showLineHeightButton: true,
    showStrikeThrough: true,
    showInlineCode: true,
    showColorButton: true,
    showBackgroundColorButton: true,
    showClearFormat: true,
    showAlignmentButtons: true,
    showLeftAlignment: true,
    showCenterAlignment: true,
    showRightAlignment: true,
    showJustifyAlignment: true,
    showHeaderStyle: true,
    showListNumbers: true,
    showListBullets: true,
    showListCheck: true,
    showCodeBlock: true,
    showQuote: true,
    showIndent: true,
    showLink: true,
    showUndo: true,
    showRedo: true,
    showDirection: true,
    showSearchButton: true,
    showSubscript: true,
    showSuperscript: true,
    showClipboardCut: true,
    showClipboardCopy: true,
    showClipboardPaste: true);
