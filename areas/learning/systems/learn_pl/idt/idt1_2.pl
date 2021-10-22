classes([accept,reject]).
attributes([account,cash,employed,credits]).
example(1,accept,[account = bank, cash = 700, employed = yes, credits = 200]).
example(2,reject,[account = bank, cash = 300, employed = yes, credits = 600]).
example(3,reject,[account = none, cash = 0, employed = yes, credits = 400]).
example(4,accept,[account = others, cash = 1200, employed = yes, credits = 600]).
example(5,reject,[account = others, cash = 800, employed = yes, credits = 600]).
example(6,accept,[account = others, cash = 1600, employed = yes, credits = 200]).
example(7,accept,[account = bank, cash = 3000, employed = no, credits = 300]).
example(8,reject,[account = none, cash = 0, employed = no, credits = 200]).

