# AUDIOSWIT.SH

- Utility: Quickly switch between audio devices
- OS: GNU/Linux
- Dependencies: `bash`|`zsh`, `amixer`

I was bored to always plug/unplug my headset to switch between speakers and headsets.
With this script, I am now able to mute my headset when using my speakers, and vice-versa with a simple keybind.

Of course, you will need some adaptation to make it work on your machine.
My tips regarding that would be to play a bit on your own with `amixer` and find the id of your devices.

## Known bugs:
- Normally raising or lowering sound through default commands makes the sound starts from really low
   - This is due to the fact that master is apparently computed according to the volume of several output devices. For instance, when my speakers are at 60% and my headset at 0%, master is around 7%.
   - To fix that, I personally rebound the keys to use another script, also using `amixer`.