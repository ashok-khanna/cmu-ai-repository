domaintype(color,nominal) .
valueset(color,[red,green,blue]) .
domaintype(temp,linear) .
order(temp,[cold,warm,hot]) .
domaintype(shape,nominal) .
valueset(shape,[square,hexagon,octagon]) .
classes([past,present,future]) .
events(past,[[[color=red],[temp=warm],[shape=square]],
            [[color=green],[temp=cold],[shape=hexagon]]]) .
events(present,[[[color=blue],[temp=warm],[shape=square]],
               [[color=red],[temp=hot],[shape=hexagon]]]) .
events(future,[[[color=green],[temp=warm],[shape=hexagon]],
              [[color=blue],[temp=hot],[shape=octagon]]]) .

