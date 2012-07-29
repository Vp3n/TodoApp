require 
	shim: 
		"angular": 
			exports: "angular"
		"angular-resource":
			deps: ["angular"]
			exports: "angular-resource"
	[
		"angular"
		"TodoApp",
	], (angular) -> 
	
		"use strict"

		# We need to declare our app before angular scan the dom
		# (see TodoApp.coffee)
		# so we manually bootstrap the app
		angular.element(document).ready -> 
			angular.bootstrap document, ["TodoApp"]
