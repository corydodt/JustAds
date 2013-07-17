SHELL =             /bin/bash

APP_DOMAIN =        com.possiblewhale.justads

APK =               build/debug/native-android/justads.apk
JS_FILES =          $(wildcard src/*.js) $(wildcard src/*/*.js)
PNG_FILES =         $(wildcard resouces/images/*.png) $(wildcard resources/icons/*.png) $(wildcard resources/splash/*.png)
MP3_FILES =         $(wildcard resources/sounds/*.mp3)
TTF_FILES =         $(wildcard resources/fonts/*.ttf)
MANIFESTS =         manifest.json $(wildcard resources/*/*.json)

ADDON_FILES =       $(wildcard addons/*/android/*.java) $(wildcard addons/*/android/manifest.*) $(wildcard addons/*/android/*.json) $(wildcard addons/*/js/*.js)

CONF_DIR =          resources/conf
LOCALCONFIG =       $(CONF_DIR)/localconfig.json

ALL_APK_DEPS =      $(JS_FILES) $(PNG_FILES) $(MP3_FILES) $(TTF_FILES) $(MANIFESTS) $(ADDON_FILES)

all: register manifest.json $(APK)

manifest.json: tapjoysecretkey.txt manifest.json.in
	fab gcbuild.generateManifest
	test -f manifest.json

tapjoysecretkey.txt:
	ln -s ~/Dropbox/possiblewhale/tapjoysecretkey.txt tapjoysecretkey.txt

register:
	basil register .

$(APK): $(ALL_APK_DEPS)
	git pull
	( test -d $(CONF_DIR) && test -e $(LOCALCONFIG) && mv $(LOCALCONFIG) $(LOCALCONFIG)-disabled ) || true
	basil build native-android --open --no-compress --debug --clean
	( test -d $(CONF_DIR) && test -e $(LOCALCONFIG)-disabled && mv $(LOCALCONFIG)-disabled $(LOCALCONFIG) ) || true

clean:
	rm -vf $(APK)
	rm -vf manifest.json

localconfig: $(LOCALCONFIG)

$(LOCALCONFIG):
	mkdir -p resources/conf/
	cat > $(LOCALCONFIG) <<< '{ "debug": true }'

install: $(APK)
	adb install -r $(APK)

clear-data:
	adb shell pm clear $(APP_DOMAIN)
