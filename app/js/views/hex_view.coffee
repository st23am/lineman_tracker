def 'tracker.views.Hex', class Hex
  constructor: (map, x, y, hex_num, row_num, hex_size) ->
    @map = map
    @x = x
    @y = y
    @hex_size = hex_size
    @hex_num = hex_num
    @row_num = row_num
    @grid_location = "#{@row_num}, #{@hex_num}"
    @points = []
    @element = {}
    @compute_points()

  toggleFillColor: ->
    if @element.attrs.fill == "#abcdef"
      @element.attr fill: "green"
      console.log "Hex location: #{@grid_location} was filled"
      console.log(this)
    else
      @element.attr fill: "#abcdef"

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
    p = @points
    path_string = "#{p[0].x} #{p[0].y}L#{p[1].x} #{p[1].y}L#{p[2].x} #{p[2].y}L#{p[3].x} #{p[3].y}L#{p[4].x} #{p[4].y}L#{p[5].x} #{p[5].y}L#{p[0].x} #{p[0].y}"
    "M#{path_string}Z"

  draw: ->
    @element = @map.paper.path(@path_string())
    @setElementAttrs()
    this

  setElementAttrs: ->
    @element.attr fill: "#abcdef"
    @element.paper.text(@x - @hex_size / 2, @y, "#{@grid_location}")
    @element.hex = this
    @element.click ->
      @hex.toggleFillColor()

