    Linger: a Prolog tool for grammar analysis of western European
    languages.
    Paul O'Brien and Masoud Yazdani, Exeter University.

                                 LINGER:
    A PROLOG TOOL FOR GRAMMAR ANALYSIS OF WESTERN EUROPEAN LANGUAGES

    Contributed by Paul O'Brien and Masoud Yazdani, Exeter University


LINGER is a language-independent system to analyse natural language
sentences and report and correct grammatical errors encountered. An
important objective is that the system should be easily configured for a
particular natural language by an expert in that language but not in
computer science. [J. Barchan and J. Wusteman]


This library contains two versions of Linger. The older one contains
only a French grammar. The more recent also has German, Spanish, and
English. Both versions were contributed by Paul O'Brien and Masoud
Yazdani, and were written in Expert Systems International Prolog-2.

When I received the older version (1988), I made some changes so that it
would run on other Prologs, tested it, and commented each source file
about the changes. I have not yet done so with the more modern version,
so that is still in the original Prolog-2 source.

As well as the source of Linger, this entry also includes two papers:

    "A Prolog-Based Tool For Grammar Analysis Of Western European
    Languages" by J. Barchan and J. Wusteman:

    Abstract: "In this article, we give an overview of the Language-
    INdependent Grammatical Error Reporter (LINGER). The four key
    techniques in LINGER are identified, the system design and behavior
    described, and directions for future research surveyed".


    "Spanish LINGER" by J. Uren & M. Yazdani:

    Abstract: This paper describes a system currently being developed
    for the teaching of Modern Languages that incorporates "human like"
    knowledge of the domain that it is teaching. The project is a
    progression from the previously (Barchan, Woodmansee and Yazdani,
    1986) developed method of construct- ing tutoring systems for
    specific tasks towards producing tools capable of greater generality
    and use. We hope to clarify the issues arising from the attempt to
    build a flexible tutoring system, for more than one language domain,
    which is capable of being used by teachers in a variety of ways.
    LINGER (Language INdependent Grammatical Error Reporter) was
    originally developed by Barchan(1987) as a prototype tool and since
    then has been the subject of a series of interrelated projects to
    evaluate its potential as a basis for the teaching of Modern
    Languages. In this paper we describe the architecture of LINGER in
    the context of the experiences gained when we tried to extend it to
    deal with the Spanish language.


A sample  run is  shown here:

    ?- [ 'linger_shell.pl' ].

             Type "run" to start LINGER

    linger_shell.pl consulted
    yes

    ?- run.

    LINGER  --  Language INdependent Grammatical Error Reporter

    What language do you want (french/english/spanish/german/italian)?
             ==> |: french.

              consulting Grammar
              consulting Dictionary

    Type your sentence
             ==>|: tu est une chat.

    Pre-parsing sentence

    Trying for a legal parse
    Legal parse found

    Parse tree selected:

     sentence
       main_clause
         subj_phr
           noun_pron_phr
             pronoun : [tu, 1]
         verb_phr
           pos_or_neg_verb_cons
             pos_verb_cons
               rp_pron_list
                 pron_list
                   pron_list2
               governing_verb
                 verb_or_aux_verb
                   aux_verb : [est, 2]
           dir_obj_phr
             noun_phr
               determiner : [une, 3]
               adj_list
               noun : [chat, 4]
               adj_list
           indir_obj_phr

    Your sentence was:

    ---  tu est une chat .  ---

    I think the correct version of your sentence should read:

    >>>  tu est un chat .  <<<

    ****    Comments    ****
    determiner "une" changed to "un" :
    [gender(m), plurality(s), apostrophe(n)]

    ****  End Comments  ****


Masoud Yazdani would like to know if you intend to use Linger. His Janet
E-mail address is MASOUD @ UK.AC.EXETER.CS
                                          [JNP]


SIZE : 366 kilobytes.

CHECKED ON EDINBURGH-COMPATIBLE (POPLOG) PROLOG : yes, for the older
version.

PORTABILITY : no known problems. Converting the newer version from
Prolog-2 should be fairly easy (the main problem will probably be that
Prolog-2 name/2 is incompatible with those in other Prologs). Be guided
by my comments in the older version.

INTERNAL DOCUMENTATION : in the older version, my comments for
portability problems.


