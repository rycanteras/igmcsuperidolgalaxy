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



class Design_21_21_triggersmonster extends ActorScript
{          	
	
public var _TempVar:Map<String,Dynamic>;

public var _AIcooldown:Float;

public var _Parameters:Map<String,Dynamic>;

public var _AImove:Float;

public var _AI_status:String;

public var _AItarget:Actor;

public var _AIstateTime:Float;

 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("TempVar", "_TempVar");
nameMap.set("AI_cooldown", "_AIcooldown");
_AIcooldown = 0.0;
nameMap.set("Parameters", "_Parameters");
nameMap.set("AI_move", "_AImove");
_AImove = 0.0;
nameMap.set("AI_status", "_AI_status");
_AI_status = "";
nameMap.set("AI_target", "_AItarget");
nameMap.set("AI_stateTime", "_AIstateTime");
_AIstateTime = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        _TempVar = new Map<String, Dynamic>();
propertyChanged("_TempVar", _TempVar);
        _AIcooldown = asNumber(25);
propertyChanged("_AIcooldown", _AIcooldown);
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    actor.say("unit", "_customBlock_SET_STATUS", [_Parameters]);
                    actor.say("unit", "_customBlock_ADD_MODIFIER", ["fly",99999]);
                    actor.say("unit", "_customBlock_ADD_MODIFIER", ["rotating",99999]);
}, actor);
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((_AIstateTime == 0))
{
            _TempVar.set("disCheck", 99999);
            for(actorInRegion in getActorsInRegion(getValueForScene("generals", "_ARENA")))
{
if(actorInRegion != null && !actorInRegion.dead){
                if((!(actorInRegion.getType() == getActorType(12)) && !(actorInRegion.getType() == getActorType(48))))
{
                    if(actorInRegion.hasBehavior("unit"))
{
                        _TempVar.set("disMath", cast((sayToScene("generals", "_customBlock_GET_DISTANCE", [actor.getXCenter(),actor.getYCenter(),actorInRegion.getXCenter(),actorInRegion.getYCenter()])), Float));
                        if((_TempVar.get("disMath") < _TempVar.get("disCheck")))
{
                            _TempVar.set("disCheck", _TempVar.get("disMath"));
                            _AItarget = actorInRegion;
propertyChanged("_AItarget", _AItarget);
                            if((_TempVar.get("disCheck") > 360))
{
                                _AI_status = "wander";
propertyChanged("_AI_status", _AI_status);
}

                            else if((_TempVar.get("disCheck") > 160))
{
                                _AI_status = "curious";
propertyChanged("_AI_status", _AI_status);
}

                            else
{
                                _AI_status = "seek";
propertyChanged("_AI_status", _AI_status);
                                _AIstateTime = asNumber(500);
propertyChanged("_AIstateTime", _AIstateTime);
}

}

}

}

}
}

}

        else
{
            _AIstateTime = asNumber((_AIstateTime - 1));
propertyChanged("_AIstateTime", _AIstateTime);
}

        if((actor.getAnimation() == "idle"))
{
            actor.rotate(Utils.RAD * (0.25));
}

        else if((actor.getAnimation() == "hover"))
{
            actor.rotate(Utils.RAD * (1));
}

        else if((actor.getAnimation() == "fly"))
{
            actor.rotate(Utils.RAD * (4));
}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((_AI_status == "wander"))
{
            actor.fadeTo(50 / 100, 0, Linear.easeNone);
            actor.say("unit", "_customBlock_ADD_MODIFIER", ["slowed",10]);
            if((_AIcooldown > 0))
{
                _AIcooldown = asNumber((_AIcooldown - 1));
propertyChanged("_AIcooldown", _AIcooldown);
}

            else
{
                _AIcooldown = asNumber(randomInt(Math.floor(300), Math.floor(400)));
propertyChanged("_AIcooldown", _AIcooldown);
                _AImove = asNumber(randomInt(Math.floor(150), Math.floor(250)));
propertyChanged("_AImove", _AImove);
                _TempVar.set("angle", randomInt(Math.floor(0), Math.floor(360)));
                actor.say("unit", "_customBlock_COMMAND_FLY", [(actor.getXCenter() + (Math.cos(_TempVar.get("angle") * Utils.RAD) * 999)),(actor.getYCenter() + (Math.sin(_TempVar.get("angle") * Utils.RAD) * 999))]);
}

            if((_AImove > 0))
{
                _AImove = asNumber((_AImove - 1));
propertyChanged("_AImove", _AImove);
}

            else
{
                actor.say("unit", "_customBlock_COMMAND_STOP");
}

}

        else
{
            actor.fadeTo(100 / 100, 0, Linear.easeNone);
}

}
});
    
/* ======================= Every N seconds ======================== */
runPeriodically(1000 * (1 / 5), function(timeTask:TimedTask):Void
{
if(wrapper.enabled)
{
        if((_AI_status == "curious"))
{
            actor.say("unit", "_customBlock_COMMAND_FLY", [_AItarget.getXCenter(),_AItarget.getYCenter()]);
}

}
}, actor);
    
/* ======================= Every N seconds ======================== */
runPeriodically(1000 * (1 / 10), function(timeTask:TimedTask):Void
{
if(wrapper.enabled)
{
        if((_AI_status == "seek"))
{
            actor.say("unit", "_customBlock_ADD_MODIFIER", ["hasted",10]);
            actor.say("unit", "_customBlock_COMMAND_FLY", [_AItarget.getXCenter(),_AItarget.getYCenter()]);
}

}
}, actor);
    
/* ======================= Every N seconds ======================== */
runPeriodically(1000 * 1.5, function(timeTask:TimedTask):Void
{
if(wrapper.enabled)
{
        if((_AI_status == "seek"))
{
            _AItarget.say("unit", "_customBlock_ADD_MODIFIER", ["gravity",50]);
}

}
}, actor);
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((_AI_status == "seek"))
{
            if((cast((sayToScene("generals", "_customBlock_GET_DISTANCE", [actor.getXCenter(),actor.getYCenter(),_AItarget.getXCenter(),_AItarget.getYCenter()])), Float) < 40))
{
                _AI_status = "wander";
propertyChanged("_AI_status", _AI_status);
                actor.say("unit", "_customBlock_COMMAND_STOP");
                if(_AItarget.hasBehavior("triggers_hero"))
{
                    _AItarget.say("unit", "_customBlock_ADD_MODIFIER", ["frozen",100]);
                    _AItarget.say("unit", "_customBlock_ADD_MODIFIER", ["slowed",500]);
                    _AItarget.setX((actor.getXCenter() - (_AItarget.getWidth()/2)));
                    _AItarget.setY((actor.getYCenter() - (_AItarget.getHeight()/2)));
                    sayToScene("generals", "_customBlock_DRAW_CIRCLE", [_AItarget.getXCenter(),_AItarget.getYCenter(),Utils.getColorRGB(0,0,0),5,50,-2,100]);
                    _AIstateTime = asNumber(500);
propertyChanged("_AIstateTime", _AIstateTime);
}

                else if(_AItarget.hasBehavior("triggers_fansNeutral"))
{
                    sayToScene("generals", "_customBlock_DRAW_CIRCLE", [_AItarget.getXCenter(),_AItarget.getYCenter(),Utils.getColorRGB(102,102,102),5,0,1.6,50]);
                    recycleActor(_AItarget);
                    _AIstateTime = asNumber(100);
propertyChanged("_AIstateTime", _AIstateTime);
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
        for (key in _TempVar)
{
_TempVar.remove(key);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}