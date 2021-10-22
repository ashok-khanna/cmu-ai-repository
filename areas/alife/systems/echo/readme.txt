
This area contains files related to John Holland's Echo model, which is
under development at the Santa Fe Institute. Source for Echo can be obtained 
via anonymous ftp from alife.santafe.edu in the directory pub/SOFTWARE/Echo. 
Instructions for installation are included. The instructions are also 
available separately in the file how-to.ps.Z also in the directory.

The following is a fairly high-level description of Echo, taken from
the introduction of the how-to document. Some references are also
included below.

Echo is a model of complex adaptive systems formulated by John
Holland.  It abstracts away virtually all of the physical details of
real systems and concentrates on a small set of primitive agent-agent
and agent-environment interactions.  The extent to which Echo captures
the essence of real systems is still largely undetermined.  The goal
of Echo is to study how simple interactions among simple agents lead
to emergent high-level phenomena such as the flow of resources in a
system or cooperation and competition in networks of agents (e.g.,
communities, trading networks, or arms races).

An Echo world consists of a lattice of sites. Each is populated by
some number of agents, and there is a measure of locality within each
site.  Sites produce different types of renewable resources; each type
of resource is encoded by a letter (e.g., ``a,'' ``b,'' ``c,'' ``d'').
Different types of agents use different types of resources and can
store these resources internally. Sites charge agents a maintenance
fee or tax. This tax can also be thought of as metabolic cost.

Agents fight, trade and reproduce. Fighting and trading result in the
exchange of resources between agents. There is sexual and non-sexual
reproduction, sexual reproduction results in offspring whose genomes
are a combination of those of the parents. Each agent's genome encodes
various genes which determine how it will interact with other agents
(e.g., which resource it is willing to trade, what sort of other
agents it will fight or trade with, etc.).  Some of these genes
determine phenotypic traits, or ``tags'' that are visible to other
agents.  This allows the possibility of the evolution of social rules
and potentially of mimicry, a phenomenon frequently observed in
natural ecosystems. The interaction rules rely only on string
matching.

Echo has no explicit fitness function guiding selection and
reproduction.  An agent self-reproduces when it accumulates a
sufficient quantity of each resource to make an exact copy of its
genome.  This cloning is subject to a low rate of mutation.


Terry Jones (terry@santafe.edu)
March 23, 1994.



Holland, John H. (1992a).
The Echo Model,
in ``Proposal for a Research Program in Adaptive Computation''.
Santa Fe Institute, July 1992.

Holland, John H. (1992b).
Adaptation in Natural and Artificial Systems, 2nd Ed.,
MIT Press, 1992.

Holland, John H. (1993).
ECHOING EMERGENCE : Objectives, Rough Definitions, and
Speculations for Echo-class Models,
To appear in ``Integrative Themes'', George Cowan, David Pines and
David Melzner Eds. Santa Fe Institute Studies in the Sciences of
Complexity, Proc. Vol XIX. Reading, MA: Addison--Wesley 1993.

Jones, Terry and Forrest, Stephanie (1993).
An Introduction to SFI Echo,
Santa Fe Institute TR 93-12-074

