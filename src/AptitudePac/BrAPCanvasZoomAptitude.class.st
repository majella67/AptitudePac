Class {
	#name : #BrAPCanvasZoomAptitude,
	#superclass : #BrAptitude,
	#category : #AptitudePac
}

{ #category : #accessing }
BrAPCanvasZoomAptitude >> initialize [
	"Assumes widget is a kind of BlCanvassableElement"

	| wheelEventHandler |
	super initialize.
	wheelEventHandler := BlEventHandler
			on: BlMouseWheelEvent
			do: [ :anEvent | 
				| oZoomStep |
				oZoomStep := widget zoomStep.

				anEvent modifiers isAlt ifTrue: [ widget zoomStep: oZoomStep * 2 ].
				anEvent isScrollDown ifTrue: [ widget zoomOut ].
				anEvent isScrollUp ifTrue: [ widget zoomIn ].

				widget zoomStep: oZoomStep.
				anEvent consumed: true ].

	self
		addChange: (BrLookChange new
				up: [ :e | e widget addEventHandler: wheelEventHandler ];
				down: [ :e | e widget removeEventHandler: wheelEventHandler ];
				yourself)
]

{ #category : #accessing }
BrAPCanvasZoomAptitude >> lepiterPageExplorer [
	<gtExample>
	^ LepiterPageExplorerExample lepiterPageExplorer
]
