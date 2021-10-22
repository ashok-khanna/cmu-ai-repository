// GMD - SET - L. Peters Fuzzy Class Vers. 2.1 - 6.9.93 
A fuzzy logic controller can be build out of elements belonging to Mfc_Array
or Mfc_Loop. The class Mfc_Array corresponds to the classical fuzzy
controller. Mfc_Loop has an aditional feedback loop which can change the rules
during the controlling process. For explanation of the approach see paper in IEEE-FUZZ 93.

Helping hints: 

int in_lil; // number of inputs

Mfc_Array *gmd_lil; // fuzzy controller is a n x (m+1) array. Where n is the
number of rules and m the number of inputs. The last column (m+1) is needed
for the deffuzification process.

// rule file in_rule has the number of rules, inputs+1 ( 1 for  output) and the
description of each rule and corresponding mfc.

ifstream in_rule (argv[1], ios::in);
if (!in_rule)
	error_handler (1, " kann Regeldatei nicht lesen");	

// Initialise the controller gmd_lil ( shape of the Mfc, rule, defuzzifier)


gmd_lil = init_fuzzy(in_rule)

// print the stored configuration
in_lil = gmd_lil[0].Mfc_Array_dim();
 for (i = 0; i<in_lil; i++) 
	gmd_lil[i].Mfc_Array_print(); 
cout << "\n " ;

//inference process
// stimuli is the vector of dimension in_lil in which is stored the input signal for
the fuzzy controller
Max_min(gmd_lil, stimuli,in_lil);

// print the defuzzified output;
cout << "\nDefuzzy =  "<<gmd_lil[in_lil].DefOut();
cout << "\n";


If the above hints are still to fuzzy for you contact me at the following e-mail
address:  peters@gmd.de

-- 
-----------------------------------------------------------------
      Liliane E. Peters                e-mail: peters@gmd.de
          GMD-SET                              
        Schloss Birlinghoven           phone:  (+49) 2241 14 2332
D-53737 St. Augustin, Germany          fax:    (+49) 2241 14 2342
-----------------------------------------------------------------
