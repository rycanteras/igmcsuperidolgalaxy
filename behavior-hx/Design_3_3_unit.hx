package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_3_3_unit extends ActorScript
{          	
	
public var _Parameters:Map<String,Dynamic>;

public var _ACTION:String;

public var _State:Map<String,Dynamic>;

public var _Meters:Map<String,Dynamic>;

public var _Modifiers:Map<String,Dynamic>;

public var _TempVar:Map<String,Dynamic>;

public var _FloorCol:Array<Dynamic>;
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __pointX __pointY */
public function _customBlock_COMMAND_FLY(__pointX:Float, __pointY:Float):Void
{
var __Self:Actor = actor;
        if(!(_Modifiers.exists("frozen")))
{
            if(!(_ACTION == "rally"))
{
                if(_Modifiers.exists("fly"))
{
                    _TempVar.set("angle", Utils.DEG * (Math.atan2((__pointY - __Self.getYCenter()), (__pointX - __Self.getXCenter()))));
                    if(_Modifiers.exists("missle"))
{
                        actor.setVelocity(_TempVar.get("angle"), (_Parameters.get("moveSpeed") * 10));
                        _ACTION = "fly";
propertyChanged("_ACTION", _ACTION);
}

                    else if(_Modifiers.exists("gravity"))
{
                        actor.setVelocity(_TempVar.get("angle"), (_Parameters.get("moveSpeed") * 0.25));
                        _ACTION = "hover";
propertyChanged("_ACTION", _ACTION);
}

                    else if(_Modifiers.exists("hasted"))
{
                        actor.setVelocity(_TempVar.get("angle"), (_Parameters.get("moveSpeed") * 2));
                        _ACTION = "fly";
propertyChanged("_ACTION", _ACTION);
}

                    else if(_Modifiers.exists("paralyzed"))
{
                        actor.setVelocity(_TempVar.get("angle"), (_Parameters.get("moveSpeed") * 0.1));
                        _ACTION = "hover";
propertyChanged("_ACTION", _ACTION);
}

                    else if(_Modifiers.exists("slowed"))
{
                        actor.setVelocity(_TempVar.get("angle"), (_Parameters.get("moveSpeed") * 0.35));
                        _ACTION = "hover";
propertyChanged("_ACTION", _ACTION);
}

                    else
{
                        actor.setVelocity(_TempVar.get("angle"), (_Parameters.get("moveSpeed") * 1));
                        _ACTION = "hover";
propertyChanged("_ACTION", _ACTION);
}

                    if(!(_Modifiers.exists("rotating")))
{
                        if((_ACTION == "fly"))
{
                            __Self.growTo(100/100, 100/100, 0, Linear.easeNone);
                            __Self.setAngle(Utils.RAD * (_TempVar.get("angle")));
}

                        else
{
                            if((__pointX > __Self.getXCenter()))
{
                                __Self.growTo(100/100, 100/100, 0, Linear.easeNone);
}

                            else if((__pointX < __Self.getXCenter()))
{
                                __Self.growTo(-100/100, 100/100, 0, Linear.easeNone);
}

}

}

                    actor.shout("_customEvent_" + "ANIMATE");
}

}

}

}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Angle */
public function _customBlock_COMMAND_FLY_ANGLE(__Angle:Float):Void
{
var __Self:Actor = actor;
        if(!(_Modifiers.exists("frozen")))
{
            if(!(_ACTION == "rally"))
{
                if(_Modifiers.exists("fly"))
{
                    if(_Modifiers.exists("missle"))
{
                        __Self.setVelocity(__Angle, (_Parameters.get("moveSpeed") * 10));
                        _ACTION = "fly";
propertyChanged("_ACTION", _ACTION);
}

                    else if(_Modifiers.exists("gravity"))
{
                        __Self.setVelocity(__Angle, (_Parameters.get("moveSpeed") * 0.25));
                        _ACTION = "hover";
propertyChanged("_ACTION", _ACTION);
}

                    else if(_Modifiers.exists("hasted"))
{
                        __Self.setVelocity(__Angle, (_Parameters.get("moveSpeed") * 2));
                        _ACTION = "fly";
propertyChanged("_ACTION", _ACTION);
}

                    else if(_Modifiers.exists("paralyzed"))
{
                        __Self.setVelocity(__Angle, (_Parameters.get("moveSpeed") * 0.1));
                        _ACTION = "hover";
propertyChanged("_ACTION", _ACTION);
}

                    else if(_Modifiers.exists("slowed"))
{
                        __Self.setVelocity(__Angle, (_Parameters.get("moveSpeed") * 0.35));
                        _ACTION = "hover";
propertyChanged("_ACTION", _ACTION);
}

                    else
{
                        __Self.setVelocity(__Angle, (_Parameters.get("moveSpeed") * 1));
                        _ACTION = "hover";
propertyChanged("_ACTION", _ACTION);
}

                    if(!(_Modifiers.exists("rotating")))
{
                        if((_ACTION == "fly"))
{
                            __Self.growTo(100/100, 100/100, 0, Linear.easeNone);
                            __Self.setAngle(Utils.RAD * (__Angle));
}

                        else
{
                            if((__Angle > 360))
{
                                _TempVar.set("angle", (__Angle - 360));
}

                            else if((__Angle < 0))
{
                                _TempVar.set("angle", (__Angle + 360));
}

                            else
{
                                _TempVar.set("angle", __Angle);
}

                            if(((_TempVar.get("angle") > 90) && (_TempVar.get("angle") < 270)))
{
                                __Self.growTo(-100/100, 100/100, 0, Linear.easeNone);
}

                            else
{
                                __Self.growTo(100/100, 100/100, 0, Linear.easeNone);
}

}

}

                    actor.shout("_customEvent_" + "ANIMATE");
}

}

}

}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_COMMAND_STOP():Void
{
var __Self:Actor = actor;
        if(!(_Modifiers.exists("frozen")))
{
            if(!(_ACTION == "idle"))
{
                if((!(_Modifiers.exists("float")) && !(_Modifiers.exists("fly"))))
{
                    if(_State.get("onGround"))
{
                        _ACTION = "idle";
propertyChanged("_ACTION", _ACTION);
}

                    __Self.setXVelocity(0);
}

                else
{
                    _ACTION = "idle";
propertyChanged("_ACTION", _ACTION);
                    __Self.setXVelocity(0);
                    __Self.setYVelocity(0);
}

                __Self.shout("_customEvent_" + "ANIMATE");
}

}

}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Direction */
public function _customBlock_COMMAND_WALK(__Direction:Float):Void
{
var __Self:Actor = actor;
        if(!(_Modifiers.exists("frozen")))
{
            if(!(_ACTION == "rally"))
{
                if(!(_Modifiers.exists("fly")))
{
                    if(((_State.get("onWall") && !(__Direction == _State.get("dir"))) || !(_State.get("onWall"))))
{
                        if(!(_Modifiers.exists("wallJump")))
{
                            _State.set("dir", __Direction);
                            if(_State.get("onGround"))
{
                                _ACTION = "walk";
propertyChanged("_ACTION", _ACTION);
}

                            if(_Modifiers.exists("gravity"))
{
                                actor.setXVelocity((_Parameters.get("moveSpeed") * (__Direction * 0.25)));
}

                            else if(_Modifiers.exists("hasted"))
{
                                actor.setXVelocity((_Parameters.get("moveSpeed") * (__Direction * 2)));
}

                            else if(_Modifiers.exists("paralyzed"))
{
                                actor.setXVelocity((_Parameters.get("moveSpeed") * (__Direction * 0.1)));
}

                            else if(_Modifiers.exists("slowed"))
{
                                actor.setXVelocity((_Parameters.get("moveSpeed") * (__Direction * 0.35)));
}

                            else
{
                                __Self.setXVelocity((_Parameters.get("moveSpeed") * __Direction));
}

                            __Self.growTo((100 * __Direction)/100, 100/100, 0, Linear.easeNone);
                            actor.shout("_customEvent_" + "ANIMATE");
}

}

}

}

}

}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_COMMAND_JUMP():Void
{
var __Self:Actor = actor;
        if(!(_Modifiers.exists("frozen")))
{
            if(!(_ACTION == "rally"))
{
                if((_State.get("onGround") || _State.get("onWall")))
{
                    if(_State.get("onWall"))
{
                        if(!(_Modifiers.exists("wallJump")))
{
                            actor.say("unit", "_customBlock_ADD_MODIFIER", ["wallJump",10]);
                            actor.setX((actor.getX() + (_State.get("dir") * -1)));
                            actor.setXVelocity(((_Parameters.get("moveSpeed") * -2) * _State.get("dir")));
}

}

                    __Self.setYVelocity((_Parameters.get("jumpHeight") * -1));
}

}

}

}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_COMMAND_CHARGE():Void
{
var __Self:Actor = actor;
        if(!(_Modifiers.exists("frozen")))
{
            if(!(_ACTION == "rally"))
{
                if(_State.get("onGround"))
{
                    __Self.setXVelocity(0);
                    if(((_Meters.get("charge") + _Parameters.get("chargeGain")) <= _Parameters.get("chargeMax")))
{
                        _Meters.set("charge", (_Meters.get("charge") + _Parameters.get("chargeGain")));
                        _ACTION = "charge";
propertyChanged("_ACTION", _ACTION);
                        __Self.shout("_customEvent_" + "CHARGE");
}

                    else
{
                        __Self.say("unit", "_customBlock_COMMAND_RALLY");
}

                    __Self.shout("_customEvent_" + "ANIMATE");
}

}

}

}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_COMMAND_RALLY():Void
{
var __Self:Actor = actor;
        if(!(_Modifiers.exists("frozen")))
{
            if(!(_ACTION == "rally"))
{
                actor.setXVelocity(0);
                _Meters.set("charge", _Parameters.get("chargeMax"));
                _ACTION = "rally";
propertyChanged("_ACTION", _ACTION);
                __Self.shout("_customEvent_" + "RALLY");
                __Self.shout("_customEvent_" + "ANIMATE");
}

}

}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Type __Duration */
public function _customBlock_ADD_MODIFIER(__Type:String, __Duration:Float):Void
{
var __Self:Actor = actor;
        if(_Modifiers.exists(__Type))
{
            if((__Duration > _Modifiers.get(__Type)))
{
                _Modifiers.set(__Type, __Duration);
}

}

        else
{
            _Modifiers.set(__Type, __Duration);
}

}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Modifier */
public function _customBlock_REMOVE_MODIFIER(__Modifier:String):Void
{
var __Self:Actor = actor;
        _Modifiers.remove(__Modifier);
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Map */
public function _customBlock_SET_STATUS(__Map:Map<String,Dynamic>):Void
{
var __Self:Actor = actor;
        _Parameters = __Map;
propertyChanged("_Parameters", _Parameters);
        /* "CONVERT TO NUMBER" */             _Parameters.set("maxHealth", asNumber(_Parameters.get("maxHealth")));
            _Parameters.set("movespeed", asNumber(_Parameters.get("movespeed")));
            _Parameters.set("jumpHeight", asNumber(_Parameters.get("jumpHeight")));
            _Parameters.set("chargeMax", asNumber(_Parameters.get("chargeMax")));
            _Parameters.set("chargeGain", asNumber(_Parameters.get("chargeGain")));
            _Parameters.set("chargeDecay", asNumber(_Parameters.get("chargeDecay")));
}
    
/* ========================= Custom Event ========================= */
public function _customEvent_ANIMATE():Void
{
        actor.setAnimation("" + ("" + _ACTION));
        if((!((_ACTION == "fly")) && !(_Modifiers.exists("rotating"))))
{
            actor.setAngle(Utils.RAD * (0));
}

}


 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Parameters", "_Parameters");
nameMap.set("ACTION", "_ACTION");
_ACTION = "";
nameMap.set("State", "_State");
nameMap.set("Meters", "_Meters");
nameMap.set("Modifiers", "_Modifiers");
nameMap.set("TempVar", "_TempVar");
nameMap.set("FloorCol", "_FloorCol");
_FloorCol = [];
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        _Modifiers = new Map<String, Dynamic>();
propertyChanged("_Modifiers", _Modifiers);
        _State = new Map<String, Dynamic>();
propertyChanged("_State", _State);
        _TempVar = new Map<String, Dynamic>();
propertyChanged("_TempVar", _TempVar);
        _FloorCol = new Array<Dynamic>();
propertyChanged("_FloorCol", _FloorCol);
        _State.set("onGround", false);
        _State.set("hitGround", false);
        _State.set("onWall", false);
        _State.set("hitWall", false);
        _State.set("dir", asNumber(1));
        if((!hasValue(_Parameters)))
{
            _Parameters = new Map<String, Dynamic>();
propertyChanged("_Parameters", _Parameters);
}

        /* "SET PARAMETER KEYS" */             if(!(_Parameters.exists("maxHealth")))
{
                _Parameters.set("maxHealth", 1);
}

            if(!(_Parameters.exists("movespeed")))
{
                _Parameters.set("movespeed", 0);
}

            if(!(_Parameters.exists("jumpHeight")))
{
                _Parameters.set("jumpHeight", 0);
}

            if(!(_Parameters.exists("chargeMax")))
{
                _Parameters.set("chargeMax", 1);
}

            if(!(_Parameters.exists("chargeGain")))
{
                _Parameters.set("chargeGain", 0);
}

            if(!(_Parameters.exists("chargeDecay")))
{
                _Parameters.set("chargeDecay", 0);
}

        /* "CONVERT TO NUMBER" */             _Parameters.set("maxHealth", asNumber(_Parameters.get("maxHealth")));
            _Parameters.set("movespeed", asNumber(_Parameters.get("movespeed")));
            _Parameters.set("jumpHeight", asNumber(_Parameters.get("jumpHeight")));
            _Parameters.set("chargeMax", asNumber(_Parameters.get("chargeMax")));
            _Parameters.set("chargeGain", asNumber(_Parameters.get("chargeGain")));
            _Parameters.set("chargeDecay", asNumber(_Parameters.get("chargeDecay")));
        /* "SET METERS" */             _Meters = new Map<String, Dynamic>();
propertyChanged("_Meters", _Meters);
            _Meters.set("health", asNumber(_Meters.get("maxHealth")));
            _Meters.set("charge", asNumber(0));
        /* "FLOOR COLLISION" */             _FloorCol.push(getActorGroup(3));
            _FloorCol.push(getActorGroup(1));
            _FloorCol.push(getActorGroup(4));
            _FloorCol.push(getActorGroup(5));
            _FloorCol.push(getActorGroup(6));
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((!(_Modifiers.get("float")) && !(_Modifiers.get("fly"))))
{
            _State.set("onGround", _State.get("hitGround"));
            _State.set("hitGround", false);
            if(_State.get("onGround"))
{
                _State.set("onWall", false);
}

            else
{
                _State.set("onWall", _State.get("hitWall"));
}

            _State.set("hitWall", false);
}

}
});
    
/* ======================== Something Else ======================== */
addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(!event.thisCollidedWithSensor)
{
            _TempVar.set("yesCol", false);
            for(item in cast(_FloorCol, Array<Dynamic>))
{
                if((event.otherActor.getGroup() == item))
{
                    _TempVar.set("yesCol", true);
}

}

            if(_TempVar.get("yesCol"))
{
                if((!(_Modifiers.get("float")) && !(_Modifiers.get("fly"))))
{
                    if(event.thisFromBottom)
{
                        _State.set("hitGround", true);
}

}

}

}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(!(_Modifiers.exists("frozen")))
{
            if(!(_State.get("onGround")))
{
                if(!(_Modifiers.exists("fly")))
{
                    if(!(_Modifiers.exists("float")))
{
                        if(!(_State.get("onWall")))
{
                            if(_Modifiers.exists("gravity"))
{
                                if((actor.getYVelocity() < 0))
{
                                    actor.setYVelocity((actor.getYVelocity() + 2.5));
}

                                else
{
                                    actor.setYVelocity((actor.getYVelocity() + 5));
}

}

                            else
{
                                actor.setYVelocity((actor.getYVelocity() + 1));
}

                            if((actor.getYVelocity() > 5))
{
                                _ACTION = "jump_fall";
propertyChanged("_ACTION", _ACTION);
}

                            else
{
                                _ACTION = "jump_rise";
propertyChanged("_ACTION", _ACTION);
}

}

                        else
{
                            actor.setYVelocity(8);
                            _ACTION = "wall_grab";
propertyChanged("_ACTION", _ACTION);
}

                        actor.shout("_customEvent_" + "ANIMATE");
}

                    else
{
                        actor.setYVelocity(0);
}

}

}

}

        else
{
            actor.setXVelocity(0);
            actor.setYVelocity(0);
}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((!((_ACTION == "charge")) && !((_ACTION == "rally"))))
{
            if(((_Meters.get("charge") - _Parameters.get("chargeDecay")) >= 0))
{
                _Meters.set("charge", (_Meters.get("charge") - _Parameters.get("chargeDecay")));
}

            else
{
                _Meters.set("charge", 0);
}

}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        for(item in _Modifiers.keys())
{
            if((_Modifiers.get(item) < 99999))
{
                if((_Modifiers.get(item) > 0))
{
                    _Modifiers.set(item, (_Modifiers.get(item) - 1));
}

                else
{
                    _Modifiers.remove(item);
}

}

}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(_State.get("onGround"))
{
            if((!(_ACTION == "charge") && !(_ACTION == "rally")))
{
                if((!(_ACTION == "walk") && ((_ACTION == "jump_rise") || (_ACTION == "jump_fall"))))
{
                    actor.say("unit", "_customBlock_COMMAND_STOP");
}

}

}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(!(_Modifiers.exists("frozen")))
{
            if(actor.hasBehavior("triggers_hero"))
{
                if(_Modifiers.exists("gravity"))
{
                    actor.fadeTo(randomInt(Math.floor(30), Math.floor(60)) / 100, 0, Linear.easeNone);
}

                else
{
                    actor.fadeTo(100 / 100, 0, Linear.easeNone);
}

}

}

        else
{
            actor.fadeTo(randomInt(Math.floor(30), Math.floor(60)) / 100, 0, Linear.easeNone);
            actor.setAnimation("" + ("" + "frozen"));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}