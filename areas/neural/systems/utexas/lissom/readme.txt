Contents: Code and images of LISSOM simulations.
Status of code: Research code, not well documented. 

Note: The LCSOFM algorithm has been renamed as LISSOM for Laterally
Interconnected Synergetically Self-Organizing Map.

About the images:
----------------
This directory contains gif images of the development of lateral connections
and ocular dominance in the primary visual cortex. The development was
modeled by the LCSOFM algorithm described in the paper "Self-Organization
with Lateral Connections" (postscript version: /pub/neural-nets/papers/ai92-191.ps.Z).

The cortex was modeled by a 40x40 network of neurons with short-range 
excitatory and long-range inhibitory lateral connections. Inputs to the 
network consisted of three values: two retinotopic co-ordinates and one
value for ocular dominance. The afferent weights of neurons were initialized
roughly retinotopically, but with random ocular dominance.

The figures illustrate the self-organization of ocular dominance and lateral 
connections. Each neuron is labelled with a color corresponding to its 
ocular dominance. Ocular dominance varying from exclusive left eye preference 
to binocularity to exclusive right eye preference is represented by graded 
colors: {black -> red -> yellow -> white}. Small blue dots mark the neurons 
to which horizontal inhibitory connections survive from the neuron marked 
with a big blue dot.

sim0.gif: Initial state of the network : neurons have randomly distributed
	ocular dominance. Horizontal inhibitory connections of each neuron
	spread over a large part of the network.

sim1.gif: Early in self-organizaton, ocular dominance emerges as connection
	weights adapt. 

sim2.gif: Immediately after the critical period, weak lateral inhibitory 
	connections die off : the surviving connections predominantly link 
	areas of same ocular dominance. 

sim3.gif: As simulation proceeds, both ocular dominance patterns and 
	horizontal connection patterns refine and become specific. 

sim4.gif: When self-organization stabilizes, surviving lateral connections 
	of a neuron connect areas of similar eye preference. Further training
	and connection elimination has no effect on the pattern of connections.

The images s0.gif, s3.gif, s4.gif and s7.gif are versions of the above
colored red->black->green as the eye preference varies from
left->binocular->right.
