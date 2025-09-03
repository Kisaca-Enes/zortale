package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;

class SlideshowState extends FlxState
{
    public var fotolar:Array<String> = [
        "assets/images/1.png",
        "assets/images/2.png",
        "assets/images/3.png",
        "assets/images/4.png",
        "assets/images/5.png"
    ];

    public var index:Int = 0;
    public var current:FlxSprite;

    override public function create():Void
    {
        super.create();

        FlxG.camera.bgColor = FlxColor.BLACK;

        // İlk resmi yükle
        goster();

        // ESC tuşuna basınca çıkış
        FlxG.keys.preventDefaultKeys = [FlxKey.ESCAPE];
    }

    function goster():Void
    {
        if (current != null) remove(current);

        current = new FlxSprite(0, 0, fotolar[index]);
        current.setGraphicSize(FlxG.width, FlxG.height);
        current.updateHitbox();
        add(current);

        new FlxTimer().start(5, function(t:FlxTimer)
        {
            index++;
            if (index < fotolar.length)
            {
                goster();
            }
            else
            {
                FlxG.switchState(new MenuState());
            }
        });
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.exit();
        }
    }
}
