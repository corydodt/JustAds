import ui.TextView as TextView;
import plugins.tapjoyads.ads;

exports = Class(GC.Application, function () {

	this.initUI = function () {
		var textview = new TextView({
			superview: this.view,
			layout: "box",
			text: "Hello, world!",
			color: "white"
		});
	};
	
	this.launchUI = function () {};
});
