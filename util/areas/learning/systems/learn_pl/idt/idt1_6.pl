classes([n,p]).
attributes([outlook,temperature,humidity,windy]).
example(1, n,[outlook = sunny, temperature=hot,  humidity=high,  windy=false]).
example(2, n,[outlook=sunny,   temperature=hot,  humidity=high,  windy=true]).
example(3, p,[outlook=overcast,temperature=hot,  humidity=high,  windy=false]).
example(4, p,[outlook=rain,    temperature=mild, humidity=high,  windy=false]).
example(5, p,[outlook=rain,    temperature=cool, humidity=normal,windy=false]).
example(6, n,[outlook=rain,    temperature=cool, humidity=normal,windy=true]).
example(7, p,[outlook=overcast,temperature=cool, humidity=normal,windy=true]).
example(8, n,[outlook=sunny,   temperature=mild, humidity=high,  windy=false]).
example(9, p,[outlook=sunny,   temperature=cool, humidity=normal,windy=false]).
example(10,p,[outlook=rain,    temperature=mild, humidity=normal,windy=false]).
example(11,p,[outlook=sunny,   temperature=mild, humidity=normal,windy=true]).
example(12,p,[outlook=overcast,temperature=mild, humidity=high,  windy=true]).
example(13,p,[outlook=overcast,temperature=hot,  humidity=normal,windy=false]).
example(14,n,[outlook=rain,    temperature=mild, humidity=high,  windy=true]).

