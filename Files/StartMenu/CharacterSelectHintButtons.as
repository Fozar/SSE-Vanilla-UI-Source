class CharacterSelectHintButtons extends MovieClip
{
    var KEY_T, buttonArt_keyboard, DURANGO_Y, buttonArt_Durango, PS_Y, buttonArt_Orbis, textField, Label_mc, gotoAndStop, trackAsMenu, onPress, onRollOver, onRollOut, dispatchEvent;
    function CharacterSelectHintButtons()
    {
        super();
        gfx.events.EventDispatcher.initialize(this);
    } // End of the function
    function SetPlatform(aiPlatform)
    {
        buttonArt_keyboard = KEY_T;
        buttonArt_keyboard._visible = false;
        buttonArt_Durango = DURANGO_Y;
        buttonArt_Durango._visible = false;
        buttonArt_Orbis = PS_Y;
        buttonArt_Orbis._visible = false;
        Label_mc = textField;
        Label_mc.text = "$CharacterSelection";
        switch (aiPlatform)
        {
            case CharacterSelectHintButtons.CONTROLLER_PC:
            {
                buttonArt_keyboard._visible = true;
                this.gotoAndStop(1);
                this.EnableMouseControl();
                break;
            } 
            case CharacterSelectHintButtons.CONTROLLER_PC_GAMEPAD:
            case CharacterSelectHintButtons.CONTROLLER_DURANGO:
            {
                buttonArt_Durango._visible = true;
                this.gotoAndStop(2);
                break;
            } 
            case CharacterSelectHintButtons.CONTROLLER_ORBIS:
            {
                buttonArt_Orbis._visible = true;
                this.gotoAndStop(2);
                break;
            } 
        } // End of switch
    } // End of the function
    function EnableMouseControl()
    {
        trackAsMenu = true;
        onPress = ButtonClick;
        onRollOver = RollOver;
        onRollOut = RollOut;
    } // End of the function
    function ButtonClick(event)
    {
        this.dispatchEvent({type: "OnMousePressCharacterChange", target: this, data: []});
    } // End of the function
    function RollOver(event)
    {
        gfx.io.GameDelegate.call("PlaySound", ["UIMenuFocus"]);
        this.gotoAndStop(2);
    } // End of the function
    function RollOut()
    {
        this.gotoAndStop(1);
    } // End of the function
    static var CONTROLLER_PC = 0;
    static var CONTROLLER_PC_GAMEPAD = 1;
    static var CONTROLLER_DURANGO = 2;
    static var CONTROLLER_ORBIS = 3;
} // End of Class
