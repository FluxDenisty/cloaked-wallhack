jQuery ->
  window.SCALE = 50

  class window.Game
    constructor: (@world, @fps) ->
      @player = new Player(@world)

    update: (diff) ->
      timeStep = 1.0 / @fps
      iteration = 1

      @player.update(diff)
      @world.Step(timeStep, iteration)

    draw: () ->
      ctx.save()
      ctx.fillStyle = 'white'
      ctx.fillRect(0, 0, canvas.width(), canvas.height())

      ctx.translate(canvas.width() / 2, canvas.height() / 2)
      @player.draw()
      ctx.restore()


