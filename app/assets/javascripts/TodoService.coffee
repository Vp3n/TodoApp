define ["angular", "angular-resource"], (angular, resource) ->

	"use strict"

	services = angular.module "services", []

	class TodoService

	  constructor: (@$http) -> 

	  list: (callback) -> 
	  	@$http.get(
      		Router.controllers.Application.todos().url
    	).success (todos) ->
    		callback(todos)

	  add: (todo, callback) -> 
	  	url = Router.controllers.Application.create().url
	  	@$http.post(url, todo).success (createdTodo) -> 
	  		callback(createdTodo)

	  archive: (todos) -> 
	  	url = Router.controllers.Archive.create().url
	  	@$http.post(url, todos).success -> 

	  done: (todo) ->
	    url = Router.controllers.Application.update(todo.id).url
	    @$http.put(url, todo).success -> 	  
	

	services.factory "TodoService", ["$http", ($http) ->
		new TodoService($http)
	]

	services

