# Focus
The project has only been tested on Windows
Our project uses two wekinator models, two processing applications, a c# program, and a tobii eyetracker.

To make the eyetracker work, simply plug it into a usb slot and go to https://gaming.tobii.com/getstarted/ to download the
proper driver. The eyetracker will run a short calibration program, which you must complete.

For the c# program in csharp/eyetracker/, you will need to use the NuGet package manager to acquire Tobii.Interaction, if it is not already installed
you will also need to download sharpOsc.dll from https://github.com/ValdemarOrn/SharpOSC/blob/master/Binaries/v0.1.1.0.zip
and include it as a reference in the c# program. This program can then be run

For the two processing programs, you will need oscP5 and netP5. These two programs are ready to run.

Open the two wekinator models. The included training data should work for most people, but if not it can be personalized by
 rerecording training data. Make sure the c# program is running, as the c# program is what transmits the eyetracker
 data to wekinator.

Training (default data should work)
For focusWek, set the bar to 1 and read at a high level of focus. Set the bar to 0.5 and read at a medium focus level.
Set the bar to 0 and zone out for a bit. These three sets of data should be enough to train the model for your reading rate.

For clickWek, set the class to 1 and look around the screen without focusing on anything, as if you were just looking
idly looking around. Set the class to 2 and look intently at a window you would like to focus on. These two data sets
can then be used to train the model for changing window focus.

The c# program, tobii eyetracker, the processing applications, and wekinators can now all be run. The beer mug will fill
up at a rate determined by your focus level. Looking intently at a window will cause a click to be made on the window,
causing windows to focus on it.

https://www.youtube.com/watch?v=EomTDtGhR2c&feature=youtu.be