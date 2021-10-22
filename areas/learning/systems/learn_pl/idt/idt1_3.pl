classes([accept,reject]).
attributes([account,cash,employed]).
example(1,accept,[account = bank, employed = yes, cash = 300]).
example(2,accept,[account = bank, employed = yes, cash = 300]).
example(3,reject,[account = bank, employed = no,  cash = 300]).
example(4,accept,[account = bank, employed = no,  cash = 4000]).
example(5,accept,[account = none, employed = yes, cash = 4000]).
example(6,reject,[account = none, employed = yes, cash = 300]).
example(7,reject,[account = none, employed = no, cash = 300]).
example(8,reject,[account = none, employed = no, cash = 4000]).
example(9,reject,[account = none, employed = no, cash = 4000]).
example(10,reject,[account = others, employed = no, cash = 300]).
example(11,accept,[account = others, employed = no, cash = 4000]).
example(12,reject,[account = others, employed = no, cash = 300]).
