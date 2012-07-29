import sbt._
import Keys._
import PlayProject._
import com.google.javascript.jscomp._

object ApplicationBuild extends Build {

    val appName         = "TodoList"
    val appVersion      = "1.0-SNAPSHOT"

    // coffeescriptOptions := Seq("native", "/opt/local/bin/coffee -p")

	val defaultOptions = new CompilerOptions()
    defaultOptions.closurePass = true
    CompilationLevel.WHITESPACE_ONLY.setOptionsForCompilationLevel(defaultOptions)
    defaultOptions.setProcessCommonJSModules(true)
    val root = new java.io.File(".")
    defaultOptions.setCommonJSModulePathPrefix(root.getCanonicalPath+"/app/assets/javascript/")
    defaultOptions.setPrettyPrint(true)

    val appDependencies = Seq(
      "postgresql" % "postgresql" % "9.1-901-1.jdbc4"
    )

    val main = PlayProject(appName, appVersion, appDependencies, mainLang = SCALA).settings(
      closureCompilerSettings(defaultOptions):_*
    )

}
