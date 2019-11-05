# Easing Library

# This is a Godot Script (GDScript) (http://www.godotengine.org/) port of the Robert Penner's equations for easing. You can find much more information about it on http://robertpenner.com/easing/.

# This library is based off:
# * https://github.com/EmmanuelOga/easing
# * https://github.com/jesusgollonet/processing-penner-easing


# Disclaimer for Robert Penner's Easing Equations license:

# TERMS OF USE - EASING EQUATIONS

# Open source under the BSD License.

# Copyright © 2001 Robert Penner
# All rights reserved.

# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
#    * Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."""


# Usage:
#
#	onready var Easing = preload("easing.gd")
#
#	func testEasing():
#		var startValue = 0.0
#		var endValue = 1.0
#		var change = 1.0
#		var duration = 1.0
#
#		print(Easing.Cubic.easeOut(0, startValue, change, duration))						# --> 0
#		print(Easing.Cubic.easeOut(duration / 4.0, startValue, change, duration))			# --> 0.578125
#		print(Easing.Cubic.easeOut(duration / 2.0, startValue, change, duration))			# --> 0.875
#		print(Easing.Cubic.easeOut(duration / (3.0/4.0), startValue, change, duration))		# --> 1.037037
#		print(Easing.Cubic.easeOut(duration, startValue, change, duration))					# --> 1


# All easing functions take these parameters:
# t = time     should go from 0 to duration
# b = begin    value of the property being ease.
# c = change   ending value of the property - beginning value of the property
# d = duration
#
# Some functions allow additional modifiers, like the elastic functions
# which also can receive an amplitud and a period parameters (defaults
# are included)

class Back:
	static func easeIn(t, b, c, d, s = 1.70158):
		t = t / d
		return c * t * t * ((s + 1) * t - s) + b

	static func easeOut(t, b, c, d, s = 1.70158):
		t = t / d  - 1
		return c * (t * t * ((s + 1) * t + s) + 1) + b

	static func easeInOut(t, b, c, d, s = 1.70158):
		t = (t / (d / 2))
		if (t < 1):
			s = s * 1.525
			return c / 2 * (t * t * ((s + 1 ) * t - s)) + b;
		else:
			t = t - 2
			s = s * 1.525
			return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b


class Bounce:
	static func easeIn(t, b, c, d):
		if b is Vector2:
			return c - easeOut(d - t, Vector2.ZERO, c, d) + b
		return c - easeOut(d - t, 0, c, d) + b

	static func easeOut(t, b, c, d):
		t = t / d
		if (t < (1 / 2.75)):
			return c * (7.5625 * t * t) + b
		elif (t < (2 / 2.75)):
			t = t - (1.5 / 2.75)
			return c * (7.5625 * t * t + 0.75) + b
		elif (t < (2.5 / 2.75)):
			t = t - (2.25 / 2.75)
			return c * (7.5625 * t * t + 0.9375) + b
		else:
			t = t - (2.625 / 2.75)
			return c * (7.5625 * t * t + 0.984375) + b

	static func easeInOut(t, b, c, d):
		if b is Vector2:
			if (t < (d / 2)):
				return easeIn (t * 2, Vector2.ZERO, c, d) * 0.5 + b
			else:
				return easeOut (t * 2 - d, Vector2.ZERO, c, d) * 0.5 + c * 0.5 + b
		if (t < (d / 2)):
			return easeIn (t * 2, 0, c, d) * 0.5 + b
		else:
			return easeOut (t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b


class Circ:
	static func easeIn(t, b, c, d):
		t = t / d
		return -c * (sqrt(1 - t * t) - 1) + b

	static func easeOut(t, b, c, d):
		t = t / d - 1
		return c * sqrt(1 - t * t) + b

	static func easeInOut(t, b, c, d):
		t = (t / (d / 2))
		if (t < 1):
			return -c / 2 * (sqrt(1 - t * t) - 1) + b
		else:
			t = t - 2
			return c / 2 * (sqrt(1 - t * t) + 1) + b


class Cubic:
	static func easeIn(t, b, c, d):
		t = t / d
		return c * t * t * t + b;

	static func easeOut(t, b, c, d):
		t = t / d - 1
		return c * (t * t * t + 1) + b

	static func easeInOut(t, b, c, d):
		t = (t / (d / 2))
		if (t < 1):
			return c / 2 * t * t * t + b
		else:
			t = t - 2
			return c / 2 * (t * t * t + 2) + b


class Elastic:
	static func easeIn(t, b, c, d):
		if (t == 0):
			return b
		t = t / d
		if (t == 1):
			return b + c
		var p = d * 0.3
		var a = c
		var s = p / 4
		t = t - 1
		return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * PI) / p)) + b

	static func easeInEx(t, b, c, d, a, p):
		var s
		if (t == 0):
			return b
		t = t / d
		if (t == 1):
			return b + c
		if (a < abs(c)):
			a = c
			s = p / 4
		else:
			s = p / (2 * PI) * asin(c / a)
		t = t - 1
		return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * PI) / p)) + b

	static func easeOut(t, b, c, d):
		if (t == 0):
			return b
		t = t / d
		if (t == 1):
			return b + c
		var p = d * 0.4
		var a = c
		var s = p / 4
		return (a * pow(2, -10 * t) * sin((t * d - s) * (2 * PI) / p) + c + b)

	static func easeOutEx(t, b, c, d, a, p):
		var s
		if (t == 0):
			return b
		t = t / d
		if (t == 1):
			return b + c
		if (a < abs(c)):
			a = c
			s = p / 4
		else:
			s = p / (2 * PI) * asin(c / a)
		return (a * pow(2, -10 * t) * sin((t * d - s) * (2 * PI) / p) + c + b)

	static func easeInOut(t, b, c, d):
		if (t == 0):
			return b
		t = (t / (d / 2))
		if (t == 2):
			return b + c
		var p = d * (0.4 * 1.5)
		var a = c
		var s = p / 4
		if (t < 1):
			t = t - 1
			return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * PI) / p)) + b
		else:
			t = t - 1
			return a * pow(2, -10 * t) * sin((t * d - s) * (2 * PI) / p) * 0.5 + c + b

	static func easeInOutEx(t, b, c, d, a, p):
		var s
		if (t == 0):
			return b
		t = t / d / 2
		if (t == 2):
			return b + c
		if (a < abs(c)):
			a = c
			s = p / 4
		else:
			s = p / (2 * PI) * asin(c / a)
		if (t < 1):
			t = t - 1
			return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * PI) / p)) + b
		else:
			t = t - 1
			return a * pow(2, -10 * t) * sin((t * d - s) * (2 * PI) / p) * 0.5 + c + b


class Expo:
	static func easeIn(t, b, c, d):
		if (t == 0):
			return b
		else:
			return c * pow(2, 10 * (t / d - 1)) + b

	static func easeOut(t, b, c, d):
		if (t == d):
			return b + c
		else:
			return c * (-pow(2, -10 * t / d) + 1) + b

	static func easeInOut(t, b, c, d):
		if (t == 0):
			return b
		if (t == d):
			return b + c
		t = (t / (d / 2))
		if (t < 1):
			return c / 2 * pow(2, 10 * (t - 1)) + b
		else:
			t = t - 1
			return c / 2 * (-pow(2, -10 * t) + 2) + b


class Linear:
	static func easeNone(t, b, c, d):
		return c * t / d + b

	static func easeIn(t, b, c, d):
		return c * t / d + b

	static func easeOut(t, b, c, d):
		return c * t / d + b

	static func easeInOut(t, b, c, d):
		return c * t / d + b


class Quad:
	static func easeIn(t, b, c, d):
		t = t / d
		return c * t * t + b

	static func easeOut(t, b, c, d):
		t = t / d
		return -c * t * (t - 2) + b

	static func easeInOut(t, b, c, d):
		t = (t / (d / 2))
		if (t < 1):
			return c / 2 * t * t + b
		else:
			t -= 1
			return -c / 2 * (t * (t - 2) - 1) + b


class Quart:
	static func easeIn(t, b, c, d):
		t = t / d
		return c * t * t * t * t + b

	static func easeOut(t, b, c, d):
		t = t / d - 1
		return -c * (t * t * t * t - 1) + b

	static func easeInOut(t, b, c, d):
		t = (t / (d / 2))
		if (t < 1):
			return c / 2 * t * t * t * t + b
		else:
			t = t - 2
			return -c / 2 * (t * t * t * t - 2) + b


class Quint:
	static func easeIn(t, b, c, d):
		t = t / d
		return c * t * t * t * t * t + b

	static func easeOut(t, b, c, d):
		t = t / d - 1
		return c * (t * t * t * t * t + 1) + b

	static func easeInOut(t, b, c, d):
		t = (t / (d / 2))
		if (t < 1):
			return c / 2 * t * t * t * t * t + b
		else:
			t = t - 2
			return c / 2 * (t * t * t * t * t + 2) + b


class Sine:
	static func easeIn(t, b, c, d):
		return -c * cos(t / d * (PI / 2)) + c + b

	static func easeOut(t, b, c, d):
		return c * sin(t / d * (PI / 2)) + b

	static func easeInOut(t, b, c, d):
		return -c / 2 * (cos(PI * t / d) - 1) + b
