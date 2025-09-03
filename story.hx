import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Lib;
import openfl.events.Event;
import openfl.utils.Assets;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

class Main extends Sprite {
    
    var fotolar:Array<String> = ["assets/1.png", "assets/2.png", "assets/3.png", "assets/4.png", "assets/5.png"];
    var index:Int = 0;
    var bitmap:Bitmap;
    var zaman:Float = 0;

    public function new() {
        super();

        goster();

        // ESC tuşuna basıldığında çıkış
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent) {
            if (e.keyCode == Keyboard.ESCAPE) {
                Lib.exit();
            }
        });

        // her frame çağrılır
        Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    function onEnterFrame(e:Event):Void {
        zaman += 1 / stage.frameRate; // saniye say
        if (zaman >= 5) { // 5 saniye geçti
            zaman = 0;
            index++;
            if (index < fotolar.length) {
                goster();
            } else {
                // hikaye bittiğinde Menu.hx çağır
                Lib.current.removeChild(this);
                Lib.current.addChild(new Menu());
            }
        }
    }

    function goster():Void {
        if (bitmap != null) {
            removeChild(bitmap);
        }
        var data:BitmapData = Assets.getBitmapData(fotolar[index]);
        bitmap = new Bitmap(data);
        bitmap.width = stage.stageWidth;
        bitmap.height = stage.stageHeight;
        addChild(bitmap);
    }
}
