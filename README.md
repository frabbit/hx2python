#[hx2dart] [1]
#####A proof of concept [dart][2] target for [haxe][3].


## Quick Start Guide
1. Download and extract [dart](https://www.dartlang.org/#get-started).
2. open build.hxml and replace "PARTH_TO_DART" with the location of the extracted download.
3. compile and run demo :    haxe build.hxml

*As long as everything worked there should be a file named "hxdart.dart" in the bin folder with output from the file traced to the terminal. Please note this is a very early proof of concept that has not been tested widely so may not work on all environments at this stage.*

To view a sample dart web app see [samples/helloworld]("samples/helloworld")

*see also: [hxjs2dart][5]*

## More Info

###Folder Structure

**src/**

-contains files required for dart generation along with standard haxe classes. Contents of this file intended to end up in "std" folder of haxe install.

**src/haxe/macro/**

Contains macro classes required for [Custom JS Generation][4].

**src/dart/_std/**

Contains versions of haxe standard files required for dart target

**demo/**

Contains the demo application code.

**bin/**

Where the generated dart file will be once the project is compiled.

**hxjs2dart**

Another proof of concept intended to be an external haxelib which cross compiles projects using the haxejs API's to the equivalent for dart.

**hxdart2js**

The opposite of hxjs2dart, hxdart2js is also intended to be an external haxelib which cross compiles haxe projects using the dart API to the equivalent for javascript. 

####Why target dart?
1. [Perfomance](https://www.dartlang.org/performance/) - Althoughit hasn't been officially released yet there should be major performance improvements for web apps running in the dart vm compared to the equivalent javascript project. Apparently the VM has also been architected to allow it to increasingly improve in perfomance at a rate which the same engineers believe they will no longer be able to achieve for the V8 javascript envine.
2. The dart VM is a language VM ([no byte code](https://www.dartlang.org/articles/why-not-bytecode/)) and the syntax is similar to haxe with bits of other languages already targeted by haxe mixed in. Most of the code currently being used to generate dart is directly ported from the haxe.macro.Printer, although it will change more as things progress. For these reasons a dart target should be less complex and a relatively easy win compared to other targets.
3. Along with the potential performance improvements achieved by targeting the dartVM in the browser, the standalone dartVM has potential to be very useful.
4. Why not?

####Isn't dart a competitor with Haxe?
Not really. Both languages do compile to javascript but that's about the only area they could be considered competitors in my opinion. I'm not particularily interested in the dart2js compilation at the moment because haxe already has a really good JS target, but I think the dartVM once embeded in Chrome browser could be a really important target for haxe in the future.  

####Why compile using the JS target instead of a new dart target?
1. I'm not very good at OCAML yet (although I now understand a lot more about haxe after reading up on OCAML and hacking around in the haxe source).
2. This will allow anyone with haxe3 installed to generate dart as well as edit and hopefully contribute to the generators using haxe macro and pattern matching syntax without having to compile a new version of haxe from source. 
3. It should provide faster iteration of changes particularily as dart hasn't been officially released yet and there may still be breaking changes.
4. Dart is also a dynamic language with [optional types](https://www.dartlang.org/articles/optional-types/) and there are [no negative performance implications](https://www.dartlang.org/articles/why-dart-types/#dont-you-want-strong-typing-for-better-performance) by not declaring types (although this will hopefully be an included option for debugging purposes soon).


####Why does the generated dart look weird?

This is just a proof of concept and at the moment the only thing I'm really concerned with is getting dart code generated in haxe to run in the dartVM. 

######Why is there only one .dart file?
Dart has a slightly different system for handling importing code from different modules or libraries while avoiding namespace clashes. The current hx2dart implementation which joins the parts of a path using "_" ensures there are no namespace classes for Classes, Enums or Interfaces of the same name without having to worry about importing from multiple modules.

Anyone can change this by editing the DartGenerator.hx code and it would be great compare some different solutions to this and potentially offer different options at compile time depending on the intended use of the generated dart. At the very least I think any final dart target should have a similar [Custom Generator][4] option to the JS target to allow anyone to customise this type of thing.

The [dart2js](https://www.dartlang.org/docs/dart-up-and-running/contents/ch04-tools-dart2js.html) compiler includes the option to merge all dart source files into one before deployment and can minify the class names anyway so there is little difference in the final on this issue if the hx2dart output is also minified. 


####What will be involved in getting a current haxe project to run in dart?
1. First we need stable haxe2dart generation for the core haxe language features and standard libraries.
2. Externs will be needed for the core dart libraries such as "dart:html".
3. Next it will depend on how much platform specific code the project uses. For current projects targeting js there is another proof of concept [hxjs2dart][5] which is intended to abstract any differences between the js and dart API's without needing to manually port an code. 











[1]:https://bitbucket.org/AndrewVernon/hx2dart
[2]:https://www.dartlang.org/
[3]:http://haxe.org/
[4]:http://haxe.org/manual/macros_compiler#custom-js-generator
[5]:https://bitbucket.org/AndrewVernon/hx2dart/src/deb246ff7c0c1bf35577e500c855f63dc90c9c56/hxjs2dart?at=development