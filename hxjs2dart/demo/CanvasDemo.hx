package ;
import js.Browser;
class CanvasDemo
{
    public function new()
    {
        var canvasElement = Browser.document.createCanvasElement();
        var context2d = canvasElement.getContext2d();
        context2d.fillStyle = "#ff00ff";
        context2d.fillRect(0, 0, 100, 100);

        Browser.document.getElementById("content").appendChild(canvasElement);

        var contextWebGL = canvasElement.getContextWebGL();   //path issue
    }
}
