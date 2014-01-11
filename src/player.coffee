jQuery ->
  class window.Player
    constructor: (@world) ->
      @size = 1

      circleDef = new b2CircleDef()
      circleDef.density = 1.0
      circleDef.radius = @size
      circleDef.restitution = 1.0
      circleDef.friction = 0.0
      bodyDef = new b2BodyDef()
      bodyDef.AddShape(circleDef)
      bodyDef.position.Set(0, 0)
      @body = world.CreateBody(bodyDef)

      window.player = @

    update: (diff) ->

    draw: () ->
      ctx.save()
      ctx.fillStyle = 'red'
      ctx.beginPath();
      ctx.arc(0, 0, SCALE, 0, 2*Math.PI);
      ctx.fill();
      ctx.restore()
