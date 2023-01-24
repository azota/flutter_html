import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_all/flutter_html_all.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'flutter_html Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

const htmlData = r"""
      <h3>Image support:</h3>
      <h3>Network png</h3>
      <img src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br>
      <img src='https://ai.esmplus.com/elcantomall/elcanto/promotion/GS/2210_2/1/A_1.jpg' />
      <img src='https://ai.esmplus.com/elcantomall/elcanto/promotion/GS/2210_2/1/B_2.jpg' />
      <img src='https://gi.esmplus.com/elcanto01/elcanto/num/1.jpg' />
      <img src='https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA99M24V.jpg' />
      <img src='https://gi.esmplus.com/elcanto01/elcanto/num/2.jpg' />
      <img src='https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA15M24V.jpg' />
      <img src='https://gi.esmplus.com/elcanto01/elcanto/num/3.jpg' />
      <img src='https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA58M24V.jpg' />
      <img src='https://gi.esmplus.com/elcanto01/elcanto/num/4.jpg' />
      <img src='https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA00M24V.jpg' />
""";

final staticAnchorKey = GlobalKey();

class MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    print('customHtml > dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('customHtml > build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_html Example'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_downward),
        onPressed: () {
          final anchorContext =
              AnchorKey.forId(staticAnchorKey, "bottom")?.currentContext;
          if (anchorContext != null) {
            Scrollable.ensureVisible(anchorContext);
          }
        },
      ),
      body: SingleChildScrollView(
        child: Html(
          anchorKey: staticAnchorKey,
          data: htmlData,
          customRenders: {
            networkSourceMatcher(extension: 'jpg'): networkImageRender(
              altWidget: (alt) => Text(alt ?? ""),
              loadingWidget: () => const Text("Loading..."),
            ),
            /* networkSourceMatcher():
                networkImageRender(altWidget: (_) => const FlutterLogo()), */
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
        ),
      ),
    );
  }
}

CustomRenderMatcher texMatcher() =>
    (context) => context.tree.element?.localName == 'tex';

CustomRenderMatcher birdMatcher() =>
    (context) => context.tree.element?.localName == 'bird';

CustomRenderMatcher flutterMatcher() =>
    (context) => context.tree.element?.localName == 'flutter';
