SHELL =             /bin/bash

APP_DOMAIN =        com.possiblewhale.justads

APK =               build/debug/native-android/justads.apk
JS_FILES =          $(wildcard src/*.js) $(wildcard src/*/*.js)
PNG_FILES =         $(wildcard resouces/images/*.png) $(wildcard resources/icons/*.png) $(wildcard resources/splash/*.png)
MP3_FILES =         $(wildcard resources/sounds/*.mp3)
TTF_FILES =         $(wildcard resources/fonts/*.ttf)
MANIFESTS =         manifest.json $(wildcard resources/*/*.json)

ADDON_FILES =       $(wildcard addons/*/android/*.java) $(wildcard addons/*/android/manifest.*) $(wildcard addons/*/android/*.json) $(wildcard addons/*/js/*.js)

CONF_DIR =          resources/conf/
LOCALCONFIG =       $(CONF_DIR)/localconfig.json

ALL_APK_DEPS =      $(JS_FILES) $(PNG_FILES) $(MP3_FILES) $(TTF_FILES) $(MANIFESTS) $(ADDON_FILES)

all: register $(APK)

register:
	basil register .

$(APK): $(ALL_APK_DEPS)
	## git pull
	if [ -e $(LOCALCONFIG) ]; then \
		mv $(LOCALCONFIG) $(LOCALCONFIG)-disabled; \
	fi
	basil build native-android --open --no-compress --debug --clean
	if [ -e $(LOCALCONFIG)-disabled ]; then \
		mv $(LOCALCONFIG)-disabled $(LOCALCONFIG); \
	fi

clean:
	rm -vf $(APK)

localconfig: $(LOCALCONFIG)

$(LOCALCONFIG):
	mkdir -p resources/conf/
	cat > $(LOCALCONFIG) <<< '{ "debug": true }'

install: $(APK)
	adb install -r $(APK)

clear-data:
	adb shell pm clear $(APP_DOMAIN)
