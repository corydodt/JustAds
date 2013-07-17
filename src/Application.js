import ui.TextView as TextView;
import plugins.tapjoyads.ads as ads;

exports = Class(GC.Application, function () {

	this.initUI = function () {
		var textview = new TextView({
			superview: this.view,
			layout: "box",
			text: "BEGIN CONSUMING ADS",
			color: "yellow"
		});

        textview.on('InputSelect', function _a_onTextViewInputSelect() {
            ads.showAd(function _a_onShowAd() {
                console.log("ad was shown");
            });
        });
	};
	
	this.launchUI = function () {

    };
});
