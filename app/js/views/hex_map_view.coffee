def 'tracker.views.Grid', class Grid
  constructor: (domID, width, height) ->
    @width = width
    @height = height
    @paper = Raphael(domID, 960, 960)
    @hexes = []

  draw_map: (map, rows, hex_size, columns) ->
    for row in [0..rows]
      hexes = [ ]
      hexes[0] =
        x: hex_size
        y: (row * hex_size * Math.sqrt(3) / 2) + (hex_size * Math.sqrt(3) / 2)
      for column in [1..columns]
        prev_x = hexes[column - 1].x
        prev_y = hexes[column - 1].y

        if column % 2 is 0
          this_y = hexes[0].y
        else
          this_y = hexes[0].y + (hex_size * Math.sqrt(3) / 4)

        this_x = prev_x + (1.5 * (hex_size / 2))
        hexes.push
          x: this_x
          y: this_y
      for hex_num in [0...hexes.length]
        @hexes.push new tracker.views.Hex(this, hexes[hex_num].x, hexes[hex_num].y, hex_num, row, hex_size).draw()

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
