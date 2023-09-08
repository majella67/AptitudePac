Trait {
	#name : #LepiterPageExplorerExample,
	#category : #AptitudePac
}

{ #category : #accessing }
LepiterPageExplorerExample classSide >> lepiterPageExplorer [
	<gtExample>
	| currDB pages m |
	currDB := LeDatabasesRegistry getDatabaseByName: 'Glamorous Toolkit Book'.
	pages := currDB pages reject: [ :each | each title = 'Glamorous Toolkit Book' ].
	m := GtMondrian new.
	m nodes
		stencil: [ :each | 
			BlElement new
				background: ((each title includesSubstring: 'Lepiter')
						ifTrue: [ Color red ]
						ifFalse: [ Color black ]);
				size: 5 @ 5;
				addAptitude: (BrGraphExplorerAptitude highlightColor: (Color orange alpha: 0.5))
						+ (BrPageTooltipAptitude new page: each);
				when: BlClickEvent
					do: [ :e | e currentTarget phlow spawnTool: each asPhlowTool ] ];
		with: pages.
	m edges
		shape: [ BlLineElement new
				border: (BlBorder paint: (Color random alpha: 0.5) width: 1);
				constraintsDo: [ :c | c ignoreByLayout ];
				zIndex: -1 ];
		connectToAll: [ :aPage | aPage allOutgoingTextualLinks collectAsSet: #target ].
	m layout force nbIterations: 30.
	^ m asElement
		childrenScaleFactor: 2;
		addAptitude: BrCanvasZoomAptitude new
]
