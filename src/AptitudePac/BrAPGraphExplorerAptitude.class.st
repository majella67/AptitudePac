Class {
	#name : #BrAPGraphExplorerAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'highlightColor'
	],
	#category : #AptitudePac
}

{ #category : #accessing }
BrAPGraphExplorerAptitude >> altAndCtrlpressed: anEvent [
	^ anEvent modifiers isAlt and: anEvent modifiers isCtrl
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> hideUnrelatedItems: anElement [
	^ anElement parent
		allChildrenBreadthFirstDetect: [ :c | c = anElement ]
		ifFound: [ :f | 
			| keepVisible |
			keepVisible := OrderedCollection new.
			keepVisible
				addAll: {f} , (f graph connectedEdges asArray collect: #element)
						, f graph connectedNodes asArray.
			anElement parent children
				do: [ :itemElement | 
					(keepVisible includes: itemElement)
						ifFalse: [ itemElement visibility: BlVisibility gone ] ] ]
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> highlightColor [
	^ highlightColor
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> highlightColor: aColor [
	highlightColor := aColor
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> highlightEdges: anEvent [
	^ [ anEvent currentTarget graph connectedEdges
		do: [ :inner | 
			inner element userData add: #borderPaint -> inner element border paint.
			inner element
				border: (BlBorder paint: self highlightColor width: inner element border width) ] ]
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> initialize [
	| outEventHandler overEventHandler |
	super initialize.
	self highlightColor: (Color magenta alpha: 0.5).
	outEventHandler := BlEventHandler on: BlMouseLeaveEvent do: self outBlock.

	overEventHandler := BlEventHandler on: BlMouseEnterEvent do: self overBlock.
	self
		addChange: (BrLookChange new
				up: [ :e | 
					e widget
						addEventHandler: overEventHandler;
						addEventHandler: outEventHandler ];
				down: [ :e | 
					e widget
						removeEventHandler: overEventHandler;
						removeEventHandler: outEventHandler ];
				yourself)
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> lepiterPageExplorer [
	<gtExample>
	^ LepiterPageExplorerExample lepiterPageExplorer
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> noShiftNoAltPressed: anEvent [
	^ anEvent modifiers isAlt not and: anEvent modifiers isShift not
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> outBlock [
	^ [ :anEvent | 
	anEvent currentTarget graph connectedEdges
		do: [ :inner | 
			inner element
				border: (BlBorder
						paint: (inner element userData
								at: #borderPaint
								ifAbsentPut: [ Color veryVeryLightGray ])
						width: inner element border width) ] ]
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> overBlock [
	^ [ :anEvent | 
	{(self shiftPressed: anEvent) -> [ self showAll ].
		(self noShiftNoAltPressed: anEvent) -> (self highlightEdges: anEvent).
		(self selfAltpressedNoCtrl: anEvent)
			-> [ anEvent currentTarget graph connectedEdges
					do: [ :inner | self hideUnrelatedItems: widget ] ].
		(self altAndCtrlpressed: anEvent) -> [ self showRelatedItems: anEvent ]}
		detect: [ :each | each key ]
		ifFound: [ :f | f value value ] ]
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> selfAltpressedNoCtrl: anEvent [
	^ anEvent modifiers isAlt and: anEvent modifiers isCtrl not
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> shiftPressed: anEvent [
	^ anEvent modifiers isShift and: anEvent modifiers isAlt not
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> showAll [
	widget parent
		allChildrenBreadthFirstDo: [ :aChild | aChild visibility: BlVisibility visible ]
]

{ #category : #accessing }
BrAPGraphExplorerAptitude >> showRelatedItems: anEvent [
	| edgesToShow itemsToShow allElements |
	edgesToShow := Set new.
	itemsToShow := Set new.
	allElements := widget parent children.

	itemsToShow := {widget} asOrderedCollection.
	itemsToShow
		do: [ :i | 
			| edgeElements |
			edgeElements := i graph connectedEdges asArray collect: #element.
			edgesToShow addAll: edgeElements.
			itemsToShow
				addAll: (edgeElements
						flatCollect: [ :anEdge | 
							{anEdge fromAnchor referenceElement.
								anEdge toAnchor referenceElement} ]).
			edgesToShow
				do: [ :anEdge | anEdge userData add: #borderPaint -> anEdge border paint ].
			itemsToShow asOrderedCollection , edgesToShow asOrderedCollection
				do: [ :itemElement | itemElement visibility: BlVisibility visible ] ]
]
