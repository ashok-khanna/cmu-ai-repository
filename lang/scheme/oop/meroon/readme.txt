From queinnec@arbois.inria.fr Wed Mar  2 17:49:00 EST 1994
Article: 8394 of comp.lang.scheme
Xref: glinda.oz.cs.cmu.edu comp.lang.scheme:8394
Path: honeydew.srv.cs.cmu.edu!nntp.club.cc.cmu.edu!news.mic.ucla.edu!library.ucla.edu!agate!howland.reston.ans.net!pipex!warwick!zaphod.crihan.fr!jussieu.fr!univ-lyon1.fr!news-rocq.inria.fr!arbois.inria.fr!queinnec
From: queinnec@arbois.inria.fr (Christian Queinnec)
Newsgroups: comp.lang.scheme
Subject: Meroon V3  [general distribution]
Date: 2 Mar 1994 13:19:22 GMT
Organization: INRIA * Rocquencourt BP 105 * F-78153 LE CHESNAY CEDEX* France
Lines: 115
Distribution: world
Message-ID: <2l23oq$hj8@news-rocq.inria.fr>
NNTP-Posting-Host: arbois.inria.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Keywords: Object-oriented programming in Scheme

I am glad to announce a new release of Meroon V3 with improved features.

It is also possible now to build an extended compiler based on Bigloo 1.6
to compile files using Meroon features. In particular, files with the
`.oon' extension are automatically handled by bigloo++ relieving you
to specify the interface module, library archive, and other boring
(but relevant) details.

You can still of course use it, interpreted, with Scheme->C -- 15mar93jfb,
Elk 2.2, Bigloo 1.6, Scm4c5 and slib1d14, Mac Gambit 1.9.

You can find this new release on
        ftp.inria.fr:INRIA/Projects/icsla/Programs/MeroonV3-94Mar02.tar.gz
And you can get Bigloo on
        ftp.inria.fr:INRIA/Projects/icsla/Implementations/bigloo1.6.tar.gz




For the interested readers, here follows the beginning of the README:


               ***********************************************
                   Small, Efficient and Innovative Class System
                                 Meroon V3 [StCharles Release]
                              Christian Queinnec  
                  \'Ecole Polytechnique & INRIA--Rocquencourt
               ************************************************

This is the new release of Meroon, an object oriented system written
in Scheme. It adds new features to Meroon ie multimethods, a better
instantiation protocol, coercers as well ...

The distinctive features of Meroon were:

        All objects of Scheme can be seen as Meroon objects (even
        vectors) without restriction on inheritance.

        CLOS-like generic functions. New generic functions and methods
        can be added on previousy defined classes. Generic functions can
        have a multiple arity.

        Self-description features: classes are Meroon objects and can be
        inspected. It is also possible to design new metaclasses.

The distinctive features of Meroon V3 (the current release) are:

        Generic functions now support multimethods. (call-next-method) 
        is cleanly defined for multimethods. For instance, suppose A' is
        a subclass of A and B' a subclass of B. Suppose also a multimethod
        to exist on A' x B then it is not possible to define a method on
        A x B' since this would be ambiguous on A' x B'. It is nevertheless
        still possible to define a method on A' x B'. 

        Generic functions can specify the top-classes they accept to be
        specialized on. For instance, (define-generic (blah-blah (o Point)))
        can only support methods on Point and its subclasses.

        is-a? is done in constant time as well as subclass?. This involves
        an original renumbering of classes detailed in the documentation.
        There is a feature to adopt the same organization as Meroon V2,
        look in the meroon.scm file.

        Generic functions need less room and are faster unfortunately,
        definition of classes is slower. There is a feature in case
        you prefer the old mode of Meroon V2.

        Metaclasses can be used at compile-time to generate code of the  
        accompanying functions. MeroonV2-Class ensures Meroon V2
        compatibility.

        The :eponymous keyword no longer exists. All classes can be obtained
        as the value of the global variable <class-name>-class.

        Fields can be defined with default initializers. The initializer of a
        Mono-Field is a thunk, the initializer of a Poly-Field has a
        signature of (lambda (index) ...).

        A new instantiation protocol that preserves mutability and
        initialized-ness of fields. The instantiate macro allows to 
        specify the allocation of an instance with keywords mentioning the
        explicit initializations. The default initializers are invoked for
        all non-explicit fields. The initialize! function is applied
        on all freshly allocated objects.

        No more automatically generated allocate-<class-name> functions.
        Use the safer instantiate form instead.

        Automatic coercer generation. These are named -><class-name>,
        they are there to be specialized on your objects. Predefined
        coercers are ->Class and ->Generic. 

        A generic comparator, inspired from Henry G Baker: egal that
        compares any two objects even circular. Two immutables objects
        are egal if they have egal fields. Two mutable objects are egal 
        if they are eqv?. (An object is mutable as soon as it has at least
        one mutable field). 


((((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))
   Christian Queinnec
   LIX -- Laboratoire d'Informatique de l'Ecole Polytechnique
   91128 Palaiseau Cedex
           France
                              Internet: queinnec@polytechnnique.fr
((((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))
   Christian Queinnec
   INRIA Batiment 8
   Domaine de Voluceau -- BP 105
   78153 Le Chesnay Cedex
           France
                              Internet: Christian.Queinnec@inria.fr
                              Tel: +33 1 39 63 57 33
                              Fax: +33 1 39 63 53 30
((((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))


