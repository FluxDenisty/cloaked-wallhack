jQuery ->
  class window.Game
    constructor: (@world, @fps) ->

    update: (diff) ->
      timeStep = 1.0 / @fps
      iteration = 1
      @world.Step(timeStep, iteration)

    draw: () ->
      ctx.save()
      ctx.fillStyle = 'white'
      ctx.fillRect(0, 0, canvas.width(), canvas.height())
      ctx.restore()


