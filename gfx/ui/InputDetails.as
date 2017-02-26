﻿/*	An InputDetails object is generated by the InputDelegate, and contains relevant information about user input, such as controller buttons, keyboard keys, etc.
**	Attempted to match it closely to it's original file. ~ Greavesy
*/
class gfx.ui.InputDetails
{
	public var type:String;
	public var code:Number;
	public var value;
	public var navEquivalent:String;
	public var controllerIdx: Number;
   function InputDetails(type:String, code:Number, value, navEquivalent:String, controllerIdx:Number)
   {
		this.type = type;
		this.code = code;
		this.value = value;
		this.navEquivalent = navEquivalent;
		this.controllerIdx = controllerIdx;
   }
   function toString(): String
   {
      return ["[InputDelegate","code=" + this.code,"type=" + this.type,"value=" + this.value,"navEquivalent=" + this.navEquivalent,"controllerIdx=" + this.controllerIdx + "]"].toString();
   }
}
