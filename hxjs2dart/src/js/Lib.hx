package js;
import js.html.CanvasElement;

@:native("Lib")
class Lib
{
    public function new()
    {
    }

    public static function getContextWebGL( canvas :CanvasElement, attribs :Dynamic ) {
        for (name in ["webgl", "experimental-webgl"]) {
            var ctx = (untyped canvas).getContext(name, attribs);
            if (ctx != null) return ctx;
        }
        return null;
    }
}
