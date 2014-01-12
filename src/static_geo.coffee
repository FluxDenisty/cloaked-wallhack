jQuery ->

  class window.StaticGeo
    constructor: (@world, @width, @height, pos, @rotation=0) ->
      boxDef = new b2FixtureDef()
      boxDef.shape = new b2PolygonShape
      boxDef.shape.SetAsBox(@width / 2, @height / 2)
      boxDef.density = 1.0
      boxDef.restitution = 0.0
      boxDef.filter.categoryBits = 0x1
      boxDef.filter.maskBits = ~0x0
      bodyDef = new b2BodyDef()
      bodyDef.type = b2Body.b2_staticBody
      bodyDef.linearDamping = 1.0
      bodyDef.angularDamping = 1.0
      bodyDef.position.Set(pos.x, pos.y)
      window.def = bodyDef
      @body = world.CreateBody(bodyDef).CreateFixture(boxDef)

    draw: () ->
      ctx.save()
      ctx.fillStyle = 'blue'
      pos = @body.GetBody().GetPosition()
      ctx.translate(Math.floor(pos.x * SCALE), Math.floor(pos.y * SCALE))
      ctx.rotate(@body.GetBody().GetAngle())
      ctx.translate(-@width / 2 * SCALE, -@height / 2 * SCALE)
      ctx.fillRect(0, 0, @width * SCALE, @height * SCALE)
      ctx.restore()
