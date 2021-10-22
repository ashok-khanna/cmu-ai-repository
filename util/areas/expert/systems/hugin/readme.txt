
                =====================================

                  Welcome to the anonymous ftp site

                                  at

                      Hugin Expert A/S, Denmark.

                =====================================


 Hugin Expert A/S is the worlds leading expert system software house in
 construction and execution of Belief Networks (also known as Bayesian
 Networks, or Causal Probabilistic Networks).

 The HUGIN Expert System has successfully been applied to a variety of
 knowledge areas:

        - Diagnosis and repair on board unmanned underwater vehicles
        - Thunderstorm warning systems
        - Treatment of diabetes
        - Diagnosis in therapy in electromyography
        - Process control in waste water purification
        - Fault analysis in aircraft control
        - Control of centrifugal pumps
        - Image scene interpretation in computer vision and robotics
        - Early fault detection
        - etc.

 The HUGIN Expert System is currently in use at, among others:

        - Lockheed Missiles and Space Company, USA
        - NASA / Johnson Space Center, USA
        - USDA Forest Service, USA
        - Pacific Sierra Research, USA
        - GSF Medis, Germany
        - Nuclear Electric plc., Great Britain
        - Lucas Engineering & Systems ltd., Great Britain
        - Aalborg Portland, Denmark

        - Educational Testing Service, Princeton, USA
        - University of California at Berkeley, USA
        - Stanford University, USA
        - Columbia University, USA
        - University of Southern California, USA
        - Universita Degli Studi di Pavia, Italy
        - Universita di Bari, Italy
        - Universidad Politecnica de Madrid, Spain
        - Open University, Great Britain
        - City University, London, Great Britain
        - Delft University of Technology, The Nederlands
        - Utrecht University, The Nederlands
        - Kyushu Institute of Technology, Japan
        - Institut fur Betriebssysteme und Rechnerverbund, Germany
        - The Royal Veterinary Agricultural University, Denmark
	- Research Center Foulum, Denmark


                              * * * * *

 We have two products:

        * HUGIN Explorer
                A graphical expert system shell, for construction and
                execution of Belief Networks.

        * HUGIN Professional
                In addition to the graphical expert system shell, this
                product contains the Hugin API, a C library containing
                all functionality of the Hugin System. The Hugin API
                enables you to integrate Hugin in your own applications.

 The current prices are:

        * HUGIN Explorer
                                        ECU    700

        * HUGIN Professional
                1 user license          ECU   7500
                2 user license          ECU  11250
                site license            ECU  15000

 All prices are quoted in ECU (European Currency Unit).
 Ultimo August, 1993, the exchange rate was 1 ECU ~ 1.15 US$.

 Currently the graphical interface only runs on Sun workstations. Medio
 September a Windows 3.1 version for PCs will be available.

 The API C library can easily be ported to other platforms.


                              * * * * *


 In the /pub directory, you will find a demonstration version.

       **** Please, remember to set binary transfer mode! ****

 Contents
 ========

 Directory /pub:

        hugin_demo_sun4.tar
        -------------------

                A SPARC demonstration version of Hugin Explorer.

                This program runs under SunOS 4.X.
                                        ----------

                The file is a tar file. To extract:

                        tar xvf hugin_demo_sun4.tar

                This will create a directory called `HUGIN_DEMO'.
                See the `README' file in this directory for further
                information.

        hugin_demo_solaris.tar
        ----------------------

                A Solaris version of the above.



 You may from time to time find other things in here. You will not
 have any use of these files (the files are encrypted).



                              * * * * *


 For further information, please contact:

        Hugin Expert A/S
        Niels Jernes Vej 10
        DK-9220 Aalborg
        DENMARK

        Phone: +45 15 66 44
        Fax:   +45 15 85 50
        Email: info@hugin.dk



                              * * * * *



                             HUGIN Usage
                             ===========

                          Perry McCarty, Jr.
                         Research Scientist,
                          Lockheed AI Center

                          Received: May 1993


  At  Lockheed's Artificial  Intelligence  Center we  have  had  a  site
  license for Hugin since around August 1991.  Starting in January 1988,
  we  began  an internal  research  program  on  developing  methods for
  decision-making in contexts in which uncertainty was present.  We were
  familiar with the research in  decision-analytic methods  using belief
  networks, and at the time much of the research focus was on algorithms
  to make  probabilistic reasoning  perform  rapidly enough  to apply to
  large knowledge-based problems.

  We developed an  in-house  experimental testbed  for evaluating  these
  algorithms as they  became known.  One of the first was the Lauritzen-
  Spiegelhalter  approach,  a precursor to  the  algorithm  currently in
  Hugin.  At  the time, with  all of  the interest in, and publishing of
  alternative  methods,  we  expected that  the  Lauritzen-Spiegelhalter
  approach  would soon be surpassed in performance.  It was not until we
  received a draft of  a paper by Shachter, Szolovits, and Andersen that
  demonstrated the essential equivalence of the many seemingly different
  algorithms, that we  decided  that  the  Hugin method (a refinement of
  Lauritzen-Spiegelhalter) appeared to be as good as any exact algorithm
  was likely to be.

  Lockheed's AI Center is in the Stanford Industrial Park, and we are in
  close  contact with research  at  Stanford in probabilistic  reasoning
  using belief networks.   Based on my own familiarity with  the  field,
  and  on  comments  from  people  such  as  Ross  Shachter,  a  leading
  researcher in belief networks, Hugin is generally regarded as the best
  industrial strength belief  net software package.  Additionally, there
  is  a large group at Aalborg  that is performing leading-edge research
  in the  area,  and their ideas will soon be  embodied in future  Hugin
  releases.  That is critical  in  a  rapidly  developing  area  such as
  belief networks.

  The internal research project that I led eventually proposed and won a
  contract  for  developing  a  diagnostic   system   for   a  real-time
  controller.  The project very leading-edge,  and  is  of medium  risk.
  Our  in-house  software was adequate  for  testing  and  refining  our
  concept, but was not sufficiently fast to meet the scale and computing
  demands of our contract.   We chose  to  use Hugin, because we felt it
  was the  software  that  was most likely to  meet  the demands of  our
  application.

  We  have  been  extremely happy  with our  choice.   The  software  is
  blindingly fast  (it  is  very  impressive!).   The  MUNIN application
  resulted  in   the  development  of  several  techniques  to   improve
  efficiency, and we are thrilled  that Hugin incorporates  all of them.
  The  support has been excellent.  Even  though we are several thousand
  miles from the Hugin group, we often  get a response within 15 minutes
  to our E-mail requests.  Distribution via ftp has enabled us to obtain
  updates as  soon as  they become available,  at low cost, rather  than
  waiting for weeks for packages to be delivered.

  Additionally, we are in close  contact with participants in Hugin.  We
  have been able to  make suggestions as  to  enhancements that we would
  like in order for Hugin to become  even better.  Knowledge of features
  in  future  releases  improves  our  planning  for  our   project.   A
  significant benefit of  the  Hugin site  license is that we  have also
  been  able to download  some  of  the  research  prototypes  of  Hugin
  software.  As a  research department,  that has  been  very useful  in
  testing  ideas  even   before  the  techniques  are  embodied  in  the
  commercial product.

  We  have  been very  satisfied with  Hugin  to date and have been very
  happy to inform others of the excellence of the product.

  Our current project has been a research project, not involving a large
  number  of  runtime-licenses.   However  due  to the  success  of  the
  project,  a number of other departments within the  group are planning
  to buy Hugin. Lockheed, Houston has already bought  one for their NASA
  project and  my  guess is another 3-5 site licenses as a follow-on  to
  our current project.

  I definitely see potential for  growing to much larger sales after 2-3
  years, and I am looking forward to the prospects.


                              * * * * *
