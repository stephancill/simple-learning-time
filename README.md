# simple-learning-time
An educational mobile application for reading of analogue time

## Up to this point this project includes:

* Visual assets for clock elements (clock face, hour hand, minute hand, center circle)
* Visual assets for other elements (scene background, digits for digital time)
* Implementation of SpriteManager that instantiates clock elements
* Code that rotates movable clock elements (hour and minute)


## To-do:
- [x] Render clock elements consistently
- [x] Find a way to rotate arms of clock
- [x] Rotate arms efficiently by touch
- [x] Adjust hour arm after minutes have been adjusted
- [x] Keep track of rotations and work out time
- [x] Implement digital time with spritesheet
- [ ] Add moving background (according to time)



## Known issues:

- [x] Touch location becomes inaccurate after changing `zRotation` of SKSpriteNode in scene (hour, minute) due to layer 1 appearing on top of everything else. Bizarre.
   - Solution: use nodesAtPoint(touchLocation) instead of nodeAtPoint and manipulate the preferred node.




