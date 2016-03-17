# simple-learning-time
An educational mobile application for reading of analogue and digital time.

## Feature List
* Interactive hour and minute pointers.
* Hour pointer is updated in real-time as minutes change.
* Digital time that updates in real-time as changes are made on the clock.


## Included in this project:
* Visual assets for clock elements (clock face, hour hand, minute hand, center circle)
* Visual assets for other elements (scene background, digits for digital time)
* Implementation of ClockManager that instantiates clock elements
* Implementation of DigitalTimeManager that instantiates a set of 4 sprites that each display a digit of the current time
* Code that rotates movable clock elements (hour and minute) and sets digital time


## To-do:
- [x] Render clock elements consistently
- [x] Find a way to rotate arms of clock
- [x] Rotate arms efficiently by touch
- [x] Adjust hour arm after minutes have been adjusted
- [x] Keep track of rotations and work out time
- [x] Implement digital time with spritesheet
- [ ] Add moving background (according to time)
- [ ] Set anologue time by digital time



## Known issues:
- [x] Touch location becomes inaccurate after changing `zRotation` of SKSpriteNode in scene (hour, minute) due to layer 1 appearing on top of everything else. Bizarre.
   - Solution: use nodesAtPoint(touchLocation) instead of nodeAtPoint and manipulate the preferred node.
 
- [ ] The app is limited to landscape mode only due to inconsistent pixel coordinates.




