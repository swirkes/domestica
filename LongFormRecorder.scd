Server.default.options.inDevice_("Komplete Audio 6");
Server.default.options.outDevice_("External Headphones");


(
SynthDef(\helpAudioIn, { |out|
	var input = AudioIn.ar(1);
	Out.ar(out, Limiter.ar(input, 1.0, 0.01));
}).play
)

(
SynthDef.new(\recorder, { |out|
	var input = SoundIn.ar(0);
	Out.ar(out, Limiter.ar(input, 0.95, 0.01));
}).play;
)

3.do( {
1.wait;
~recorderSynth = Synth.new("recorder");
1.wait;
s.prepareForRecord;
s.record(duration:3);
3.wait;
s.stopRecording;
1.wait;
~recorderSynth.free;}
)

(
~recordLoops = Routine.new({
	{
		s.recHeaderFormat_("wav");
		s.prepareForRecord;
		0.1.wait;
		s.record(duration:3);
		3.25.wait;
	}.loop;
}).play;
)