Class {
	#name : #GAGLTest,
	#superclass : #TestCase,
	#category : #'GeneticAlgoritm-GraphLayout'
}

{ #category : #'as yet unclassified' }
GAGLTest >> crossingEdges [
	^ {{(20.146520146520146@13.766788766788759). (100@100)}. {(9.328449328449338@94.96336996336993). (100@10)}}
]

{ #category : #tests }
GAGLTest >> testIsCrossing [

	self assert: (GAGLCrossingCounter new numberOfCrossing: self crossingEdges) equals: 1 
]

{ #category : #tests }
GAGLTest >> testIscrossingWith [
	| c |
	c := GAGLCrossingCounter new.
	self assert: (c is: { 0 @ 0 . 10 @ 10 } crossingWith: { 10 @ 0 . 0 @ 10 }).
	self deny: (c is: { 0 @ 0 . 10 @ 0 } crossingWith: { 0 @ 10 . 10 @ 10 }).
]
