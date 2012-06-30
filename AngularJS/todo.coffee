@TodoController = ($scope) ->

  $scope.todos = [
      { text: 'learn angular', done: true }, { text: 'build an angular app', done: false }  
  ]

  $scope.addTodo  = ()  -> 
    $scope.todos.push({
      text: $scope.todoText, done: false 
    })
    $scope.todoText = ''

  $scope.remaining = ()  -> 
    $scope.todoFilter($scope.todos, false).length


  $scope.todoFilter = (todos, status) -> 
    for todo in todos
      do (todo) -> 
        if todo.done is status
          todo    

  $scope.archive = ()  ->
    inPogressTodos = $scope.todos
    $scope.todos = []
    for todo in inPogressTodos
      do(todo) -> 
        if(todo.done is false)
          $scope.todos.push(todo)
