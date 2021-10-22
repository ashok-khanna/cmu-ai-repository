domaintype(color,nominal).
valueset(color,[red,green,blue]).
domaintype(temp,linear).
order(temp,[cold,warm,hot]).
domaintype(shape,nominal).
valueset(shape,[square,hexagon,octagon]).
classes([past,present,future]).
events(past,[[[color=red],[shape=square],[temp=warm]],
             [[color=red],[shape=hexagon],[temp=hot]],
             [[color=green],[shape=hexagon],[temp=cold]]]).
events(present,[[[color=blue],[shape=square],[temp=warm]],
                [[color=red],[shape=hexagon],[temp=hot]],
                [[color=red],[shape=hexagon],[temp=hot]]]).
events(future,[[[color=green],[shape=hexagon],[temp=warm]],
               [[color=red],[shape=hexagon],[temp=hot]],
               [[color=blue],[shape=octagon],[temp=hot]]]).

