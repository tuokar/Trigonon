# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-trigonon

CONFIG += sailfishapp

SOURCES += src/harbour-trigonon.cpp

OTHER_FILES += qml/harbour-trigonon.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-trigonon.changes.in \
    rpm/harbour-trigonon.spec \
    rpm/harbour-trigonon.yaml \
    translations/*.ts \
    harbour-trigonon.desktop \
    qml/pages/MainPage.qml \
    qml/pages/AboutPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-trigonon-de.ts

