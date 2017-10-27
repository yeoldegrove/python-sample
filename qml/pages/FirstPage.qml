/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4

Page {
    id: page

    allowedOrientations: Orientation.All

    property bool downloading: false

    PageHeader {
        id: header
        width: parent.width
        title: "uname and hello world"
    }

    // Label {       // is static
    // TextField {   // multiple lines; can be edited
    TextArea {       // single line; can be edited
        id: mainText
        anchors.verticalCenter: parent.verticalCenter
        text: ""
        anchors.horizontalCenter: parent.horizontalCenter
        width: page.width
        wrapMode: Text.WordWrap // wrap text word wise
    }

    Button {
        id: button_say_hello_world
        text: "Say Hello World"
        anchors.bottom: parent.bottom
        width: parent.width
        onClicked: {
            helloworld.startHelloWorld()
        }
    }

    Button {
        id: button_uname
        text: "uname"
        anchors.bottom: button_say_hello_world.top
        width: parent.width
        onClicked: {
            uname.uname()
        }
    }

    Button {
        id: button_uname_a
        text: "uname -a"
        anchors.bottom: button_uname.top
        width: parent.width
        onClicked: {
            uname.unameA()
        }
    }

    Button {
        id: button_uname_r
        text: "uname -r"
        anchors.bottom: button_uname_a.top
        width: parent.width
        onClicked: {
            uname.unameR()
        }
    }

    Button {
        id: execute_os_command
        text: "execute OS command"
        anchors.bottom: button_uname_r.top
        width: parent.width
        onClicked: {
            pageStack.push(Qt.resolvedUrl("ExecuteOSCommand.qml"))
        }
    }

    Python {
        id: helloworld

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'));

            setHandler('output', function(display) {
                mainText.text = display;
            });

            importModule('helloworld', function () {});

        }

        function startHelloWorld() {
            call('helloworld.helloworld', function() {});
        }

        onError: {
            // when an exception is raised, this error handler will be called
            console.log('python error: ' + traceback);
        }

        onReceived: {
            // asychronous messages from Python arrive here
            // in Python, this can be accomplished via pyotherside.send()
            console.log('got message from python: ' + data);
        }
    }

    Python {
        id: uname

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'));

            setHandler('output', function(display) {
                mainText.text = display;
            });

            importModule('uname', function () {});

        }

        function uname() {
            call('uname.uname', function() {});
        }

        function unameA() {
            call('uname.uname.a', function() {});
        }


        function unameR() {
            call('uname.uname.r', function() {});
        }

        onError: {
            // when an exception is raised, this error handler will be called
            console.log('python error: ' + traceback);
        }

        onReceived: {
            // asychronous messages from Python arrive here
            // in Python, this can be accomplished via pyotherside.send()
            console.log('got message from python: ' + data);
        }
    }
}
