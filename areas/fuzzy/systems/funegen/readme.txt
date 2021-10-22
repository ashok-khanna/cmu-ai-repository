 

              *****************************************
              *                                       *
              *  FuNeGen 1.0 Demonstration Programme  *
              *              Read.Me                  *
              *      last updated: 07.05.1994         *
              *                                       *
              *****************************************
              


What is FuNeGen 1.0
-------------------

FuNeGen 1.0 is based on the concept of fuzzy-neural system FuNe I, that can 
generate a fuzzy classifier system from sample data (training file) without
expert help for real world applications. There is no restriction regarding 
the number of inputs or outputs, since a special architecture is used to 
generate human interpretable fuzzy rules. Performance of extracted fuzzy 
systems can be indicated by using a new set of sampling data (test file). 
Apart from the transparency of the generated fuzzy system,  the posterior 
input feature reduction, i.e., the removal of redundant inputs, can be done 
automatically!
 
The system extracts an untuned  knowledge base in the first phase. The 
extracted fuzzy system is tuned in the second phase. The maximum number of 
rules to be considered for the final solution can be optionally limited 
by the user. If this is less than the extracted number of rules tuned in the 
second phase, the additional weaker rule nodes are simply removed from the 
already tuned solution. The system also provides the performance for the 
complete set of extracted rules and that for the user selected number of rules. 
It is in most cases better to do a second optimization after removal of rule 
nodes.

FuNeGen 1.0 can generate 
(a) C code 
(b) FPL code
(c) VHDL descriptions
from the extracted and optimized fuzzy system.


This allows the realtime implementation of generated fuzzy systems.
Both demonstration versions generate C-code automatically with tuned 
membership functions and  if-then, and if-then-not rules.

Three types of fuzzy rules can be extracted:

(a) simple rules having only a single fuzzy input in the premise.
(b) conjunctive rules having two fuzzy inputs in the premises
(c) disjunctive rules having two fuzzy inputs in the premises

Integration of a priori knowledge to the automatic extraction of the 
knowledge base is possible either before any of the optimization phases 
or before the rule extraction phase.


Two demonstration versions:
---------------------------

(a) a limited version with a demonstrating example 
    -- classification of IRIS species [1].
    
(b) a more flexible version  with a real world example.

In the limited version MAXIMUM NUMBER OF INPUTS IS LIMITED TO 7 
(it is still more powerful than other commercially available simulators).
Another restriction is that it ONLY  extracts C-CODE from the 
generated and optimized fuzzy system.
    

Installing  FuNeGen 1.0
-----------------------
Please download the compressed forms of fune1.exe, fune1.opt, egavga.bgi, 
and the iris training file train.dat and the iris test file test.dat.

You can start FuNeGen 1.0 on any IBM compatible PC system with a
processor equal or higher than 80286. 
To achieve comfortable processing speeds, it is better to use a PC system 
containing a processor 80386 or higher.


To view membership functions at the end, the PC system must have a 
VGA-card. A color monitor is desirable.

Running FuNeGen 1.0
-------------------

The programme can be started with ``fune1''.

Data  files must have the format:

I1 I2 I3 I4 ....In  O1 O2 ...Om

or

I1 I2 I3 I4 ....In  O1 
& O2 ...Om


where I[1..n] is the input data vector and the O[1..m] is the output 
data vector. If more than one line is needed for a single input/output 
pattern you have to indicate it by adding ``&'' at the beginning of the 
additional line.

The rules you get can be interpreted as a special case of 
Sugeno type fuzzy rules:

Sugeno type: 

IF I1 is Low AND I2 is High THEN f1 = a *I1 + b*I2 + c

and O1 = f1 * rule strength

FuNe I type:

IF I1 is Low AND I2 is High THEN f1 = c

where c is the rule weight

and O1 = S (f1 * rule strength)

where S is the sigmoid function.

``O1'' is considerd as one of the class attributes.

In case of c < 0, the rule is called a If-Not rule, or a negative rule.

Though FuNe I is usually a classifier generator, 
one can also generate ``FuNe I type'' fuzzy controllers (in this case 
``Out'' is one of the outputs of the controller).


There is an alternative method of using FuNe 1 as a controller generator.

Please divide the range of output  to different subregions that can be 
considered as classes.
e.g. if out1 is between 0 and 10

subregions 0-1, 1-2, 2-3,....9-10.

i.e., you have converted your controller problem to a classification task!
 

About the development of FuNe I system
-------------------------------------

The fuzzy-neural fusion techniques belong to  the major directions of 
fuzzy research [9] at the Institute of Microelectronic Systems 
(Prof. M. Glesner) of the department of Computer Engineering, Darmstadt 
University of Technology.

FuNe I system was developed using the rule extraction method 
described in [2] and [3]. Successful application of FuNe I concept is 
assured for any problem that converges to a satisfactory solution in using 
gradient descent algorithms. Better results with compared to the 
backpropagation are achieved in applications described in papers [4] and [5].

Several students engaged in master research at the university including Martin 
Schoeneck, Jean Ghozal, Suhardi Ting, Tilman Wagner, Georg Ickstadt, Andreas 
Pfeffermann, Patrick Schweikert, Christoph Grimm, Martin Bauerle and Nader Zadeh 
have been working in the related projects. The software implementation of 
FuNeGen 1.0 for MS-DOS compatible PC systems was the master project 1 
``Studienarbeit'' of Martin Schoeneck. 


Availability of papers and software
-----------------------------------

The most important reference paper [3]  for understanding the methods developed
 for FuNeGen 1.0 and an alternative method based on RBFN [10] is available in 
 our ftp site: obelix.microelectronic.e-technik.th-darmstadt.de
directory: cd pub/neurofuzzy

The limited test version of FuNeGen 1.0 described above, an index and this 
read.me file are also available in the same ftp site. Depending on the 
 application we will consider providing the unlimited version !


 
Future Developments
-------------------

FuNeGen Deluxe, a comfortable tool for MS-DOS Windows environment is under 
development. Alternative methods for generation of rules and membership 
functions are added. User may be able to choose between gradient descent 
techniques and other clustering methods (e.g. [7]) in extracting the knowledge 
base. Automatic generation of codes for standard hardware will be integrated. 
Furthermore, the development of listings for FPGA will allow rapid prototyping, 
i.e., from representative sample data to real time systems in a short 
development time!


FuNeGen 2.0, a generater of fuzzy controllers, based in FuNe II [6],[8]
is under development. The customizable, transparent defuzzification 
strategy described in [6] is the new feature in this system. The approach
taken here allows each application to  create its own defuzzification 
method. 


References
----------


[1] @ARTICLE{And35,
    AUTHOR     = {E.~Anderson},
    TITLE      = {{The Irises of the Gaspe Peninsula}}, 
    JOURNAL    = {Bull.~Amer.~Iris Soc.},
    VOLUME     = {59},
    YEAR       = {1935}
    }


[2] @INPROCEEDINGS{Hal92,
    AUTHOR     = {S. K. Halgamuge and M. Glesner}, 
    TITLE      = {{A Fuzzy-Neural Approach for Pattern Classification with 
                   the Generation of Rules based on Supervised Learning}}, 
    BOOKTITLE  = {Neuro-Nimes 92},
    ADDRESS    = {Nimes, France},
    MONTH      = {November},
    YEAR       = {1992}
    }
    
[3] @ARTICLE{Hal94-J2,
    AUTHOR     = {S. K. Halgamuge and M. Glesner},
    TITLE      = {{Neural Networks in Designing Fuzzy Systems for 
                   Real World Applications}}, 
    JOURNAL    = {International Journal for Fuzzy Sets and Systems (accepted)  
                  (editor: H.-J. Zimmermann)},  
    PUBLISHER  = {North Holland},
    YEAR       = {1994}
    }

[4] @INPROCEEDINGS{Hal93-2,
    AUTHOR     = {S. K. Halgamuge and W. Poechmueller and M. Glesner},
    TITLE      = {{A Rule based Prototype System for Automatic Classification 
                   in Industrial Quality Control}}, 
    BOOKTITLE  = {IEEE International Conference on Neural Networks' 93},
    ADDRESS    = {San Francisco, USA}, 
    MONTH      = {March},
    YEAR       = {1993}
    }

[5] @INPROCEEDINGS{Hal93-3,
    AUTHOR     = {S. K. Halgamuge and H.-J. Herpel and M. Glesner},
    TITLE      = {{An Automotive Application With Neural Network Based 
                   Knowledge Extraction}}, 
    BOOKTITLE  = {Mechatronical Computer Systems for Perception and Action' 93},
    ADDRESS    = {Halmstad, Sweden}, 
    MONTH      = {June},
    YEAR       = {1993}
    }
    
[6] @INPROCEEDINGS{Hal93-4,
    AUTHOR     = {S. K. Halgamuge and M. Glesner},
    TITLE      = {{The Fuzzy Neural Controller FuNe II with a New Adaptive 
                   Defuzzification Strategy Based on CBAD Distributions}}, 
    BOOKTITLE  = {European Congress on Fuzzy and Intelligent Technologies'93},
    ADDRESS    = {Aachen, Germany}, 
    MONTH      = {September},
    YEAR       = {1993}
    }

[7] @INPROCEEDINGS{Hal94-6,
    AUTHOR     = {S. K. Halgamuge and W. Poechmueller and A. Pfeffermann 
                  and P. Schweikert and M. Glesner},
    TITLE      = {{A New Method for Generating Fuzzy Classification Systems 
                   Using RBF Neurons with Extended RCE Learning}}, 
    BOOKTITLE  = {IEEE International Conference on Neural Networks' 94,
                 (accepted)},
    ADDRESS    = {Orlando, USA}, 
    MONTH      = {June},
    YEAR       = {1994}
    }

[8] @INPROCEEDINGS{Hal94-2,
    AUTHOR     = {S. K. Halgamuge and T. Wagner and M. Glesner},
    TITLE      = {{Validation and Application of an adaptive transparent   
                     Defuzzification Strategy for Fuzzy Control}}, 
    BOOKTITLE  = {IEEE International Conference on Fuzzy Systems' 94,
                  (accepted)},
    ADDRESS    = {Orlando, USA}, 
    MONTH      = {June},
    YEAR       = {1994}
    }

[9] @PHDTHESIS{Hal94phd,
    AUTHOR     = {S. K. Halgamuge},
    TITLE      = {{Advanced Methods for Fusion of Fuzzy Systems and Neural 
                   Networks in Intelligent Data Processing (in preparation)}},
    SCHOOL     = {Darmstadt University of Technology, 
                  Department of Computer Engineering},
    YEAR       = {1994}
    }

[10] @TECHREPORT{Hal94-R1,
    AUTHOR     = {S. K. Halgamuge and W. Poechmueller and M. Glesner},
    TITLE      = {{An Alternative Approach for Generation of Membership 
                   Functions and Fuzzy Rules  Based on Radial and Cubic 
                   Basis Function Networks}}, 
    INSTITUTION= {Darmstadt University of Technology, Department of Computer 
                  Engineering, Institute of Microelectronic Systems},
    YEAR       = {1994}
    }



Further information/requests/comments/flames :

Saman K. Halgamuge
Darmstadt University of Technology
Institute of Microelectronic Systems
Karlstr. 15
D-64283 Darmstadt
Germany

Tel.: ++49 6151 16-5136
Fax.: ++49 6151 16-4936

Email: saman@microelectronic.e-technik.th-darmstadt.de
              
              
              
             


