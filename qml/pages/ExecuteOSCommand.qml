/*
  Copyright (C) 2017 Eike Waldt
  Contact: Eike Waldt <git@waldt.org>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.

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
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

Page {

    id: page

    allowedOrientations: Orientation.All

    PageHeader {
        id: header
        width: parent.width
        title: "execute a OS command"
    }

    Image {
        id: logoimage
        anchors.centerIn: parent
        Layout.fillWidth: true
        width: parent.w
        fillMode: Image.PreserveAspectFit
        source: "../images/852304_linux_512x512.png"
    }

    TextField {
        id:f_stdin
        label: "input"
        placeholderText: "input"
        Layout.fillWidth: true;
        anchors.top: logoimage.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        width: parent.w
        focus: true
        inputMethodHints: Qt.ImhNoAutoUppercase
        EnterKey.onClicked: {
            oscommand.execute(text)
            focus: f_stdin
        }
    }

    TextField {
        id:f_stdout
        label: "stdout"
        Layout.fillWidth: true;
        anchors.top: f_stdin.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        width: parent.w
    }


    TextField {
        id:f_stderr
        label: "stderr"
        Layout.fillWidth: true;
        anchors.top: f_stdout.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        width: parent.w
    }

    Python {
        id: oscommand

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'));

            setHandler('stdout', function(stdout) {
                f_stdout.text = stdout;
            });
            setHandler('stderr', function(stderr) {
                f_stderr.text = stderr;
            });

            importModule('oscommand', function () {});

        }

        function execute() {
            call('oscommand.oscommand.execute', [f_stdin.text], function(result) {});
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
