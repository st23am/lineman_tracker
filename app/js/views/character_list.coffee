class CharacterList extends Backbone.View
  el: "#characters"

  template: JST["app/templates/character_list.hb"]

  characters: ->
    @collection.models

  templateContext: =>
    @collection

  render: ->
    @template(characters: @collection.models)

def 'tracker.views.CharacterList', CharacterList

