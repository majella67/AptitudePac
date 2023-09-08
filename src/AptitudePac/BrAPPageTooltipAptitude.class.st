Class {
	#name : #BrAPPageTooltipAptitude,
	#superclass : #BrGlamorousWithTooltipAptitude,
	#instVars : [
		'page'
	],
	#category : #AptitudePac
}

{ #category : #accessing }
BrAPPageTooltipAptitude >> lepiterPageExplorer [
	<gtExample>
	^ LepiterPageExplorerExample lepiterPageExplorer
]

{ #category : #accessing }
BrAPPageTooltipAptitude >> page [
	^ page
]

{ #category : #accessing }
BrAPPageTooltipAptitude >> page: aLePage [
	page := aLePage.

	self
		contentStencil: [ LePageToolContentTreeElement new
				pageViewModel: aLePage asContentUIModel;
				matchParent;
				hExact: 450;
				vFitContentLimited;
				margin: (BlInsets all: 9);
				removeFromParent ]
]
