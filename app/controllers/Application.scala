package controllers

import play.api._
import play.api.mvc._
import play.api.libs.json._
import models._

object Application extends Controller {
  
  def index = Action {    
    Ok(views.html.index())
  }

  /*
  * Provide Router object to client side API
  */
  def javascriptRoutes = Action { implicit request =>
    Ok(
      Routes.javascriptRouter("Router") (
       routes.javascript.Application.todos,
       routes.javascript.Application.create,
       routes.javascript.Application.update,
       routes.javascript.Archive.create,
       routes.javascript.Assets.at
      )
    ).as("text/javascript") 
  }

  def todos = Action {
    val todoList = Todo.findNotArchived
    val jsonTodos = Json.toJson[List[Todo]](todoList)
  	Ok(jsonTodos)
  }

  def create = Action { implicit request => 
    val body = request.body
    val datas = body.asJson
    datas.map { json => 
      val todo = Json.fromJson[Todo](json)
      val createdTodo = Todo.create(todo)
      val createdTodoJson = Json.toJson[Todo](createdTodo)
      Ok(createdTodoJson)
    }.getOrElse {
      BadRequest("JSON expected")
    }
  }

  def update(id: Long) = Action { implicit request =>
    val body = request.body
    val datas = body.asJson
    datas.map { json => 
      val todo = Json.fromJson[Todo](json)
      Todo.update(todo)
      Ok(Json.toJson[Todo](todo))
    }.getOrElse {
      BadRequest("JSON expected")
    }
  }
}