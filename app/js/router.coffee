def 'tracker.Router', class Router extends Backbone.Router

  routes:
    "*path" : "characterList"

  constructor: (options) ->
    @characters = options.characters
    @container = $("#characters")
    super

  characterList: =>
    @renderPage(tracker.views.CharacterList, collection: @characters)

  renderPage: (viewClass, options) =>
    @container.empty()
    view = new viewClass(options, el: @container.get(0))
    @container.append(view.render())


