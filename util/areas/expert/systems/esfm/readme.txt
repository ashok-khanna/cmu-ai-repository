esfm.tar.Z
    Prolog expert system for forestry management.
    Steve Jones, Reading University.

              PROLOG EXPERT SYSTEM FOR FORESTRY MANAGEMENT
             Contributed by Steve Jones, Reading University
                    Received on the 3rd of March 1988
                    Shelved on the 15th of March 1988


I enclose  a small expert  system for  forestry management which  was in
another  newsgroup.   Anybody  who  missed   it  there  might   find  it
interesting. I  was running it  under PROLOG2,  but it should  run under
most other dialects, although all the "s may need to be changed to '.
[ Steve Jones ]


I've  modified  the  code  so   it  runs  under  Edinburgh  Prolog,  and
reformatted it.

The system (which I'll call ESFM)  contains about 30 IF-THEN rules about
forestry management. These are stored as Prolog clauses, for example:

    recommendation('scatter cones') :-
        fact(branch18,yes),
        fact(silvaculture,clearcut),
        fact('improved stock',no),
        fact('good cone supply',yes),
        recommend(
            'You should scatter the serotinous cones over the area.'
        ).

Inference  is  depth-first, backward-chaining,  and  is  done by  having
Prolog execute the  rules. ESFM does not explain why  it asks questions,
nor how it comes to a conclusion.                   


Here's a sample consultation:

    ?- go.
    Is the stocking of the jack pine stand currently
    at least minimum ?

    If you are unsure of how to determine stocking,
    see page 4 in the Managers Handbook for Jack Pine

    |: yes.

    Is the average diameter of the trees less than 5 inches ?|: no.

    Is the age of the stand mature or immature ?|: mature.

    Do you want to keep jack pine in this area ?|: no.


    Based upon your responses, the following is recommended :

    You should convert the area to some more desirable kind of tree.

    To see the complete set of derived facts, type "display_kb."

    ?- display_kb.
    stocking good is yes
    avg < 5 is no
    age is mature
    pine desired is no
    advice is You should convert the area to some more desirable kind of
     tree.
[JNP]



SIZE: 11 Kilobytes.


CHECKED ON EDINBURGH-COMPATIBLE (POPLOG) PROLOG : yes.


PORTABILITY :

    Easy, no known problems.


INTERNAL DOCUMENTATION :

    Very little.



    
