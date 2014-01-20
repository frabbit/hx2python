#!/bin/sh
export PATH=$PWD/haxe/:$PATH
export HAXE_STD_PATH=$PWD/haxe/std
cd haxe/tests/unit
haxe compile-each.hxml -D fail_eager -dce no -cp ../../../src -cp ../../../src/python/_std -main unit.Test -js ../../../unit.py -D python --macro 'python.gen.PythonGenerator.use()'
