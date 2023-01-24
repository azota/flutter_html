import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sliver_tools/sliver_tools.dart';

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

final staticAnchorKey = GlobalKey();

class MyHomePageState extends State<MyHomePage> {
  var htmlList = [];

  @override
  void initState() {
    htmlList.add('<h3>Image support</h3>');
    htmlList.add(
        '<img alt="" src="https://ai.esmplus.com/elcantomall/elcanto/promotion/GS/2210_2/1/A_1.jpg">');
    htmlList.add(
        '<img alt="" src="https://ai.esmplus.com/elcantomall/elcanto/promotion/GS/2210_2/1/B_2.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://gi.esmplus.com/elcanto01/elcanto/num/1.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA99M24V.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://gi.esmplus.com/elcanto01/elcanto/num/2.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA15M24V.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://gi.esmplus.com/elcanto01/elcanto/num/3.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA58M24V.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA00M24V.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://gi.esmplus.com/elcanto01/elcanto/num/5.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA02M24V.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://gi.esmplus.com/elcanto01/elcanto/num/6.jpg">');
    htmlList.add(
        '<img style="" alt="" src="https://ai.esmplus.com/elcantomall/elcanto/product/D_LCWA47M24V.jpg">');

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
        onPressed: () {
          final anchorContext =
              AnchorKey.forId(staticAnchorKey, "bottom")?.currentContext;
          if (anchorContext != null) {
            Scrollable.ensureVisible(anchorContext);
          }
        },
      ),
      body: SafeArea(
        child: CustomScrollView(slivers: [
          const SliverAppBar(
            pinned: false, // appbar 완전히 사라지게
            expandedHeight: 250.0, // appbar 크기
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '타이틀',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              centerTitle: true,
              background: FlutterLogo(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Text('Text'),
              height: 100,
            ),
          ),
          /* SliverToBoxAdapter(
            child: Container(
              //높이지정 안하면 스크롤 안되고
              //지정하면 자식영역에서만 스크롤됨 (전체화면 스크롤 안됨)
              /* height: 200, */
              child: ListView.builder(
                  /* physics: const AlwaysScrollableScrollPhysics(), */
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: htmlList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomHtml(htmlList[index]);
                  }),
            ),
          ), */
          MultiSliver(
            children: [
              const SliverAppBar(
                backgroundColor: Colors.green,
                title: Text('Have a nice day'),
                floating: false,
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: [
                        Container(
                          child: Text('상세설명'),
                        ),
                        ListView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: htmlList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomHtml(htmlList[index]);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Text('Text'),
              height: 200,
            ),
          ),
          /* SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CustomHtml(htmlList[index]);
              },
              childCount: htmlList.length,
            ),
          ), */
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
  void initState() {
    print('yhpark > CustomHtml > initState');
    super.initState();
  }

  @override
  void dispose() {
    print('yhpark > CustomHtml > dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('yhpark > CustomHtml > build');
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
}
