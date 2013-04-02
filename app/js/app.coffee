def "tracker.App", class App

  constructor: ->
    @characters = new tracker.collections.Characters(tracker.data.Characters())
    @router = new tracker.Router(characters: @characters)

  start: ->
    Backbone.history.start()

$ -> tracker.App = new tracker.App(); tracker.App.start()

