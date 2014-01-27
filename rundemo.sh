#!/bin/sh
export PATH=$PWD/haxe/:$PATH
export HAXE_STD_PATH=$PWD/haxe/std

haxe  -js bin/hx2python.py -dce no -cp demo -cp src -cp src/python/_std -D python --macro "python.gen.PythonGenerator.use()" -main Main
