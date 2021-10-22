classes([yes,no]).
attributes([season,weather,temp,work]).
example(1,yes,[season = spring, weather = sunny,  temp = warm, work = few]).
example(2,yes,[season = summer, weather = cloudy, temp = hot,  work = few]).
example(3,no, [season = summer, weather = rain,   temp = cold, work = few]).
example(4,yes,[season = winter, weather = cloudy, temp = cold, work = plenty]).
example(5,no, [season = winter, weather = cloudy, temp = cold, work = few]).
example(6,yes,[season = autumn, weather = sunny,  temp = hot,  work = plenty]).
example(7,yes,[season = winter, weather = sunny,  temp = warm, work = few]).
example(8,no, [season = autumn, weather = cloudy, temp = warm, work = few]).
example(9,no, [season = summer, weather = cloudy, temp = hot,  work = plenty]).
example(10,no,[season = winter, weather = cloudy, temp = hot,  work = few]).
