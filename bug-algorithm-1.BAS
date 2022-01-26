MainProgram:    
    // Menu
    GoSub DisplayInstructions
    GoSub ChooseMap

    // Robot
    GoSub SetRobot
    GoSub DrawLineToGoal 

    // Boolean variables
    isFirstHit = false    
    isReachTarget = false
    isAbleToTarget = true

    // Global variables
    turns_around_obstacles = 0

    while true
        GoSub MoveToTarget
        if isReachTarget then break

        GoSub Circumnavigate
        if isReachTarget then break
        if (not isAbleToTarget) then break
    wend
End
//==========================================================
DisplayInstructions:
   data IM;"Bug Algorithm 1"
   data IM;"This program simulates the Bug Algorithm 1."
   data IM;" "
   data IM;"There are 4 maps to choose, each one displayed"
   data IM;"on screen. In map 1 and 3 there exists convex"
   data IM;"obstacles, and in map 2 and 4 there exists"
   data IM;"non-convex obstacles."
   data IM;" "
   data IM;"Simply click on the one you like the most."
   data IM;"The program starts with the robot positionated"
   data IM;"with an angle towards other angle such that it is"
   data IM;"not pointing to the target. Then, it draws a line"
   data IM;"towards the obstacle (m-line), this line points to"
   data IM;"the exact position of the target. After that, it"
   data IM;"navigates using the algorithm previously mentioned."
   data IM;" "
   data IM;" "
   data IM;" "
   data IM;"Angelo Espinoza"


   n = MsgBox(IM)
Return
//==========================================================
ChooseMap:
    data CR_btns;"&Cancel","Map &1"
    data CR_btns;"Map &2","Map &3"
    data CR_btns;"Map &4"
    SaveScr
    Rectangle 55,55,755,555,black,black
    Rectangle 50,50,750,550,cyan,cyan
    ERectangle 52,52,750,550,2,white
    setcolor white,cyan
    xytext 160,80,"Select the map to navigate:","",15,fs_Bold
    for CR_I = 0 to MaxDim(CR_btns,1)-1
       AddButton CR_btns[CR_I],350,210+CR_I*25,150
    next
    while true
      GetButton CR_btn

      if keydown(kc_Esc) then break
      if CR_btn <> "" then break
    wend
    RestoreScr
    for CR_I = 0 to MaxDim(CR_btns,1)-1
      RemoveButton CR_btns[CR_I]
    next

    if CR_btn = "Map &1"
        ClearScr 
        GoSub DrawMap_1
    elseif CR_btn = "Map &2"
        ClearScr 
        GoSub DrawMap_2
    elseif CR_btn = "Map &3"
        ClearScr 
        GoSub DrawMap_3
    elseif CR_btn = "Map &3"
        ClearScr 
        GoSub DrawMap_3
    elseif CR_btn = "Map &4"
        ClearScr 
        GoSub DrawMap_4
    endif
Return
//==========================================================
DrawMap_1:
    LineWidth 4 
    SetColor white 
    FloodFill 0,0,white 
    LineWidth 4
    SetColor black 
    LineWidth 4
    Data Wall_1;-200, 300, 400, 100, 400, 100, 600, 300, 600, 300
    Data Wall_1;400,500, 400, 500, 200, 300, 250, -300 
    MPolygon Wall_1,Lightred
    GoSub SetGoal
Return
//==========================================================
DrawMap_2:
    LineWidth 4 
    SetColor white 
    FloodFill 0,0,white 
    LineWidth 4
    SetColor black 
    Data Wall_2; -449, 265, 616, 238, 270, 159 
    Data Wall_2; 202, 228, 184, 345, 287, 314 
    Data Wall_2; 129, 496, 360, 381, 379, 290+10 
    Data Wall_2; 394, 390, 410, 405, 437, 406 
    Data Wall_2; 462, 383, 449, 266, 281, -371
    MPolygon Wall_2,Blue
    GoSub SetGoal
Return
// //==========================================================
DrawMap_3:
    LineWidth 4 
    SetColor white 
    FloodFill 0,0,white 
    LineWidth 4
    SetColor black 
    LineWidth 4
    Data Wall_1; -100,450,  500,450,  500,360,  100,360,  100,450,  150,-400
    Data Wall_2; -250,250,  500,250,  500,90,   450,90,  450,200,  250,200, 250,250, 260,-240
    
    MPolygon Wall_1, Gray             
    MPolygon Wall_2, Gray
    GoSub SetGoal
Return
//==========================================================
DrawMap_4:
    SetColor white 
    FloodFill 0,0,white 
    LineWidth 4
    SetColor black 
    LineWidth 4
    Data Wall_3;-161, 177, 220, 124, 375, 155, 485, 275 
    Data Wall_3; 624, 300, 668, 370, 517, 412, 499, 320 
    Data Wall_3; 499, 321, 389, 387, 361, 311, 369, 383 
    Data Wall_3; 348, 335, 334, 275, 318, 223, 251, 319 
    Data Wall_3; 161, 177, 247,-193
    MPolygon Wall_3,Green
    GoSub SetGoal
Return
//==========================================================
SetGoal:
    // Variables
    target_x = 570
    target_y = 40

    Circle target_x,target_y,target_x+50,target_y+50,Red,Red // Draw a circle
Return
//==========================================================
SetRobot:
    // Variables
    robot_x = 110
    robot_y = 600
    robotAngle = -50

    rLocate robot_x,robot_y,robotAngle // Place the robot on the scene
    rInvisible Cyan,Red,Gray // Invisible colors for the robot (won't collide with them)
    rPen Down // Draw the path of the robot

    //Calculate the initial angle for robot to face the target
    dx0 = target_x - robot_x
    dy0 = target_y - robot_y 
    if dx0 = 0 AND dy0 = 0
        theta = 0
    else
        theta = PolarA(dx0, dy0) * 180 / pi() + 90 
    if theta > 180 then theta = theta - 360 
    if theta < -180 then theta = theta + 360

Return
//==========================================================
DrawLineToGoal:
    // Draws the m-line line to the goal
    GotoXY robot_x,robot_y // Initial point of the line (q_1^L)
    lineto target_x+25, target_y+25, 1, Gray // Last point of the line (q_goal)      
Return
// ==========================================================
MoveToTarget:
    GoSub FaceGoal
    GoSub MoveToGoal

Return
//==========================================================
FaceGoal:
    dx = target_x - rGpsX()
    dy = target_y - rGpsY()
    if dx = 0 AND dy = 0  then return
    theta = PolarA(dx, dy) * 180 / pi() + 90 - rCompass()  
    if theta > 180 then theta = theta - 360 
    if theta < -180 then theta = theta + 360
    rTurn theta
Return
//==========================================================
MoveToGoal:
    // Variables
    delay_time = 2
    closest_distance = PolarR(target_x-rGpsX(),target_y-rGpsY())
    turns_around_obstacles = 0


    distance = Round(polarR(dx, dy))
    for i = 1 to distance
        // USEFUL INFO
        last_robot_x = rGpsX()
        last_robot_y = rGpsY()

        current_distance = PolarR(target_x-rGpsX(),target_y-rGpsY())
        XYstring 2,0,"Current distance to goal: "
        xyString 2,15,current_distance
        XYstring 2,30,"Closest distance to goal: "
        xyString 2,45,closest_distance

        //////////////////

        current_distance = PolarR(target_x-rGpsX(),target_y-rGpsY())
        if rBumper() & 4
           isFirstHit = true
           HitPoint_x = rGpsX()      // Record the hit point position in X
           HitPoint_y = rGpsY()      // Record the hit point position in y
           break
        endif
        
        if closest_distance < 5
           isReachTarget = true
           xyString 500,100,"Get to the target!"
           break
        endif
        
        rForward 1                  // Move forward 1px 
        // delay delay_time
    next
Return
//==========================================================
Circumnavigate:
    turn_dir = 1 // Initial turning configuration (-1: right, 1:left)
    turn_ammount = 5

    if turn_dir > 0 // If the initial direction is left
        direction_infrared_sensor = 6      // Set the distance sensor to check for right and front  
        checker_infrared_sensor = 1     // Check the right sensor for turning quicker in the spike-shaped obstacles

    else            // If the initial direction is right
        direction_infrared_sensor = 12     // Set the distance sensor to check for left and front
        checker_infrared_sensor = 16    // Check the left sensor for turning quicker in the spike-shaped obstacles
    endif 


    while true
        // USEFUL INFO
        current_distance = PolarR(target_x-rGpsX(),target_y-rGpsY())
        XYstring 2,0,"Current distance to goal: "
        xyString 2,15,current_distance
        XYstring 2,30,"Closest distance to goal: "
        xyString 2,45,closest_distance
        /////////////////

        // Reach the goal? 
        condition1 = PolarR(target_x - rGpsX(),target_y - rGpsY()) < 5
        if condition1 
             isReachTarget = true
             xyString 500, 100, "Get to the target!"
             break
        endif

        // Re-encounter the hit point? 
        condition2 = (PolarR(rGpsX()-HitPoint_x,rGpsY()-HitPoint_y) < 5) and (not isFirstHit)    
        if condition2        
            isAbleToTarget = false
            xyString 2, 2, "Cannot reach the target!"
            break
        else
            temp = rGpsY() - (dy0 / dx0 * (rGpsX() - target_x) + target_y)

            // Encountered a closer point?
            condition3 = (current_distance - 10) < closest_distance

            // Has circumnavigated more than once?
            condition4 = turns_around_obstacles >= 10 and (not isFirstHit)

            if (rGpsX() > last_robot_x - 15 and rGpsX() < last_robot_x + 15) and (rGpsY() > last_robot_y - 15 and rGpsY() < last_robot_y + 20)
                turns_around_obstacles = turns_around_obstacles + 0.5
            endif
          
            if (condition3 and condition4) then  break          
        endif  

        // Obstacle detected (HIT POINT)
        while (rFeel() & direction_infrared_sensor) or (rBumper() & 4)
        // While the distance sensor is triggered from the left and front (direction_infrared_sensor = 12) OR the front collision sensor (#4) is triggered 
        // While the distance sensor is triggered from the right and front (direction_infrared_sensor = 6) OR the front collision sensor (#4) is triggered        
            rTurn -turn_dir // Turn to the right
        wend
        
        rForward 1 // Move always forward to prevent stall

        if PolarR(rGpsX()-HitPoint_x,rGpsY()-HitPoint_y) > 5
            isFirstHit = false
        endif

        if current_distance <= closest_distance 
            closest_distance = current_distance
        endif
        
        // If too far away from wall or no wall
        while not rFeel() // While the distance sensor is returning 0 (no object is being sensing)
            // Turn back quickly to find wall again            
            rTurn turn_ammount*turn_dir // Turn to the right quicker
            rForward 1 // Move forward
        wend
        // delay delay_time
    wend 
Return
//==========================================================
