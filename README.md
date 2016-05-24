# Godot Easing Script

This is a Godot Script (GDScript) ([http://www.godotengine.org/](http://www.godotengine.org/ "Godot Engine")) port of the Robert Penner's equations for easing. You can find much more information about it on [http://robertpenner.com/easing/](http://robertpenner.com/easing/ "Rober Penner - Easing").

This library is heavily based off:

* [https://github.com/jesusgollonet/processing-penner-easing](https://github.com/jesusgollonet/processing-penner-easing "jesús gollonet")
* [https://github.com/EmmanuelOga/easing](https://github.com/EmmanuelOga/easing "Emmanuel Oga")


#Disclaimer for Robert Penner's Easing Equations license:

TERMS OF USE - EASING EQUATIONS

Open source under the BSD License.

Copyright © 2001 Robert Penner
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."""


# Usage:

    onready var Easing = preload("easing.gd")
    
    func testEasing():
    	var startValue = 0.0
    	var endValue = 1.0
    	var change = 1.0
    	var duration = 1.0
    
    	print(Easing.Cubic.easeOut(0, startValue, change, duration))						# --> 0
    	print(Easing.Cubic.easeOut(duration / 4.0, startValue, change, duration))			# --> 0.578125
    	print(Easing.Cubic.easeOut(duration / 2.0, startValue, change, duration))			# --> 0.875
    	print(Easing.Cubic.easeOut(duration / (3.0/4.0), startValue, change, duration))		# --> 1.037037
    	print(Easing.Cubic.easeOut(duration, startValue, change, duration))					# --> 1
    
    	var currentValue = startValue + Easing.Cubic.easeOut(duration / 2.0, startValue, change, duration) * (endValue - startValue)
    	print(currentValue)																	# --> 0.875
    

# All easing functions take these parameters:
* t = time     should go from 0 to duration
* b = begin    value of the property being ease.
* c = change   ending value of the property - beginning value of the property
* d = duration

Some functions allow additional modifiers, like the elastic functions
which also can receive an amplitud and a period parameters (defaults
are included)


# License

This Godot Script is licensed under the MIT license.


#Author

* Jan Schulte ([http://github.com/impmja](http://github.com/impmja "impmja"))
