define ["angular"], (angular) ->

	"use strict"

	# declaring our angular services modules
	services = angular.module "services", []

	# this class provide client/server communication
	# trough our REST API
	# using coffee script class declaration
	# for clarity
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
	

	# construct our service, here i can create new objet 
	# knowing the fact that angular service are singleton
	# thus we always have a single new call
	services.factory "TodoService", ["$http", ($http) ->
		new TodoService($http)
	]

	# returning created service for others amd modules
	services

