#hxjs2dart
#####A proof of concept to cross compile [haxe][3] projects that access the [js API](http://api.haxe.org/js/index.html) to [dart][2] source code using [hx2dart][1].

*please note very little of the work has actually been done despite most of the js API being present in this project*


## Quick Start Guide
1. follow [Haxe2Dart Generator - Quick Start Guide](https://bitbucket.org/AndrewVernon/haxe2dart-generator/overview)
2. compile and view samples in the samples folder.



## More Info

###Folder Structure
**src/js**

Contains versions of the std/js haxe externs and utilities that produce valid dart code instead of the original j.

**demo**

Contains the demo application code.

**bin**

Contains an html file for both dart and js versions of the demo to be viewed in the chromium browser.

**samples/**

Haxe versions of [dart samples](https://www.dartlang.org/samples/) including hxjs2dart, hxdart, hxjs, dart2js and original dart source for comparision.

####What's the point?
If successful this library will allow any haxe3 projects targeting js to also target dart without the need to manually port any code.

####What are the differences between the js and dart API's.
So far the differences I've come across have been fairly minor. While one of the aims of dart is to clean up the DOM API for browser based apps most of the original js API is still there. 

#####Events have been cammelCased

js

	onevent
	
dart

	onEvent
	
 
this is easily handled with some inline getters and setters for the field. 

js

	var onabort: EventListener;
	
dart

	var onabort(get, set) : EventListener;
    private inline function get_onabort():EventListener return untyped this.onAbort;
    private inline function set_onabort(e:EventListener):EventListener {
    	 return untyped this.onAbort.listen(e);
   	}

Even though this looks like a lot more code, the only difference in the generated output is the camelCasing because the getter and setter are inlined.


#####Renaming of methods/fields
Method and field names have also been rationalised to be more consistent in the dart API however these can also easily be handled with inline methods.










[1]:https://bitbucket.org/AndrewVernon/hx2dart
[2]:https://www.dartlang.org/
[3]:http://haxe.org/
[4]:http://haxe.org/manual/macros_compiler#custom-js-generator
