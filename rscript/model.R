setClass("pair", slots=list(symbol="character", contact="data.frame"))

# Usage
# obj <- new("pair", symbol="Steven", contact=data.frame())
# obj

setClass("student", slots=list(name="character", age="numeric", GPA="numeric"))

setMethod("pin",
          "student",
          function(object) {
            cat(object@name, "\n")
            cat(object@age, "years old\n")
            cat("GPA:", object@GPA, "\n")
          }
)

s <- new("student",name="John", age=21, GPA=3.5)
show(s)
s
