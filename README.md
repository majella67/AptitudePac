# AptitudePac
A collection of `BrAptitudes` for Glamorous Toolkit

**BrAPGraphExplorerAptitude** 

	Adding this aptitude to an element
 
 		1. allows you to explore the other elements that the element is connected to,
		2. hides unrelated elements,
		3. increases your focus.

	Use the following to interact with the element

  		1. Alt and hover  shows only the connected elements of the element selected.
 		2. Ctrl and Alt hover adds more connected edges and elements.
 		3. Shift and hover  shows all elements
    
**BrAPCanvasZoomAptitude**


	Adding this aptitude to a `BrZoomableElement` allows you to use the mousewheel to zoom in/out.
 	Use Alt to speedup zooming

**BrAPPageTooltipAptitude**

	Adding this aptitude to an element that responds to `page` and  `page:` shows a preview of the page 

 ![Explorer_Aptitude](https://github.com/majella67/AptitudePac/assets/52683123/67aa4e71-08b1-400c-ae25-59a3c07a7ae5)
 
## Installation

```
Metacello new
	repository: 'github://majella67/AptitudePac:main/../../../../../git/AptitudePac';
	baseline: 'AptitudePac';
	load
```

