Class {
	#name : #GAGLReadme,
	#superclass : #Object,
	#category : #'GeneticAlgoritm-GraphLayout'
}

{ #category : #example }
GAGLReadme >> classDependencies [
	<script: 'self new classDependencies inspect'>
	
	"
	b := RTMondrian new.
	b nodes: Collection withAllSubclasses.
	b edges connectToAll: #dependentClasses.
	b layout force.
	b
	"
	| b |
	b := RTMondrian new.
	b nodes: (Collection withAllSubclasses first: 40).
	b edges connectToAll: #dependentClasses.
	b build.
	self halt.
	self runGAOn: b view.
	^ b view
	
]

{ #category : #example }
GAGLReadme >> runGAOn: view [ 
	| g |
	g := GAEngine new.
	g populationSize: 100.
	g numberOfGenes: view numberOfElements.
	g endForMaxNumberOfGeneration: 30.
	g createGeneBlock: [ :rand :index :ind | 
		rand next < 0.2 
			ifTrue: [ 0 @ 0 ]
			ifFalse: [ ((rand nextInt: 50) - 25) @ ((rand nextInt: 50) - 25) ] ].
	g minimizeComparator.
 	g fitnessBlock: [ :genes |
		"We reset"
		view elements do: [ :n | n translateTo: 0 @ 0 ].
		view elements with: genes do: [ :e :t | e translateTo: t ].
		 
		GAGLCrossingCounter new numberOfCrossing: (view edges collect: [ :e | {e from position . e to position} ])
		].
	^ g run


]

{ #category : #example }
GAGLReadme >> simpleExample [

| v es |
v := RTView new.
es := RTLabel new elementsOn: #(1 2 3 4).
v addAll: es.
es @ RTPopup @ RTDraggable.
es second translateTo: 100 @ 100.
es third translateTo: 10 @ 100.
es fourth translateTo: 100 @ 10.

RTEdgeBuilder new
	view: v;
	useAssociations: { 1->2 . 3->4 }. 

GAGLCrossingCounter new numberOfCrossing: (v edges collect: [ :e | {e from position . e to position} ] as: Array).

v
]
