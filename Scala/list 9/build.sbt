name := "list 9"

version := "0.1"

scalaVersion := "2.13.1"

lazy val core = project in file("core")
lazy val blackjack = project.dependsOn(core)

addCompilerPlugin(scalafixSemanticdb) // enable SemanticDB

scalacOptions ++= Seq(
  "-encoding",
  "utf8", // Specify character encoding used by source files.
  "-Xfatal-warnings", // Fail the compilation if there are any warnings.
  "-deprecation", // Emit warning and location for usages of deprecated APIs.
  "-unchecked", // Enable additional warnings where generated code depends on assumptions.
  "-language:implicitConversions", // Allow definition of implicit functions called views
  "-language:higherKinds", // Allow higher-kinded types
  "-language:existentials", // Existential types (besides wildcard types) can be written and inferred
  "-language:postfixOps", // Allow postfix operator notation, such as 1 to 10 toList.
  "-Yrangepos", // required by SemanticDB compiler plugin
  "-Ywarn-unused" // required by `RemoveUnused` rule
)

libraryDependencies ++= Seq(
  "org.scalatest" %% "scalatest" % "3.1.0" % "test"
)

scalafmtOnCompile := true

coverageEnabled := true
