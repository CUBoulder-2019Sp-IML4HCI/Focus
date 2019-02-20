# Focus
The project has only been tested on Windows, since the eyetracker does not support Mac.
Our project uses two Wekinator models, two Processing applications, a C# program, and a Tobii eyetracker.

To make the eyetracker work, simply plug it into a usb slot and go to https://gaming.tobii.com/getstarted/ to download the
proper driver. The eyetracker will run a short calibration program, which you must complete to properly track.

For the C# program in csharp/eyetracker/, you will need to use the NuGet package manager to acquire Tobii.Interaction, if it is not already installed. You will also need to download sharpOsc.dll from https://github.com/ValdemarOrn/SharpOSC/blob/master/Binaries/v0.1.1.0.zip and include it as a reference in the C# program. This program can then be run

For the two Processing programs, you will need to include the oscP5 and netP5 libraries. The mouse control does not require any library installs, however, the Robot, AWTException, and event.InputEvent classes must be included at the top of the sketch. These two programs are ready to run and should be run in parallel with the C# program.

Open the two Wekinator models. The included training data should work for most people, but, if not, it can be personalized by
 rerecording training data. Make sure the C# program is running, as the C# program is what transmits the eyetracker
 data to Wekinator.

#### Training (default data should work)
For focusWek, set the regression slider bar to 1 and begin reading text at a high level of focus. Then, set the bar to 0.5 and read at a medium focus level.
Finally, set the bar to 0 and zone out for a bit. These three sets of data should be enough to train the model for your reading rate.

For clickWek, set the class to 1 and look around the screen without focusing on anything, as if you were just looking
idly looking around. Set the class to 2 and look intently at a window you would like to focus on. These two data sets
can then be used to train the model for changing window focus.

The C# program, Tobii eyetracker, Processing applications, and Wekinator programs can now all be run in parallel. The beer mug will fill
up at a rate determined by your focus level and looking intently at a window will bring the it to the front of your view.

https://www.youtube.com/watch?v=EomTDtGhR2c&feature=youtu.be
