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
import box2D.collision.shapes.B2Shape;

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



class Design_15_15_bossFight extends SceneScript
{
	
public var _Influence:Float;

public var _BOSS:Actor;

public var _UI:Map<String,Dynamic>;

public var _TempVar:Map<String,Dynamic>;

 
 	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Influence", "_Influence");
_Influence = 0.0;
nameMap.set("BOSS", "_BOSS");
nameMap.set("UI", "_UI");
nameMap.set("TempVar", "_TempVar");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        _UI = new Map<String, Dynamic>();
propertyChanged("_UI", _UI);
        _TempVar = new Map<String, Dynamic>();
propertyChanged("_TempVar", _TempVar);
        for(actorOfType in getActorsOfType(getActorType(35)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
            _BOSS = actorOfType;
propertyChanged("_BOSS", _BOSS);
            actorOfType.makeAlwaysSimulate();
}
}

        createRecycledActor(getActorType(19), 750, 10, Script.FRONT);
        getLastCreatedActor().anchorToScreen();
        _UI.set("SKILL", getLastCreatedActor());
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        g.alpha = (100/100);
        g.fillColor = Utils.getColorRGB(255,0,255);
        g.strokeSize = Std.int(0);
        g.fillRect(50, 10, 700, 20);
        g.fillColor = Utils.getColorRGB(51,255,0);
        g.strokeSize = Std.int(0);
        g.fillRect(50, 10, ((_Influence / 100) * 700), 20);
}
});
    
/* ======================== Actor of Type ========================= */
addCollisionListener(getValueForScene("generals", "_HERO"), function(event:Collision, list:Array<Dynamic>):Void
{
if(wrapper.enabled && sameAsAny(getActorType(37), event.otherActor.getType(),event.otherActor.getGroup()))
{
        _Influence = asNumber((_Influence + 0.01));
propertyChanged("_Influence", _Influence);
}
});
    
/* ======================== Actor of Type ========================= */
addCollisionListener(_BOSS, function(event:Collision, list:Array<Dynamic>):Void
{
if(wrapper.enabled && sameAsAny(getActorType(37), event.otherActor.getType(),event.otherActor.getGroup()))
{
        _Influence = asNumber((_Influence - 0.01));
propertyChanged("_Influence", _Influence);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}