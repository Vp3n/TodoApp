define [
	"angular",
	"TodoController"
	"TodoService"
], (angular, TodoController, services) ->

	"use strict"

	# declaring our application module
	# carefull do not confound with amd modules which
	# are there to organise our javascript (angular or not)
	app = angular.module "TodoApp", ["controllers"]

	# actually we need a single URL for this simple app
	# Router is provided by play2 backend
	# our controller is declared in TodoController.coffee
	app.config ["$routeProvider", ($routeProvider) ->
		$routeProvider
		.when '/'
		  templateUrl: Router.controllers.Assets.at("templates/list.html").url
		  controller: "TodoController"
		.otherwise 
		  redirectTo: '/'
	]

	# initiate angular app, you can add initilization code here
	app.run () -> 

	# returning created app for others amd modules
	app

