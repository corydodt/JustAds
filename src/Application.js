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
            console.log('begin was clicked');
            ads.showAd(function _a_onShowAd(evt) {
                if (evt.errorCode) {
                    console.log("[APP] Response from Plugin: message='" + evt.message + "' code=" + evt.errorCode);
                } else {
                    console.log("[APP] Response from Plugin: message=" + evt.message);
                }
            });
        });
	};
	
	this.launchUI = function () {

    };
});
