class HexView extends Backbone.View
  initialize: (paper, x, y, col_num, row_num, hex_size) ->
    @paper = paper
    @x = x
    @y = y
    @hex_size = hex_size
    @col_num = col_num
    @row_num = row_num
    @grid_location = "#{@row_num}, #{@col_num}"
    @points = []
    @compute_points()
    super

  compute_points: ->
    size = @hex_size / 2
    x = @hex_size / 4
    y = size * Math.sqrt(3) / 2
    @points.push
      x: @x - @hex_size
      y: @y
    @points.push
      x: @points[0].x + x
      y: @points[0].y - y
    @points.push
      x: @points[1].x + (2 * x)
      y: @points[1].y
    @points.push
      x: @points[2].x + x
      y: @points[2].y + y
    @points.push
      x: @points[3].x - x
      y: @points[3].y + y
    @points.push
      x: @points[4].x - (2 * x)
      y: @points[4].y

  path_string: ->
    path_string = ""
    for point in @points
      path_string += "#{point.x} #{point.y}L"
    path_string += "#{@points[0].x} #{@points[0].y}L"
    "M#{path_string}Z"

  render: ->
    @svgElement = @paper.path(@path_string())
    @setElementAttrs()
    this

  setElementAttrs: ->
    @svgElement.attr fill: "#abcdef"
    @paper.text(@x - @hex_size / 2, @y, "#{@grid_location}")
    @svgElement.click =>
      @toggleFillColor()

  toggleFillColor: ->
    if @svgElement.attrs.fill == "#abcdef"
      @svgElement.attr fill: "green"
      console.log "Hex location: #{@grid_location} was filled"
      console.log(this)
    else
      @svgElement.attr fill: "#abcdef"

def 'tracker.views.HexView', HexView
