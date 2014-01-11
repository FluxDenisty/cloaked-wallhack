jQuery ->
  window.SCALE = 50

  class window.Game
    constructor: (@world, @fps) ->
      @player = new Player(@world)

    update: (diff, keyState) ->
      timeStep = 1.0 / @fps
      iteration = 1

      movement = new b2Vec2(0, 0)
      if (keyState[87] == true)
        movement.y -= 1
      if (keyState[83] == true)
        movement.y += 1
      if (keyState[65] == true)
        movement.x -= 1
      if (keyState[68] == true)
        movement.x += 1
      movement.Normalize()

      @player.update(diff, movement)
      @world.Step(timeStep, iteration)

    draw: () ->
      ctx.save()
      ctx.fillStyle = 'white'
      ctx.fillRect(0, 0, canvas.width(), canvas.height())

      ctx.translate(canvas.width() / 2, canvas.height() / 2)
      @player.draw()
      ctx.restore()


