package controllers

import play.api._
import play.api.mvc._
import play.api.libs.json._
import models._

object Archive extends Controller {

	def create = Action { implicit request =>
		val body = request.body
		body.asJson.map { json =>
			val todos = json.as[List[Todo]]
			Todo.archive(todos)
			Ok
		}.getOrElse {
			BadRequest("JSON expected")
		}
	}

}