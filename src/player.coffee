jQuery ->
  class window.Player
    constructor: (@world) ->
      @size = 1
      @speed = 400
      @damping = 0.3

      circleDef = new b2CircleDef()
      circleDef.density = 1.0
      circleDef.radius = @size
      circleDef.restitution = 1.0
      bodyDef = new b2BodyDef()
      bodyDef.allowSleep = false
      bodyDef.linearDamping = @damping
      bodyDef.AddShape(circleDef)
      bodyDef.position.Set(0, 0)
      @body = world.CreateBody(bodyDef)

      window.player = @

    update: (diff, movement) ->
      if movement.Length() > 0
        force = movement.Copy()
        force.Multiply(@speed)
        @body.ApplyForce(force, @body.GetOriginPosition())

    draw: () ->
      ctx.save()
      ctx.fillStyle = 'red'
      ctx.beginPath();
      pos = @body.GetOriginPosition()
      ctx.translate(pos.x * SCALE, pos.y * SCALE)
      ctx.arc(0, 0, SCALE, 0, 2*Math.PI);
      ctx.fill()
      ctx.restore()
