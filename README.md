# Advent Calendar
This is a simple/lazy standalone port of [The XYZ Network's advent calendar](https://github.com/TheXYZNetwork/PoliceRP-OpenSource/tree/master/addons/xyz_christmas_advent/lua), made in 2019. It removes all the library dependencies from the custom lib XYZ used. Along with removing the MySQL dependency and instead just using Garry's Mod's build in SQL library. There were corners cut in porting this, I just wanted a standalone functioning version before December.

## Things to note
- It should just be drag and drop, the default config rewards have some DarkRP dependencies, but the system does not require DarkRP to function.
- If you don't include all 25 days in the door order, wacky things might happen.
- Don't expect much, this is just a simple port.
- When the server starts, it sets whatever day it is in the server's local timezone as the current door for the rest of the server session. So for example: if you restart your server at 11pm, the door will remain whatever day it was at the point of the restart even into the next day. I have no intentions of accounting for this.

## Preview
![image](https://github.com/owainjones74/advent-calendar/blob/master/preview.jpg)
