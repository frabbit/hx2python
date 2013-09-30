#Hello World

This sample contains a haxe version of the Hello World sample from [dartlang.org/samples](https://www.dartlang.org/samples/) to be compiled to [dart](https://www.dartlang.org/) using [hx2dart][1].

The [haxe][4] source uses the current haxe js [API][2] to manipulate the DOM. For the dart output this is cross compiled to the dart html [API][3] using hxjs2dart.

To compile:

1. Edit build.hxml replacing "$DART_SDK" with the path to the dart SDK;
2. run haxe build.hxml

For comparison the following output is compiled or included in the bin folder:

* **[dart.dart](bin/dart.dart)** : original dart source
* **[hxdart.dart](bin/hxdart.dart)** : dart output compiled by haxe
* **[hxjs.js](bin/hxjs.js)** : javascript output compiled by haxe
* **[dart2js.js](bin/dart2js.js)** : javascript output compiled by dart2js
* **[dart.min.dart](bin/dart.min.dart)** : minified dart output from dart source compiled by dart2js
* **[hxdart.min.dart](bin/hxdart.min.dart)** : minified dart output from hx2dart source compiled by dart2js


Each version has a corresponding html file. The Chromium browser included in the dart SDK must be used to view the dart versions. 


 





[1]:https://bitbucket.org/AndrewVernon/hx2dart
[2]:http://api.haxe.org/js/index.html
[3]:http://api.dartlang.org/docs/releases/latest/dart_html.html
[4]:http://haxe.org/]
[5]:http://www.haxejs.org/
[6]:https://www.dartlang.org/docs/dart-up-and-running/contents/ch04-tools-dart2js.html
