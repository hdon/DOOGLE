module test;
import doogle.controls.font;
import doogle.platform;
import doogle.window.window;
import doogle.controls.all;
import doogle.events.oop;
import doogle.events.types;
import doogle.events.event;

import core.thread;

void main() {
	// make sure all the files were loaded.
	assert(storage.fonts.local.length == 1);
	assert(storage.shaders.local.length == 6);
	assert(storage.models.local.length == 2);

	shared Window window = new shared Window(800, 600, "OpenGL Window"w, WindowStyle.Close);

	shared Font font = new shared Font("Anonymous_Pro.ttf", 20, 3);
	auto text_hi = font.get("Hi", Color3.fromName("Red"));

	shared Picture picture = new shared Picture(window, 750, 550, 50, 50, text_hi);
	picture.font = font;
	picture.caption = "hi"w;

	shared BooLabel1 label1 = new shared BooLabel1(window);

	//shared Label label1 = new shared Label(window, 400, 300, "boo", font, Color3.fromHex("FF3300"));
	shared Label label2 = new shared Label(window, 400, 320, "boo", font, Color3.fromHex("FF3300"));
	//label1.background = Color4.opaque;
	label2.background = cast(Color4)(Color3.fromName("MintCream"));

	gl.glClearColor(0.4f, 0.4f, 0.4f, 1f);
	while (window.isOpen) {
		if (!window.whileOpenEvent()) return;

		glwrap.glClear(true, true);
		window.redraw();
		Thread.sleep(dur!"msecs"(75));
	}
}

shared class BooLabel1 : EventClass!Label {
	this(shared(Window) window) {
		super(window, 400, 300, "boo"w, new shared Font("Anonymous_Pro.ttf", 20, 3), Color3.fromHex("FF3300"));
		component.background = Color4.opaque;
		component.runEvent("test");
	}

	@OOPEvent("test") bool func() {
		import std.stdio;writeln("hi from test func");
		return false;
	}

	@OOPEvent(EventTypes.Draw) void onDraw() {
		import std.stdio;writeln("on draw");
	}
}