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

		angular.element(document).ready -> 
			angular.bootstrap document, ["TodoApp"]
