sailfish-python-sample-os
=========
A sample Sailfish application written in Python.

This is a fork of https://github.com/sailfishos/python-sample extended/modified with some examples for executing shell/OS commands.

What's in it
=========
This gives you 2 ways of getting shell access via python and a few static and dynamic input/output examples.
- subprocess.check_output vs. subprocess.Popen
- static "Hello World" and "uname" output
- "execute OS command"
  - execute any shell command
    - get stdout
    - get stderr

Background
=========
I looked for some simple example code to access shell commands in a sailfish/qml app without hassling with c++.
Although https://github.com/Acce0ss/shellex is great as a starting point, I found it to blown up for a non c++ developer.

Also a good python example how to acutally access shell commands and work with them was not around.
https://github.com/sailfishos/python-sample might be a good starting point for actual python developers, but does not give you much in regards of shell access.

