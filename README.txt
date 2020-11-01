void turtle init(Turtle *obj, char *name)
This is the \constructor" for the Turtle object (or, if you prefer, the \Turtle
class"). I have already allocated space for the object, and I will pass you a
pointer to it. I will also pass you a pointer to the string.
You must initialize all of the fields of the struct; it should start at the position
(0; 0) and direction 0 (North).

void turtle debug(Turtle *obj)
call this function to make sure that you set the elds of your
turtles correctly. Print out all of the elds of the Turtle, as follows:
Turtle "charlie"
pos 10,3
dir North
odometer 1234

void turtle turnLeft(Turtle *obj), void turtle turnRight(Turtle
*obj)
These functions turn the turtle 90 degress to the left or right. Update
the dir field.
Make sure to limit the range to [0; 3] (inclusive). That is, if the
turtle is facing North (dir=0) and turns left, the correct new dir is 3,
not -1.

turtle move(Turtle *obj, int dist)
This function moves the turtle forward by a certain distance. You
may assume that the distance is valid; it might be positive, negative,
or zero. If the distance is positive, then it moves in the direction that
it is facing; if it is negative, then it moves in the opposite direction
(but keeps its current facing).
