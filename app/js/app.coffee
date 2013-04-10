class App

  constructor: ->
    @characters = new tracker.collections.Characters(tracker.data.Characters())
    @router = new tracker.Router(characters: @characters)

  start: ->
    Backbone.history.start()

def "tracker.App", App

$ ->
  tracker.App = new tracker.App(); tracker.App.start()
  window.grid = new tracker.views.Grid("timeline", 9, 5)
  grid.draw_map window.grid, 15, 60, 20
