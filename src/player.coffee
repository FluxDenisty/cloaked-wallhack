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
      circleDef.filter.categoryBits = 0x2
      circleDef.filter.maskBits = 0x1 | 0x4 | 0x8
      bodyDef = new b2BodyDef()
      bodyDef.type = b2Body.b2_dynamicBody
      bodyDef.allowSleep = false
      bodyDef.linearDamping = @damping
      bodyDef.angularDamping = 20.0
      bodyDef.position.Set(0, 0)
      @body = world.CreateBody(bodyDef)
      @body.CreateFixture(circleDef)
      @body.SetUserData(@)

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
