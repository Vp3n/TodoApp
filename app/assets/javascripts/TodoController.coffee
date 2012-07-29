define [
  "angular"
  "TodoService"
], (angular, TodoService) -> 

  "use strict"
  
  # declaring angular module controllers
  # you can see it as a "package" controllers
  # if we had several controllers, each one could be 
  # attached to this module, then juste one dependency
  # give us ability to work on any controllers
  # this module depends only on service module
  controllers = angular.module "controllers", ["services"]

  # this way of declaring controllers is best practice i've found,
  # others either add garbage on global scope, or is not compatible with 
  # minification
  controllers.controller "TodoController", ["$scope", "TodoService", ($scope, service) ->

    #on load we get our list of models
    service.list((todos) -> 
      $scope.todos = todos
    )

    # all method declared on $scope are directly usable within template
    # as values
    # see /public/templates/list.html
    $scope.addTodo  = ()  -> 
      todo = {
        label: $scope.todoText,
        done: false,
        archived: false,
      }
      todo = service.add(todo, (createdTodo) -> 
        $scope.todos.push createdTodo  
      )
      $scope.todoText = ''

    $scope.done = (todo) -> 
      service.done(todo)

    $scope.remaining = ()  -> 
      $scope.todoFilter($scope.todos, false).length

    $scope.todoFilter = (todos, status) -> 
      if todos?
        todo for todo in todos when todo.done is status
      else []

    $scope.archive = ()  ->
      service.archive $scope.todoFilter($scope.todos, true)
      $scope.todos = $scope.todoFilter($scope.todos, false)          
  ]
  controllers

