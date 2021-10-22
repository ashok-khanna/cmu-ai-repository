classes([accept,reject,ask]).
attributes([account,cash,employed]).
example(1,accept,[account = bank, employed = yes, cash = 300]).
example(2,accept,[account = bank, employed = yes, cash = 300]).
example(3,accept,[account = bank, employed = no,  cash = 300]).
example(4,accept,[account = bank, employed = no,  cash = 4000]).
example(5,accept,[account = none, employed = yes, cash = 4000]).
example(6,reject,[account = none, employed = yes, cash = 300]).
example(7,reject,[account = none, employed = no, cash = 300]).
example(8,reject,[account = none, employed = no, cash = 4000]).
example(9,reject,[account = none, employed = no, cash = 4000]).
example(10,ask,[account = others, employed = no, cash = 300]).
example(11,ask,[account = others, employed = no, cash = 4000]).
example(12,ask,[account = others, employed = no, cash = 300]).
