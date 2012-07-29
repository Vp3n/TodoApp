package models

import anorm._
import anorm.SqlParser._
import play.api.db.DB
import play.api.Play.current
import play.api.libs.json._
import anorm.RowParser
import anorm.NotAssigned

case class Todo(id: Pk[Long], label: String, isDone: Boolean, isArchived: Boolean)

object Todo {

  /*
  * Parser JSON to Todo object
  * used to provide implicit parameter to Json.fromJson[T]()
  */
  implicit object TodoDeserializer extends Reads[Todo] {
    def reads(json: JsValue) = json match {
      case JsObject(jsObj) => 
        val optId = (json \ "id").asOpt[Long]
        val pkId = optId.map { id =>
          Id(id)
        }.getOrElse {
          NotAssigned
        }
        Todo(        
          pkId,
          (json \ "label").as[String],
          (json \ "done").as[Boolean],
          (json \ "archived").as[Boolean]
        )
      case _ => throw new RuntimeException("Todo object expected")
    }
  }

  implicit object TodoSerializer extends Writes[Todo] {
    def writes(todo: Todo) = Json.toJson(
        Json.obj(
          "label"    -> todo.label,
          "done"     -> todo.isDone,
          "archived" -> todo.isArchived,
          "id"       -> todo.id.get
        )
      )
  }

  def apply(label: String) = new Todo(NotAssigned, label, false, false)
  def apply(id: Long, todo: Todo) = new Todo(Id(id), todo.label, todo.isDone, todo.isArchived)

  val mapper = {
    get[Pk[Long]]("id") ~
    get[String]("label") ~
    get[Boolean]("is_done") ~
    get[Boolean]("is_archived") map {
      case id ~ label ~ isDone ~ isArchived => Todo(id, label, isDone, isArchived)
    }
  }

  def create(todo: Todo) = {
    DB.withConnection { implicit connection =>
      val generatedId = SQL("insert into todo(label) values ({label})")
        .on('label -> todo.label)
        .executeInsert()
        .get
      Todo(generatedId, todo)
    }
  }

  def update(todo: Todo): Unit = {
   DB.withConnection { implicit connection =>
      SQL("""
        update todo set
          label = {label},
          is_archived = {isArchived},
          is_done = {isDone}
        where id = {id}
        """)
        .on('label -> todo.label)
        .on('isArchived -> todo.isArchived)
        .on('isDone -> todo.isDone)
        .on('id -> todo.id.get)
        .executeUpdate()
    } 
  }

  def archive(todos: List[Todo]) {
    val ids = todos.map(_.id) 
    val in = "id in (%s)".format(
      ids.map(
        "'%s'".format(_)
      ).mkString(",")
    )
    DB.withConnection { implicit connection => 
      SQL("update todo set is_archived = true where %s".format(in))
        .executeUpdate()  
    }
  }

  def findNotArchived = {
    DB.withConnection { implicit connection =>
      SQL("select * from todo where is_archived = false order by label asc").as(Todo.mapper *)
    }
  }

}