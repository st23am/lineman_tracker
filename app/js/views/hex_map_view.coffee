def 'tracker.views.Grid', class Grid
  constructor: (domID, width, height) ->
    @width = width
    @height = height
    @paper = Raphael(domID, 960, 960)

  draw_map: (map, rows, hex_size, columns) ->
    row_num = 0
    while row_num < rows
      hexes = [  ]
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
        hex = new Hex(map, hexes[i].x, hexes[i].y, i, row_num, hex_size)
        drawn_hex = hex.draw()
        drawn_hex.attr fill: "#abcdef"
        drawn_hex.paper.text hexes[i].x - hex_size / 2, hexes[i].y, row_num + "," + i
        drawn_hex.click ->
          @attr fill: "green"
          console.log "Hex location: #{drawn_hex.grid_location} was clicked"
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

  draw: ->
    fact = 1
    size = @hex_size / 2 * fact
    x = size / 2
    y = size * Math.sqrt(3) / 2
    p1_x = @x - @hex_size * fact
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

    return @map.paper.path("M" + p1_x + " " + p1_y + "L" + p2_x + " " + p2_y + "L" + p3_x + " " + p3_y + "L" + p4_x + " " + p4_y + "L" + p5_x + " " + p5_y + "L" + p6_x + " " + p6_y + "L" + p1_x + " " + p1_y + "Z")

