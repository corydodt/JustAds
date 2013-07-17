
var TapjoyAds = Class(function () {
    this.init = function _a_init() {
        NATIVE.events.registerHandler('tapjoyads', function (evt) {
            console.log('native event from tapjoyads received - TODO check what kind of event');
            var cb = this.callback;
            cb();
        });
    };

    this.showAd = function _a_showAd(callback) {
        this.callback = callback;
        NATIVE.plugins.sendEvent('TapjoyAdsPlugin', 'requestAd', '');
    };
});

exports = new TapjoyAds();
