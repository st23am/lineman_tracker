def 'tracker.views.Grid', class Grid
  constructor: (domID, width, height) ->
    @width = width
    @height = height
    @paper = Raphael(domID, 960, 960)
    @hexes = []

  draw_map: (map, rows, columns, hex_size) ->
    for row in [0..rows]
      hexes = [ ]
      hexes[0] =
        x: hex_size
        y: (row * hex_size * Math.sqrt(3) / 2) + (hex_size * Math.sqrt(3) / 2)
      for column in [1..columns]
        previous_x = hexes[column - 1].x

        if column % 2 is 0
          this_y = hexes[0].y
        else
          this_y = hexes[0].y + (hex_size * Math.sqrt(3) / 4)

        this_x = previous_x + (1.5 * (hex_size / 2))
        hexes.push
          x: this_x
          y: this_y
      for hex_num in [0...hexes.length]
        @hexes.push new tracker.views.Hex(this, hexes[hex_num].x, hexes[hex_num].y, hex_num, row, hex_size).draw()


