define [
	"angular",
	"TodoController"
	"TodoService"
], (angular, TodoController, services) ->
	"use strict"

	app = angular.module "TodoApp", ["controllers"]

	app.config ["$routeProvider", ($routeProvider) ->
		$routeProvider
		.when '/'
		  templateUrl: Router.controllers.Assets.at("templates/list.html").url
		  controller: "TodoController"
		.otherwise 
		  redirectTo: '/'
	]

	app.run () -> 
	app

