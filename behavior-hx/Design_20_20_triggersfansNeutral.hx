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



class Design_20_20_triggersfansNeutral extends ActorScript
{          	
	
public var _Parameters:Map<String,Dynamic>;

public var _TempVar:Map<String,Dynamic>;

public var _AIcooldown:Float;

public var _AImove:Float;

public var _status:String;

 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Parameters", "_Parameters");
nameMap.set("TempVar", "_TempVar");
nameMap.set("AI_cooldown", "_AIcooldown");
_AIcooldown = 0.0;
nameMap.set("AI_move", "_AImove");
_AImove = 0.0;
nameMap.set("status", "_status");
_status = "";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        _TempVar = new Map<String, Dynamic>();
propertyChanged("_TempVar", _TempVar);
        _AIcooldown = asNumber(25);
propertyChanged("_AIcooldown", _AIcooldown);
        _status = "wander";
propertyChanged("_status", _status);
        runLater(1000 * 0.1, function(timeTask:TimedTask):Void {
                    actor.say("unit", "_customBlock_SET_STATUS", [_Parameters]);
                    actor.say("unit", "_customBlock_ADD_MODIFIER", ["fly",99999]);
}, actor);
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        _TempVar.set("disCheck", 320);
        for(actorInRegion in getActorsInRegion(getValueForScene("generals", "_ARENA")))
{
if(actorInRegion != null && !actorInRegion.dead){
            if(actorInRegion.hasBehavior("triggers_monster"))
{
                if((cast((sayToScene("generals", "_customBlock_GET_DISTANCE", [actor.getXCenter(),actor.getYCenter(),actorInRegion.getXCenter(),actorInRegion.getYCenter()])), Float) < _TempVar.get("disCheck")))
{
                    _TempVar.set("disCheck", cast((sayToScene("generals", "_customBlock_GET_DISTANCE", [actor.getXCenter(),actor.getYCenter(),actorInRegion.getXCenter(),actorInRegion.getYCenter()])), Float));
                    _TempVar.set("fearTarget", actorInRegion);
                    _status = "fear";
propertyChanged("_status", _status);
}

}

}
}

        if(!(_TempVar.exists("fearTarget")))
{
            _status = "wander";
propertyChanged("_status", _status);
}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((_status == "wander"))
{
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
                actor.say("unit", "_customBlock_COMMAND_FLY_ANGLE", [randomInt(Math.floor(0), Math.floor(360))]);
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

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((_status == "fear"))
{
            if((_TempVar.get("disCheck") < 160))
{
                actor.say("unit", "_customBlock_ADD_MODIFIER", ["hasted",10]);
}

            _TempVar.set("angle", cast((sayToScene("generals", "_customBlock_GET_ANGLE", [_TempVar.get("fearTarget").getXCenter(),_TempVar.get("fearTarget").getYCenter(),actor.getXCenter(),actor.getYCenter()])), Float));
            if((_TempVar.get("angle") > 360))
{
                _TempVar.set("angle", (_TempVar.get("angle") - 360));
}

            else if((_TempVar.get("angle") < 0))
{
                _TempVar.set("angle", (_TempVar.get("angle") + 360));
}

            actor.say("unit", "_customBlock_COMMAND_FLY_ANGLE", [_TempVar.get("angle")]);
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