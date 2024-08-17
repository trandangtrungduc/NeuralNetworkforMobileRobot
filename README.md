# Neural Network Controller for Mobile robot

## Demo

![Map Number 8](Docs\map_number_8.gif)

![Random Map](Docs\random_map.gif)

## Overview
- This is a small project suitable for students who are studying majors such as mechatronics, electronics, automation, information technology, ... or research on mobile robots at universities.
- Dependency: Code Composer Studio, Matlab, Arduino IDE, Python, Autocad, Solidworkds, Altium.

## Implementation
1. Embedded Software:
    - Tiva C TM4C123GH6PZ microcontroller acts as a master. This microcontroller is used to read the feedback signal from TCRT5000 sensors to identify the position of the mobile robot, then calculate the speed and send velocity to two slaves microcontrollers (Arduino).
    - Two Arduino Nano microcontrollers act as slaves. These two microcontrollers receive the set speed value from the master and implement PID algorithm to control wheel speed.
2. Drawings: folder containing mechanical design drawings, control algorithm design drawings and wiring diagrams of the mobile robot.
3. Demo: folder containing experimental results.
4. Simulation: folder contraining mobile robot simulations using neural network controller and computation tools (Matlab).
5. Architecture: folder containing python code for designing and training neural networks controller.

## Acknowledgement

Thanks to all the team members who contributed to this project while still university students. 
This project would not have been possible without your help.

1. Nguyen Cong Hung ([Email](1611400@hcmut.edu.vn))
2. Tran Cong Vinh([Email](trancongvinh1911@gmail.com))
3. Lam Phung Phuoc Vinh([Email](1652704@hcmut.edu.vn))
4. ([Youtube](https://www.youtube.com/watch?v=LgqDQeK8nGs))

## Maintainers
* Tran Dang Trung Duc
