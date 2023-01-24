import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_all/flutter_html_all.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  SecondPageState createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  var htmlList = [];

  @override
  void initState() {
    htmlList.add('<h3>Image support</h3>');
    htmlList.add(
        '<img src=\'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png\' />');
    htmlList.add(
        '<img src=\'https://ai.esmplus.com/elcantomall/elcanto/promotion/GS/2210_2/1/A_1.jpg\' />');
    htmlList.add(
        '<img src=\'https://ai.esmplus.com/elcantomall/elcanto/promotion/GS/2210_2/1/B_2.jpg\' />');
    htmlList.add(
        '<img src=\'https://gi.esmplus.com/elcanto01/elcanto/num/1.jpg\' />');
    htmlList.add(
        '<img src=\'https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA99M24V.jpg\' />');
    htmlList.add(
        '<img src=\'https://gi.esmplus.com/elcanto01/elcanto/num/2.jpg\' />');
    htmlList.add(
        '<img src=\'https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA15M24V.jpg\' />');
    htmlList.add(
        '<img src=\'https://gi.esmplus.com/elcanto01/elcanto/num/3.jpg\' />');
    htmlList.add(
        '<img src=\'https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA58M24V.jpg\' />');
    htmlList.add(
        '<img src=\'https://gi.esmplus.com/elcanto01/elcanto/num/4.jpg\' />');
    htmlList.add(
        '<img src=\'https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA00M24V.jpg\' />');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_html Example'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_downward),
        onPressed: () {},
      ),
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CustomHtml(htmlList[index]);
              },
              childCount: htmlList.length,
            ),
          ),
        ]),
      ),
    );
  }
}

class CustomHtml extends StatefulWidget {
  const CustomHtml(this.html, {super.key});

  final String html;

  @override
  _CustomHtmlState createState() => _CustomHtmlState();
}

class _CustomHtmlState extends State<CustomHtml> {
  @override
  Widget build(BuildContext context) {
    print('customHtml > build');
    return Html(
      data: widget.html,
      customRenders: {
        networkSourceMatcher(extension: 'jpg'): networkImageRender(
          altWidget: (alt) => Text(alt ?? ""),
          loadingWidget: () => const Text("Loading..."),
        ),
      },
      onLinkTap: (url, _, __, ___) {
        debugPrint("Opening $url...");
      },
      onImageTap: (src, _, __, ___) {
        debugPrint(src);
      },
      onImageError: (exception, stackTrace) {
        debugPrint(exception.toString());
      },
      onCssParseError: (css, messages) {
        debugPrint("css that errored: $css");
        debugPrint("error messages:");
        for (var element in messages) {
          debugPrint(element.toString());
        }
        return '';
      },
    );
  }

  @override
  void dispose() {
    print('customHtml > dispose');
    super.dispose();
  }
}
