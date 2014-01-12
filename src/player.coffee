jQuery ->
  class window.Player
    constructor: (@world) ->
      @size = 0.5
      @speed = 15
      @damping = 20

      circleDef = new b2FixtureDef()
      circleDef.shape = new b2CircleShape(@size)
      circleDef.density = 1.0
      circleDef.restitution = 0.0
      circleDef.friction = 0.1
      bodyDef = new b2BodyDef()
      bodyDef.type = b2Body.b2_dynamicBody
      bodyDef.allowSleep = false
      bodyDef.linearDamping = @damping
      bodyDef.angularDamping = 1.0
      bodyDef.position.Set(0, 0)
      @body = world.CreateBody(bodyDef)
      @body.CreateFixture(circleDef)

      window.player = @

    update: (diff, movement) ->
      if movement.Length() > 0
        force = movement.Copy()
        force.Multiply(@speed * diff)
        @body.ApplyForce(force, @body.GetPosition())

    draw: () ->
      ctx.save()
      ctx.fillStyle = 'green'
      ctx.beginPath()
      ctx.arc(0, 0, SCALE * @size, 0, 2*Math.PI)
      ctx.fill()
      ctx.restore()
