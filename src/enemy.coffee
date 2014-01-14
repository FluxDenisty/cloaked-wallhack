jQuery ->
  class window.Enemy
    constructor: (@world, pos, angle) ->
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
      @verts[1] = new b2Vec2( 5,  4)
      @verts[2] = new b2Vec2( 5, -4)
      sightDef.shape.SetAsArray(@verts)
      sightDef.isSensor = true
      sightDef.filter.categoryBits = 0x8
      sightDef.filter.maskBits = 0x1 | 0x2

      bodyDef = new b2BodyDef()
      bodyDef.type = b2Body.b2_dynamicBody
      bodyDef.allowSleep = false
      bodyDef.linearDamping = @damping
      bodyDef.angularDamping = 0.0
      bodyDef.position.Set(pos.x, pos.y)
      bodyDef.angle = angle
      @body = world.CreateBody(bodyDef)
      @body.CreateFixture(circleDef)
      @sightLine = @body.CreateFixture(sightDef)
      @body.SetUserData(@)

      @blarg = new b2Vec2()
      @honk = new b2Vec2()
      # DEBUG
#      @body.SetAngularVelocity(1)

      @colour = 'grey'
      @watching = null

    update: (diff) ->
      if (@watching?)
        epos = @body.GetPosition()
        ppos = @watching.body.GetPosition()
        # vector from player to enemy
        line = epos.Copy()
        line.Subtract(ppos)
        angle = Math.atan(line.y / line.x)
        if (!angle?)
          angle = 0
        up = new b2Vec2()
        up.x = 1
        up.y = Math.tan(angle + Math.PI / 2)
        up.Normalize()
        up.Multiply(@watching.size)
        top = ppos.Copy()
        top.Add(up)
        bottom = ppos.Copy()
        bottom.Subtract(up)
        @blarg = top.Copy()
        @honk = bottom.Copy()

        blocked = false
        getAngle = @body.GetAngle()
        sightAngle = @sightAngle
        game.walls.forEach((wall) ->
          hits = 0
          [ppos, top, bottom].forEach((vec) ->
            line = epos.Copy()
            line.Subtract(vec)
            angle = Math.atan(line.y / line.x)
            angleFromView = (angle - getAngle) % (Math.PI * 2)
            if (true) # angleFromView <= sightAngle)
              fixture = wall.body.GetBody().GetFixtureList()
              input = new Box2D.Collision.b2RayCastInput(epos, vec)
              output = new Box2D.Collision.b2RayCastOutput()
              res = fixture.RayCast(output, input)
              if (res)
                hits += 1
            else
              hits += 1
          )
          if (hits == 3)
            blocked = true
        )
        if (!blocked)
          @colour = 'red'
        else
          @colour = 'orange'


      else
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
      ctx.save()
      if (@watching?)
        ctx.strokeStyle = 'black'
        ctx.beginPath()

        pos = @watching.body.GetPosition()
        ctx.moveTo(pos.x * SCALE, pos.y * SCALE)
        pos = @body.GetPosition()
        ctx.lineTo(pos.x * SCALE, pos.y * SCALE)

        pos = @blarg
        ctx.moveTo(pos.x * SCALE, pos.y * SCALE)
        pos = @body.GetPosition()
        ctx.lineTo(pos.x * SCALE, pos.y * SCALE)

        pos = @honk
        ctx.moveTo(pos.x * SCALE, pos.y * SCALE)
        pos = @body.GetPosition()
        ctx.lineTo(pos.x * SCALE, pos.y * SCALE)

        ctx.stroke()
      ctx.restore()
