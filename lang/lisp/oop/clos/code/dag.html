#|####################################################################
dag.lisp  
Copyright (C) 1992 National Center for Supercomputing Applications.
Written by Daniel LaLiberte (liberte@ncsa.uiuc.edu).
Version 1.0, Oct 1992

DAG (directed acyclic graph) structures are made of dag-nodes and dag-groups.
dag-group is a subclass of dag-node, and dag-group instances list all the 
sub-nodes of the group.  dag-nodes list all parents, which strictly speaking 
is not part of a dag data structure, so this should probably be called
something like a dag-with-backlinks structure.  One can look at the parent
references as forming an upside down dag structure, but CLOS doesnt deal
well with unshared slots with the same name.

Also, dag-group might be implemented as a subclass of a tree class.
The difference, of course, is that dag-nodes may be shared by multiple
parents.

To support traversals, an external hash table is used (see tally class
below).  This permits multiple simultaneous traversals, and avoids an
extra pass to unvisit.  It is also safer.  One problem is the wasted
space of a hash table each time a traversal occurs.

There is alot of redundancy in the traversal functions.  
How can I simplify them?

Please send comments on this code.  I am interested in improving it.

|#

(defclass dag-node ()
  ((parents  ;; mixed metaphor.  This should be supernodes.
    :documentation
    "A list of all parent groups of this node."
    :initform nil
    :accessor parents)
   )
  (:documentation 
   "An abstract class of nodes of a dag.   Subclassed by dag-group."))


;;####################################################################

(defclass dag-group (dag-node)
  ((subnodes
    :documentation
    "All the nodes contained in this group."
    :initform nil
    :accessor subnodes
    :initarg :subnodes)
   )
  (:documentation 
   "A dag-group is a set of subnodes."))

(defmethod initialize-instance :after ((group dag-group) &key subnodes)
  "Add the nodes, and set their parents."
;;  (format t "init-instance nodes: ~s" subnodes)
  (add-nodes group subnodes)
  group)


;; ##################################################################
;;; Parents

(defmethod add-new-parent ((node dag-node) (new-parent dag-group))
  "Prepend NEW-PARENT to the parents of NODE.
It assumes the parent is not on the list already.
Returns the parents list."
  (pushnew new-parent (parents node))
  )

(defmethod delete-parent ((node dag-node) (parent dag-group))
  "Delete (with delete) the NODE from subnodes of PARENT
and the PARENT from the parents of NODE."
  (setf (parents node)
        (delete parent (parents node) :count 1))  ;; there should only be one.
  (setf (subnodes parent)
        (delete node (subnodes parent) :count 1)))

(defmethod delete-parents ((node dag-node))
  "Delete all the parents of NODE."
  (dolist (p (parents node))  ;; loop on parents so it can be overridden.
    (delete-parent node p)))

;; ##################################################################
;; Subnodes

(defmethod check-node ((group dag-group) (new-node dag-node))
 "Check for circularity between GROUP and NEW-NODE.
If any group under NEW-NODE, including NEW-NODE
is the same as GROUP or any of its parents, then there is a cycle."
 (let ((parents* (cons group (parents* group)))
       (subgroups* (cons new-node (subgroups* new-node))))
   (intersection parents* subgroups*)
   ))

(defmethod add-node ((group dag-group) (new-node dag-node))
  "Prepend NEW-NODE to the subnodes of GROUP.
Assumes NEW-NODE is not already in GROUP.
Also set the parent of NEW-NODE to GROUP.
Returns GROUP."
  (pushnew new-node (subnodes group))
  (add-new-parent new-node group)
  group)

(defmethod add-nodes ((group dag-group) new-nodes)
  "Prepend NEW-NODES to the subnodes of GROUP.
Also set the parents of NEW-NODES to GROUP."
  (dolist (node new-nodes)
    (pushnew node (subnodes group))
    (add-new-parent node group)
    )
  group)

  
(defmethod delete-node ((node dag-node))
  "Delete the NODE from all its parents.
Return the node."
  (delete-parents node)
  node)

(defmethod delete-node :after ((group dag-group))
  "Ungroup the subnodes of GROUP."
  (ungroup group)
  group)

(defmethod ungroup ((group dag-group))
  "Ungroup the GROUP by removing it from the parents of all subnodes 
and niling the groups subnodes.   The subnodes and group continue to exist.
Returns the now empty group."
  (dolist (c (subnodes group))
    (delete-parent c group))
  (setf (subnodes group) nil)
  group)

#|
(defmethod copy ((group dag-group))
  "Return a copy of this group, with a new list of sub-nodes
but the sub-nodes themselves are not copied."
  (let ((new-group (make-instance 'dag-group)))
    (setf (subnodes new-group) (copy-list (subnodes group)))
    new-group))
|#

;;;###############################################################
;;; Traversal

;;; Traversal functions are based on external tally object which keeps track
;;; of the nodes visited.

(defclass tally ()
  ((visited-objects
    :documentation "Set of nodes that have been visited."
    :accessor visited-objects
    :initform (make-hash-table)
    ))
  (:documentation "Accumulate objects, testing whether they have been visited.")
  )

(defun make-tally ()
  (make-instance 'tally))

(defmethod visit ((aTally tally) node)
  "Visit the node."
  (setf (gethash node (visited-objects aTally)) t))

(defmethod visited ((aTally tally) node)
  (gethash node (visited-objects aTally)))

;;;###################
;;; The following functions provide some general dag traversal routines
;;; that may be given a function to apply to the nodes visited.

(defmethod do-nodes (nodes func)
  "Apply FUNC to nodes regardless of visited status.
Note: this does not recurse on subnodes or parents."
  (dolist (node nodes)
    (funcall func node)))


(defmethod visit-node ((visited-nodes tally) 
                       (node dag-node) func)
  "If not already visited, visit the NODE and apply FUNC to it."
;;  (format t "~&visit-node: ~s  func: ~s  visited: ~s" node func (visited node))
  (unless (visited visited-nodes node)
    (visit visited-nodes node)
    (funcall func node)))


(defmethod visit-nodes ((visited-nodes tally) 
                        nodes func)
  "Visit the NODES and apply FUNC to them.
Note: this does not recurse on subnodes or parents."
  (dolist (node nodes)
    (visit-node visited-nodes node func)))

;;; A pre-visit visits the node before recursing.
(defmethod pre-visit-subnodes ((visited-nodes tally) 
                               (node dag-node) func)
  "Visit the node."
  (visit-node visited-nodes node func))

(defmethod pre-visit-subnodes ((visited-nodes tally) 
                               (group dag-group) func)
  "Visit each subnode of GROUP (recursively) after visiting the group itself."
  (unless (visited visited-nodes group)
    (visit-node visited-nodes group func)
    (dolist (c (subnodes group))
      (pre-visit-subnodes visited-nodes c func))
    ))

;;; A post-visit visits the node after recursing.
(defmethod post-visit-subnodes ((visited-nodes tally) 
                                (node dag-node) func)
  "Visit the node."
  (visit-node visited-nodes node func))

(defmethod post-visit-subnodes ((visited-nodes tally) 
                                (group dag-group) func)
  "Visit each subnode of GROUP (recursively) before visiting the group itself."
  (unless (visited visited-nodes group)
    (dolist (c (subnodes group))
      (post-visit-subnodes visited-nodes c func))
    (visit-node visited-nodes group func)))


(defmethod pre-visit-subgroups ((visited-nodes tally) 
                                (node dag-node) func)
  "Nothing to do if it is not a group."
  (declare (ignore func)))
  
(defmethod pre-visit-subgroups ((visited-nodes tally) 
                                (group dag-group) func)
  "Visit each subgroup of GROUP (recursively) after visiting the group itself."
  (unless (visited visited-nodes group)
    (visit-node visited-nodes group func)
    (dolist (c (subnodes group))
      (pre-visit-subgroups visited-nodes c func))))

(defmethod post-visit-subgroups ((visited-nodes tally) 
                                 (node dag-node) func)
  "Nothing to do if it is not a group."
  (declare (ignore func)))
  
(defmethod post-visit-subgroups ((visited-nodes tally) 
                                 (group dag-group) func)
  "Visit each subgroup of GROUP (recursively) before visiting the group itself."
  (unless (visited visited-nodes group)
    (dolist (c (subnodes group))
      (post-visit-subgroups visited-nodes c func))
    (visit-node visited-nodes group func)))


(defmethod visit-leaves ((visited-nodes tally) 
                         (node dag-node) func)
  "Visit the leaf NODE and apply FUNC to the node.
If this node is not a group, then it must be a leaf."
;;  (format t "~&visit-leaf: ~s" node)
  (visit-node visited-nodes node func))

;; New primary visit-leaves for groups.
(defmethod visit-leaves ((visited-nodes tally) 
                         (group dag-group) func)
  "Visit each leaf of GROUP."
;;  (format t "~&visit-leaves of group: ~s  visited: ~s" group (visited group))
  (unless (visited visited-nodes group)
    (dolist (c (subnodes group))
      (visit-leaves visited-nodes c func))))


(defmethod visit-parents ((visited-nodes tally) 
                          (group dag-group) func)
  "Visit GROUP applying FUNC."
;;  (format t "~%visit parent: ~s" group)
  (unless (visited visited-nodes group)
    (visit-node visited-nodes group func)
    (dolist (p (parents group))
      (visit-parents visited-nodes p func))))

(defmethod visit-parents ((visited-nodes tally) 
                          (node dag-node) func)
  "Visit parents of NODE, applying FUNC to each."
  ;; parents are necessarily groups, but the node itself may not be.
;;  (format t "~%visit parents of: ~s" node)
  (unless (visited visited-nodes node)
    (dolist (p (parents node))
      (visit-parents visited-nodes p func))))



;;;###############################################################
;;; High level traversals
;;; Here are some higher-level uses of the general traversal routines.

(defmethod leaf-list ((group dag-group))
  "Return a list of leaf level nodes under this group."
  (let ((leaves))
    (visit-leaves (make-tally) group #'(lambda (c) (push c leaves)))
    leaves))

(defmethod subgroups* ((group dag-group))
  "Return a list of all subgroups (reflexive-transitive closure) below GROUP."
  (let ((subgroups))
    (pre-visit-subgroups (make-tally) group #'(lambda (g) (push g subgroups)))
    subgroups))

(defmethod parents* ((group dag-group))
  "Return a list of all parents (transitive closure) above GROUP."
  (let ((parents))
    (visit-parents (make-tally) group #'(lambda (p) (push p parents)))
    parents))

#|
;;; Examples

(setq foo
      (make-instance 'dag-group :subnodes 
                     (list
                      (make-instance 'dag-node)
                      (make-instance 'dag-group :subnodes
                                     (list
                                      (make-instance 'dag-node)
                                      (make-instance 'dag-node))))))
(leaf-list foo)
(subgroups* foo)

|#
