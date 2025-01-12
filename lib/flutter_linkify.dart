import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkify/linkify.dart';

export 'package:linkify/linkify.dart'
    show
        LinkifyElement,
        LinkifyOptions,
        LinkableElement,
        TextElement,
        Linkifier,
        UrlElement,
        UrlLinkifier,
        EmailElement,
        EmailLinkifier;

/// Callback clicked link
typedef LinkCallback = void Function(LinkableElement link);

const defaultLinkStyle = TextStyle(
  color: Colors.blueAccent,
  decoration: TextDecoration.underline,
);

const defaultLinkCursor = SystemMouseCursors.click;

/// Turns URLs into links
class Linkify extends Text {
  /// Text to be linkified
  final String text;

  /// Linkifiers to be used for linkify
  final List<Linkifier> linkifiers;

  /// Callback for tapping a link
  final LinkCallback? onOpen;

  /// linkify's options.
  final LinkifyOptions options;

  // TextSpan

  /// Style of link text
  final TextStyle? linkStyle;

  /// MouseCursor to show when hovering over links
  final MouseCursor? linkCursor;

  Linkify({
    super.key,
    required this.text,
    this.linkifiers = defaultLinkifiers,
    this.onOpen,
    this.options = const LinkifyOptions(),
    // TextSpan
    super.style,
    this.linkStyle = defaultLinkStyle,
    this.linkCursor = defaultLinkCursor,
    // SelectableText
    super.textAlign,
    super.textDirection,
    super.maxLines,
    super.textScaleFactor = 1.0,
    super.strutStyle,
    super.textWidthBasis,
    super.textHeightBehavior,
  }) : super.rich(
          LinkifySpan(
            text: text,
            options: options,
            linkifiers: linkifiers,
            onOpen: onOpen,
            linkStyle: linkStyle,
            linkCursor: linkCursor,
          ),
        );
}

/// Turns URLs into links
class SelectableLinkify extends SelectableText {
  /// Text to be linkified
  final String text;

  /// Linkifiers to be used for linkify
  final List<Linkifier> linkifiers;

  /// Callback for tapping a link
  final LinkCallback? onOpen;

  /// linkify's options.
  final LinkifyOptions options;

  // TextSpan

  /// Style of link text
  final TextStyle? linkStyle;

  /// MouseCursor to show when hovering over links
  final MouseCursor? linkCursor;

  SelectableLinkify({
    super.key,
    required this.text,
    this.linkifiers = defaultLinkifiers,
    this.onOpen,
    this.options = const LinkifyOptions(),
    // TextSpan
    super.style,
    this.linkStyle,
    this.linkCursor = defaultLinkCursor,
    // SelectableText
    super.textAlign,
    super.textDirection,
    super.minLines,
    super.maxLines,
    super.focusNode,
    super.textScaleFactor = 1.0,
    super.strutStyle,
    super.showCursor = false,
    super.autofocus = false,
    super.toolbarOptions,
    super.cursorWidth = 2.0,
    super.cursorRadius,
    super.cursorColor,
    super.dragStartBehavior = DragStartBehavior.start,
    super.enableInteractiveSelection = true,
    super.onTap,
    super.scrollPhysics,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.cursorHeight,
    super.selectionControls,
    super.onSelectionChanged,
  }) : super.rich(
          LinkifySpan(
            text: text,
            options: options,
            linkifiers: linkifiers,
            onOpen: onOpen,
            linkStyle: linkStyle ?? defaultLinkStyle,
            linkCursor: linkCursor,
          ),
        );
}

/// Raw TextSpan builder for more control on the RichText
TextSpan buildTextSpan(
  List<LinkifyElement> elements, {
  TextStyle? style,
  TextStyle? linkStyle = defaultLinkStyle,
  LinkCallback? onOpen,
  MouseCursor? linkCursor = defaultLinkCursor,
}) =>
    TextSpan(
      children: buildTextSpanChildren(
        elements,
        style: style,
        linkStyle: linkStyle,
        onOpen: onOpen,
        linkCursor: linkCursor,
      ),
    );

List<InlineSpan>? buildTextSpanChildren(
  List<LinkifyElement> elements, {
  TextStyle? style,
  TextStyle? linkStyle = defaultLinkStyle,
  LinkCallback? onOpen,
  MouseCursor? linkCursor = defaultLinkCursor,
}) =>
    [
      for (var element in elements)
        if (element is LinkableElement)
          TextSpan(
            text: element.text,
            style: linkStyle,
            recognizer: onOpen != null
                ? (TapGestureRecognizer()..onTap = () => onOpen(element))
                : null,
            mouseCursor: linkCursor,
          )
        else
          TextSpan(
            text: element.text,
            style: style,
          ),
    ];

class LinkifySpan extends TextSpan {
  LinkifySpan({
    required String text,
    TextStyle? linkStyle = defaultLinkStyle,
    LinkCallback? onOpen,
    LinkifyOptions options = const LinkifyOptions(),
    List<Linkifier> linkifiers = defaultLinkifiers,
    MouseCursor? linkCursor = defaultLinkCursor,
    super.style,
    super.recognizer,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.semanticsLabel,
    super.locale,
    super.spellOut,
  }) : super(
          children: buildTextSpanChildren(
            linkify(text, options: options, linkifiers: linkifiers),
            style: style,
            linkStyle: linkStyle,
            onOpen: onOpen,
            linkCursor: linkCursor,
          ),
        );
}
