package states;

import backends.Paths;
import backends.State;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends State
{
    public static var instance:PlayState;

    public var selected:Int = 0;
    public var menuChoices:Array<String> = ["FIGHT", "ACT", "ITEM", "MERCY"];

    public var menuTexts:Array<FlxText> = [];

    public var animActive:Bool = false;
    public var animStart:Float = 0;
    public var showKactin:Bool = false;
    public var showBagisla:Bool = false;

    public var messageText:FlxText;

    override public function create()
    {
        super.create();
        instance = this;

        // Menü seçeneklerini oluştur
        for(i in 0...menuChoices.length)
        {
            var t = new FlxText(50, 50 + i*50, 200, menuChoices[i]);
            t.size = 24;
            t.color = FlxColor.WHITE;
            add(t);
            menuTexts.push(t);
        }

        // Mesaj metni
        messageText = new FlxText(250, 200, 200, "");
        messageText.size = 32;
        messageText.color = FlxColor.YELLOW;
        messageText.visible = false;
        add(messageText);

        updateMenuColors();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        // Menü kontrolü
        if(FlxG.keys.justPressed.UP)
        {
            selected = (selected - 1 + menuChoices.length) % menuChoices.length;
            updateMenuColors();
        }
        else if(FlxG.keys.justPressed.DOWN)
        {
            selected = (selected + 1) % menuChoices.length;
            updateMenuColors();
        }

        // Enter tuşu
        if(FlxG.keys.justPressed.Z)
        {
            if(menuChoices[selected] == "MERCY")
            {
                animStart = FlxG.game.ticks;
                animActive = true;

                if(Math.random() < 0.5)
                {
                    showKactin = true;
                    showBagisla = false;
                }
                else
                {
                    showBagisla = true;
                    showKactin = false;
                }
            }
        }

        // Animasyon ve mesaj
        if(animActive)
        {
            var elapsedTime = FlxG.game.ticks - animStart;
            if(elapsedTime < 5000)
            {
                messageText.visible = true;
                if(showKactin) messageText.text = "Kaçtın";
                else if(showBagisla) messageText.text = "Bağışladın";
            }
            else
            {
                animActive = false;
                showKactin = false;
                showBagisla = false;
                messageText.visible = false;

                // TitleState'e geç
                FlxG.switchState(new TitleState());
            }
        }
    }

    private function updateMenuColors()
    {
        for(i in 0...menuTexts.length)
        {
            if(i == selected) menuTexts[i].color = FlxColor.YELLOW;
            else menuTexts[i].color = FlxColor.WHITE;
        }
    }
}
