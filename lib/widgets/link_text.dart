import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';

class LinkText extends StatefulWidget {
  final String text;

  final TextStyle? textStyle;

  final TextStyle? linkStyle;

  final TextAlign textAlign;

  final LaunchMode mode;

  final bool shouldTrimParams;

  final void Function(String url)? onLinkTap;

  final int? maxLines;

  const LinkText(
    this.text, {
    super.key,
    this.textStyle,
    this.linkStyle,
    this.textAlign = TextAlign.start,
    this.shouldTrimParams = false,
    this.onLinkTap,
    this.maxLines,
    this.mode = LaunchMode.externalApplication,
  });

  @override
  _LinkTextState createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  final _gestureRecognizers = <TapGestureRecognizer>[];
  final _regex = RegExp(r"(https?):\/\/(\.?[a-zA-Zㄱ-ㅎ가-힣0-9-@]+)+(:\d+)?(\/[a-zA-Zㄱ-ㅎ가-힣0-9-@]*)*\??[^.,!?:;'"
      r'"'
      r"`)}\]>\s\r\n]*");
  final _shortenedRegex = RegExp(r"(.*)\?");

  @override
  void dispose() {
    for (var recognizer in _gestureRecognizers) {
      recognizer.dispose();
    }

    super.dispose();
  }

  void _launchUrl(String url) async {
    if (widget.onLinkTap != null) {
      widget.onLinkTap!(url);
      return;
    }

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: widget.mode);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textStyle = widget.textStyle ?? themeData.textTheme.bodyMedium;
    final linkStyle = widget.linkStyle ?? themeData.textTheme.bodyMedium?.copyWith(color: GO.theme.linkColor);

    final links = _regex.allMatches(widget.text);

    if (links.isEmpty) {
      return Text(
        widget.text,
        style: textStyle,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }

    final textParts = widget.text.split(_regex);
    final textSpans = <TextSpan>[];

    int i = 0;

    for (var part in textParts) {
      textSpans.add(TextSpan(text: part, style: textStyle));

      if (i < links.length) {
        final link = links.elementAt(i).group(0) ?? '';
        String? shortenedLink;

        final recognizer = TapGestureRecognizer()..onTap = () => _launchUrl(link);

        if (widget.shouldTrimParams) {
          shortenedLink = _shortenedRegex.firstMatch(link)?.group(1);
        }

        _gestureRecognizers.add(recognizer);
        textSpans.add(
          TextSpan(
            text: shortenedLink ?? link,
            style: linkStyle,
            recognizer: recognizer,
          ),
        );

        i++;
      }
    }

    return Text.rich(
      TextSpan(children: textSpans),
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
