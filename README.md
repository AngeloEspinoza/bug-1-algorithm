# Bug1 Algorithm

<p align="center">
  <img src="https://user-images.githubusercontent.com/40195016/182992447-80063745-8113-4619-b1c0-0fe8bbb9726f.gif" width="300"/>
  <img src="https://user-images.githubusercontent.com/40195016/182992849-1e27f7d0-8443-49b5-b5c9-b32e48499b0b.gif" width="300"/>
  <img src="https://user-images.githubusercontent.com/40195016/182992441-97c0bfca-212b-4abb-bcb9-3f53b6ba19d1.gif" width="300"/>  
</p>

## Description
A 2D simulation in RobotBASIC from the book [Principles of robot motion: Theory, algorithms, and implementation](https://scholar.google.com/citations?view_op=view_citation&hl=en&user=4fvo61oAAAAJ&citation_for_view=4fvo61oAAAAJ:u5HHmVD_uO8C) by H. Choset, K. M. Lynch, S. Hutchinson, G. A. Kantor, and W. Burgard.

Essentially, the Bug1 consists of three principal behaviours:

* Move in a straight line towards goal (motion-to-goal).
* Circumnavigate the obstacle and store the closest point to goal (boundary-following).
* Return to the closest point and head towards goal again.

The robot is assumed to be a point with perfect positioning and it can also measure the distance $d(x, y)$ between two points $x$ and $y$.

Let $q_0^L = q_{start}$ and the m-line be the straight line segment that connects $q_i^L = q_{goal}$. If the robot encounters an obstacle, let $q_1^H$ be the point where the robot first encounters an obstacle and call this point hit point.
The robot circumnavigates the obstacle until it re-encounters the *hit point* $q_1^H$. After that, the robot decides the closest point to goal by comparing with all the other ones. Therefore, it
circumnavigates once more to that closest point and leaves. The exact point where it leaves is called leave point, denoted by $q_1^L$. In the exact moment that the robot leaves it heads towards the the goal $q_{goal}$
and move straight to it again

<p align="center">
  <img src="https://user-images.githubusercontent.com/40195016/182995799-632e9ca0-d7a1-46e6-a5c2-8063b8099e5b.png" width="300"/>  
  <img src="https://user-images.githubusercontent.com/40195016/182995823-1eecefc2-ff84-4ebb-b6ab-ec856f90c454.png" width="300"/>  
  <img src="https://user-images.githubusercontent.com/40195016/182995902-94068803-2af4-4247-a655-3487475d8b7b.png" width="300"/>  
</p>

<p align = "center">
  Fig.1 Left: Robot performing motion-to-goal behaviour. Center: Robot performing boundary-following behaviour. Right: Robot successfully achieving the target.
</p>

## Constraints
Given that the robot is a differential robot and not a point, this represents constraints at the time of simulating it. For instance, at the moment of implementing the algorithm it was adapted to work with
such robot. This implies that the robot will have to adapt to environment and instead of using the bumper sensors, it will use the ultrasonic sensors, otherwise it has been proved that the robot will tend
to collide in the spike-shaped obstacles, since it gets too close to the obstacle at the time of turning around them.

## Usage
Simply click on the script ```bug-algorithm-1.BAS``` and the simulation will start. At the beginning, a text with the instructions will be displayed, press the button ```OK``` to continue. Next, a menu with 4 different maps will be displayed.
It counts with 1 convex (```Map 1```), 2 non-onvex (```Map 2``` and ```Map 4```), and a combination of both maps (```Map 3```) where the robot will be moving around. Choose whatever you want and it will start the algorithm.

## License
 MIT License

Copyright (c) [2022] [Angelo Espinoza]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
