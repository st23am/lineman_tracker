describe ".helloText", ->
  When -> @result = "Hello, World!"
  Then -> expect(@result).toEqual("Hello, World!")
