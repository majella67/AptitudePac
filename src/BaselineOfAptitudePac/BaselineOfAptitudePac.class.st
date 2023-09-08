Class {
	#name : #BaselineOfAptitudePac,
	#superclass : #BaselineOf,
	#category : #BaselineOfAptitudePac
}

{ #category : #baseline }
BaselineOfAptitudePac >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Aptitude-Pac'..
			spec package: 'Aptitude-Pac'
		]
]
