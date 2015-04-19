module Debug
  def draw(ctx)
    radius = 50
    ctx.draw_rect(top_left: [x - radius/2, y - radius/2], width: width + radius, height: height + radius, color: 'white')    
    ctx.draw_rect(top_left: [x, y], width: width, height: height, color: 'red')
    ctx.draw_rect(top_left: mid, width: 1, height: 1, color: 'red')
  end
end