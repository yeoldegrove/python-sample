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
TARGET = pythonsample-os

CONFIG += sailfishapp sailfishapp_qml

SOURCES += qml/cover/coveractions.py \
    qml/pages/helloworld.py \
    qml/pages/uname.py \
    qml/pages/oscommand.py

OTHER_FILES += qml/pythonsample-os.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/ExecuteOSCommand.qml \
    rpm/pythonsample-os.changes.in \
    rpm/pythonsample-os.spec \
    rpm/pythonsample-os.yaml \
    pythonsample-os.desktop \
    images/852304_linux_512x512.pngg
