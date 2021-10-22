Apologies!  the 2.0.1 version has been ftp'd over again, the previous
one had a gzip error.  This one works.

							Patrick

This directories contains subdirectories:

        connel/
                the code for the robot controller.  This can
                be a neural network, or inverse kinematics, or
                whatever.  In the current distribution, an
                inverse kinematics controller.  This code
                is written for a 6DOF manipulator with rotary
                joints.

        simmel/
                the forward controller of the robot.
                Should be connected to the controller, but can
                also work stand-alone for testing.

                The shell script `env' sets the hostnames of
                the computers on which the controller
                (ROBOT_HOST and CAMERA_HOST) and simulator
                (BEMMEL_HOST) run.  Under UNIX, execute it with
                `source env`.

		Since robot-specific code is included, please read
		the manual page before using this code.

        bemmel/
                the robotdraw program.  Can be connected to the
                forward kinematics simulator.
        
        include/
                shared include files.  Esp. note global_communication.h,
                which contains the definitions of the messages
                shared between the programs.
        
        matrix/
                Robot library.
	
	communication/
		Communication library.
        
        socketnr/
                The socket numbers shared between the processes.
                If any socket blocks (i.e., 'socket in use' message
		appears during startup of any of the programs),
		change the socketnr using the next-socket shell
		script, and restart ALL parties.

	doc/
		Documentation in LaTeX and postscript form.

	stand-alone-bemmel/	
		A stand-alone version of bemmel which is
		designed for drawing 3D geometrical figures,
		while changing the viewpoint.  Of course, the
		figures can be dumped to xfig format for
		subsequent touch-up.
