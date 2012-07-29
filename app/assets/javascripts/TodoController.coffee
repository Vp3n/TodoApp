define [
  "angular"
  "TodoService"
], (angular, TodoService) -> 
  "use strict"
  
  controllers = angular.module "controllers", ["services"]

  controllers.controller "TodoController", ["$scope", "$http", "TodoService", ($scope, $http, service) ->

    service.list((todos) -> 
      $scope.todos = todos
    )

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

