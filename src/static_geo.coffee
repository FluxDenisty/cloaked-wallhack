jQuery ->

  class window.StaticGeo
    constructor: (@world, @width, @height, pos, @rotation=0) ->
      boxDef = new b2BoxDef()
      boxDef.extents = new b2Vec2(@width / 2, @height / 2)
      boxDef.density = 0.0
      boxDef.restitution = 1.0
      bodyDef = new b2BodyDef()
      bodyDef.linearDamping = 1.0
      bodyDef.angularDamping = 1.0
      bodyDef.AddShape(boxDef)
      bodyDef.position.Set(pos.x, pos.y)
      window.def = bodyDef
      @body = world.CreateBody(bodyDef)

    draw: () ->
      ctx.save()
      ctx.fillStyle = 'blue'
      pos = @body.GetOriginPosition()
      ctx.translate(Math.floor(pos.x * SCALE), Math.floor(pos.y * SCALE))
      ctx.rotate(@body.GetRotation())
      ctx.translate(-@width / 2 * SCALE, -@height / 2 * SCALE)
      ctx.fillRect(0, 0, @width * SCALE, @height * SCALE)
      ctx.restore()
