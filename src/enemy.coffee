jQuery ->
  class window.Enemy
    constructor: (@world, pos) ->
      @size = 0.5
      @speed = 13
      @damping = 20

      circleDef = new b2FixtureDef()
      circleDef.shape = new b2CircleShape(@size)
      circleDef.density = 1.0
      circleDef.restitution = 0.0
      circleDef.filter.categoryBits = 0x4
      circleDef.filter.maskBits = 0x1 | 0x2

      sightDef = new b2FixtureDef()
      sightDef.shape = new b2PolygonShape()
      @verts = []
      @verts[0] = new b2Vec2( 0,  0)
      @verts[1] = new b2Vec2( 1,  2)
      @verts[2] = new b2Vec2(-1,  2)
      sightDef.shape.SetAsArray(@verts)
      sightDef.isSensor = true
      sightDef.filter.categoryBits = 0x8
      sightDef.filter.maskBits = 0x2

      bodyDef = new b2BodyDef()
      bodyDef.type = b2Body.b2_dynamicBody
      bodyDef.allowSleep = false
      bodyDef.linearDamping = @damping
      bodyDef.position.Set(pos.x, pos.y)
      @body = world.CreateBody(bodyDef)
      @body.CreateFixture(circleDef)
      @body.CreateFixture(sightDef)

      @colour = 'grey'

    draw: () ->
      ctx.save()
      ctx.fillStyle = @colour
      pos = @body.GetPosition()
      ctx.translate(Math.floor(pos.x * SCALE), Math.floor(pos.y * SCALE))
      ctx.rotate(@body.GetAngle())
      ctx.beginPath()
      ctx.arc(0, 0, SCALE * @size, 0, 2*Math.PI);
      ctx.fill()
      ctx.fillStyle = 'yellow'
      ctx.beginPath()
      ctx.moveTo(@verts[2].x * SCALE, @verts[2].y * SCALE)
      @verts.forEach((vert) ->
        ctx.lineTo(vert.x * SCALE, vert.y * SCALE)
      )
      ctx.fill()
      ctx.restore()
