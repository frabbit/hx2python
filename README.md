# Important

This project is obsolete since the python target was integrated into the haxe compiler: 
use https://github.com/HaxeFoundation/haxe instead!

# [hx2python][1]
##### A proof of concept [python][2] target for [haxe][3].

First of all thank to Andrew Vernon who created the [dart target][4] for haxe using the same technique as i'm using now for the python target.

## Quick Start Guide
1. Download and install [python][2] (currently only python 3 is supported).
2. Make sure the python3 executable is in your path environment variable.
3. compile and run demo :    haxe build.hxml

*As long as everything worked there should be a file named "hxpython.py" in the bin folder with output from the file traced to the terminal. Please note this is a very early proof of concept that has not been tested widely so may not work on all environments at this stage.*


## More Info

### Folder Structure

**src/**

-contains files required for python generation along with standard haxe classes. Contents of this file intended to end up in "std" folder of haxe install.

**src/haxe/macro/**

Contains macro classes required for [Custom JS Generation][5].

**src/python/_std/**

Contains versions of haxe standard files required for python target

**src/python/lib/**

Contains externs and type definitions for the python std lib.

**demo/**

Contains the demo application code.

**bin/**

Where the generated python file will be once the project is compiled.

#### Why does the generated python code look weird?

This is just a proof of concept and at the moment the only thing I'm really concerned with is getting python code generated in haxe to run by the python interpreter. 

###### Why is there only one .py file?
Python has a slightly different system for handling importing code from different modules or libraries while avoiding namespace clashes. The current implementation which joins the parts of a path using "_" ensures there are no namespace classes for Classes, Enums or Interfaces of the same name without having to worry about importing from multiple modules.




[1]:https://github.com/frabbit/hx2python
[2]:http://www.python.org/
[3]:http://haxe.org/
[4]:https://bitbucket.org/AndrewVernon/hx2dart
[5]:http://haxe.org/manual/macros_compiler#custom-js-generator
