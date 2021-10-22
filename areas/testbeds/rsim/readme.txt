
    ROBOT SIMULATOR
    ===============

    By Andrew Conway and Craig Dillon,
    contact Craig Dillon,
        cdillon@vis.citri.edu.au,
        Department of Computer Science,
        Melbourne University,
        Australia.

    This package is a graphical robot simulator that does discrete time
    simulation of an arbitrary linked robot arm, with full kinematics and
    dynamics. There is a discrete-time controller and a standard C interface
    so that users can create and test different controller algorithms.

    The robot simulator currently only works on SGI machines, and in a 
    no-graphics mode on other machines. When the IPRS GUI standard is
    established, we will be converting this to run under IPRS, which will
    make it machine independant.

    For Indigos, which have smaller screens than PIs, we have simply
    hacked the window openings to make the whole thing alot smaller. This
    will be done more elegantly later.

    This package is copyright in all the normal ways... we don't mind people
    copying and distributing the code, or using it to inspire new code,
    but full acknowledgement is expected.

    The directories under the robot simulator are the following:

        arc    - an internal directory (ignore)
        chey - an internal directory (ignore)
        demos - sample configuration files
        plan - an internal directory
        src - the main source directory
        text - the documentation
        visual - an internal directory

    To make the simulator, go into the src directory and type:

    unix% make

    The Makefile is standard, and can be editted to suit...

    The documentation is all under the text directory, and discusses the
    simulator at length.

    To run the demos, you will need to run rsim from the local directory.

    NOTE: To get the simulator, ftp the file rsim.tar.z and use gunzip
        to unzip the file (unzip and uncompress won't work) and then
        tar to untar it. If you don't have gzip, I have included an
		exploded version (raw) of the file, but don't take this unless
		you really must as it is 6 meg in size.

    NOTE: This is a pre-release style version, and we will tidying it up
    as time goes by, and incorporating new components (including the
    chey directory). 
