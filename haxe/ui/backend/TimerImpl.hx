package haxe.ui.backend;

class TimerImpl {
    static private var __timers:Array<TimerImpl> = [];

    static public function update() {
        var currentTime:Float = hxd.Timer.lastTimeStamp;
        var count:Int = __timers.length;
        for (i in 0...count) {
            var timer:TimerImpl = __timers[i];
            if (timer._start <= currentTime && !timer._stopped) {
                timer.callback();
            }
        }

        while(--count >= 0) {
            var timer:TimerImpl = __timers[count];
            if (timer._stopped) {
                __timers.remove(timer);
            }
        }
    }

    public var callback:Void->Void;
    private var _start:Float;
    private var _stopped:Bool;

    public function new(delay:Int, callback:Void->Void) {
        this.callback = callback;
        _start = hxd.Timer.lastTimeStamp + delay;
        __timers.push(this);
    }

    public function stop() {
        _stopped = true;
    }
}