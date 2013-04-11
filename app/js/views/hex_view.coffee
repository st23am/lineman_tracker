def 'tracker.views.Hex', class Hex
  constructor: (map, x, y, hex_num, row_num, hex_size) ->
    @map = map
    @x = x
    @y = y
    @hex_size = hex_size
    @hex_num = hex_num
    @row_num = row_num
    @grid_location = "#{@row_num}, #{@hex_num}"
    @paper_path = {}

  toggleFillColor: ->
    if @paper_path.attrs.fill == "#abcdef"
      @paper_path.attr fill: "green"
      console.log "Hex location: #{@grid_location} was filled"
      console.log(this)
    else
      @paper_path.attr fill: "#abcdef"

  draw: ->
    size = @hex_size / 2
    x = @hex_size / 4
    y = size * Math.sqrt(3) / 2

    p1_x = @x - @hex_size
    p1_y = @y
    p2_x = p1_x + x
    p2_y = p1_y - y
    p3_x = p2_x + (2 * x)
    p3_y = p2_y

    p4_x = p3_x + x
    p4_y = p3_y + y
    p5_x = p4_x - x
    p5_y = p4_y + y
    p6_x = p5_x - (2 * x)
    p6_y = p5_y

    path_string = "#{p1_x} #{p1_y}L#{p2_x} #{p2_y}L#{p3_x} #{p3_y}L#{p4_x} #{p4_y}L#{p5_x} #{p5_y}L#{p6_x} #{p6_y}L#{p1_x} #{p1_y}"
    final_string = "M#{path_string}Z"
    @paper_path = @map.paper.path(final_string)
    @setPaperAttrs()
    this

  setPaperAttrs: ->
    @paper_path.attr fill: "#abcdef"
    @paper_path.paper.text(@x - @hex_size / 2, @y, "#{@grid_location}")
    @paper_path.hex = this
    @paper_path.click ->
      @hex.toggleFillColor()
