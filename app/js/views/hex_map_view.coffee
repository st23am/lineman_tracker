def 'tracker.views.Grid', class Grid
  constructor: (domID, width, height) ->
    @width = width
    @height = height
    @paper = Raphael(domID, 960, 960)
    @hexes = []

  draw_map: (map, rows, hex_size, columns) ->
    #TODO: get rid of these nested whiles w/ list comprehensions and smaller methods
    row_num = 0
    while row_num < rows
      hexes = [ ]
      hexes[0] =
        x: hex_size
        y: (row_num * hex_size * Math.sqrt(3) / 2) + (hex_size * Math.sqrt(3) / 2)
      i = 1
      while i < columns
        prev_x = hexes[i - 1].x
        prev_y = hexes[i - 1].y

        if i % 2 is 0
          this_y = hexes[0].y
        else
          this_y = hexes[0].y + (hex_size * Math.sqrt(3) / 4)
        this_x = prev_x + (1.5 * (hex_size / 2))
        hexes.push
          x: this_x
          y: this_y
        i++
      i = 0
      while i < hexes.length
        hex = new Hex(this, hexes[i].x, hexes[i].y, i, row_num, hex_size)
        @hexes.push hex.draw()
        i++
      row_num++

class Hex
  constructor: (map, x, y, hex_num, row_num, hex_size) ->
    @map = map
    @x = x
    @y = y
    @hex_size = hex_size
    @hex_num = hex_num
    @row_num = row_num
    @grid_location = "#{@row_num}, #{@hex_num}"
    @paper_path = {}

  toggleHexColor: ->
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
    @paper_path.attr fill: "#abcdef"
    @paper_path.paper.text @x - @hex_size / 2, @y, @row_num + "," + @hex_num
    @paper_path.hex = this
    @paper_path.click ->
      @hex.toggleHexColor()
    this
