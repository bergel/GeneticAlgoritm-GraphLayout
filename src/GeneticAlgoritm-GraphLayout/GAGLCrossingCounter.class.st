"
Algo from https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
"
Class {
	#name : #GAGLCrossingCounter,
	#superclass : #Object,
	#category : #'GeneticAlgoritm-GraphLayout'
}

{ #category : #'as yet unclassified' }
GAGLCrossingCounter >> doIntersectP1: p1 q1: q1 p2: p2 q2: q2 [
"
// The main function that returns true if line segment 'p1q1' 
// and 'p2q2' intersect. 
static boolean doIntersect(Point p1, Point q1, Point p2, Point q2) 
{ 
    // Find the four orientations needed for general and 
    // special cases 
    int o1 = orientation(p1, q1, p2); 
    int o2 = orientation(p1, q1, q2); 
    int o3 = orientation(p2, q2, p1); 
    int o4 = orientation(p2, q2, q1); 
 
    // General case 
    if (o1 != o2 && o3 != o4) 
        return true; 
  
    // Special Cases 
    // p1, q1 and p2 are colinear and p2 lies on segment p1q1 
    if (o1 == 0 && onSegment(p1, p2, q1)) return true; 
  
    // p1, q1 and q2 are colinear and q2 lies on segment p1q1 
    if (o2 == 0 && onSegment(p1, q2, q1)) return true; 
  
    // p2, q2 and p1 are colinear and p1 lies on segment p2q2 
    if (o3 == 0 && onSegment(p2, p1, q2)) return true; 
  
    // p2, q2 and q1 are colinear and q1 lies on segment p2q2 
    if (o4 == 0 && onSegment(p2, q1, q2)) return true; 
  
    return false; // Doesn't fall in any of the above cases 
} 
"
	| o1 o2 o3 o4 |
	o1 := self orientationP1: p1 p2: q1 p3: p2.
	o2 := self orientationP1: p1 p2: q1 p3: q2.
	o3 := self orientationP1: p2 p2: q2 p3: p1.
	o4 := self orientationP1: p2 p2: q2 p3: q1.
	
	"General case"
	(o1 ~= o2 and: [ o3 ~= o4 ]) ifTrue: [ ^ true ].

	"Special cases"
	"p1, q1 and p2 are colinear and p2 lies on segment p1q1"
	(o1 = 0 and: [self onSegmentp1: p1 p2: p2 p3: q1]) ifTrue: [ ^ true ].
		
	"p1, q1 and q2 are colinear and q2 lies on segment p1q1"
	(o2 = 0 and: [self onSegmentp1: p1 p2: q2 p3: q1]) ifTrue: [ ^ true ].
	
	"p2, q2 and p1 are colinear and p1 lies on segment p2q2"
	(o3 = 0 and: [self onSegmentp1: p2 p2: p1 p3: q2]) ifTrue: [ ^ true ].
	
	"p2, q2 and q1 are colinear and q1 lies on segment p2q2 "
	(o4 = 0 and: [self onSegmentp1: p2 p2: q1 p3: q2]) ifTrue: [ ^ true ].
	^ false
]

{ #category : #'as yet unclassified' }
GAGLCrossingCounter >> is: e1 crossingWith: e2 [
	"return true if the two edges are crossing"
	^ self doIntersectP1: e1 first q1: e1 second p2: e2 first q2: e2 second
]

{ #category : #'as yet unclassified' }
GAGLCrossingCounter >> numberOfCrossing: someEdges [
	"The argument could be something like: {{(20@13). (100@100)}. {(9@94). (100@10)}}"
	| count alreadyDone |
	count := 0.
	alreadyDone := Set new.
	someEdges do: [ :e1 |
		someEdges copy do: [ :e2 | 
			e1 ~= e2 ifTrue: [
				((alreadyDone includes: e1 -> e2) and: [ alreadyDone includes: e2 -> e1 ])
					ifFalse: [ 
						alreadyDone add: e1 -> e2.
						alreadyDone add: e2 -> e1.
						(self is: e1 crossingWith: e2) ifTrue: [ count := count + 1 ] ] ] ] ].
	^ count
]

{ #category : #'as yet unclassified' }
GAGLCrossingCounter >> onSegmentp1: p p2: q p3: r [
"static boolean onSegment(Point p, Point q, Point r) 
{ 
    if (q.x <= Math.max(p.x, r.x) && q.x >= Math.min(p.x, r.x) && 
        q.y <= Math.max(p.y, r.y) && q.y >= Math.min(p.y, r.y)) 
    return true; 
  
    return false; 
} "

	^ ((q x < (p x max: r x)) and: [ q x >= (p x min: r x) ]) 
		and: [ (q y <= (p y max: r y)) and: [ q y >= (p y min: r y) ] ]
]

{ #category : #'as yet unclassified' }
GAGLCrossingCounter >> orientationP1: p p2: q p3: r [
"// To find orientation of ordered triplet (p, q, r). 
// The function returns following values 
// 0 --> p, q and r are colinear 
// 1 --> Clockwise 
// 2 --> Counterclockwise 
static int orientation(Point p, Point q, Point r) 
{ 
    // See https://www.geeksforgeeks.org/orientation-3-ordered-points/ 
    // for details of below formula. 
    int val = (q.y - p.y) * (r.x - q.x) - 
            (q.x - p.x) * (r.y - q.y); 
  
    if (val == 0) return 0; // colinear 
  
    return (val > 0)? 1: 2; // clock or counterclock wise 
} "
	| val |
	val := ((q y - p y) * (r x - q x)) - ((q x - p x) * (r y - q y)).
	val = 0 ifTrue: [ ^ 0 ].
	^ val > 0 ifTrue: [ 1 ] ifFalse: [ 2 ]
]
