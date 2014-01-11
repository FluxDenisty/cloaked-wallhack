jQuery ->
  window.SCALE = 50

  class window.Game
    constructor: (@world, @fps) ->
      @walls = []
      @walls.push(new StaticGeo(@world, 5, 1, new b2Vec2(0, 4)))
      @walls.push(new StaticGeo(@world, 1, 5, new b2Vec2(9, 0)))

      @player = new Player(@world)

      window.game = @

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

      @walls.forEach((wall) ->
        wall.draw()
      )
      @player.draw()
      ctx.restore()


