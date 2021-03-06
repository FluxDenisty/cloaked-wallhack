jQuery ->
  window.b2Vec2 = Box2D.Common.Math.b2Vec2
  window.b2Transform = Box2D.Common.Math.b2Transform
  window.b2BodyDef = Box2D.Dynamics.b2BodyDef
  window.b2Body = Box2D.Dynamics.b2Body
  window.b2FixtureDef = Box2D.Dynamics.b2FixtureDef
  window.b2Fixture = Box2D.Dynamics.b2Fixture
  window.b2World = Box2D.Dynamics.b2World
  window.b2MassData = Box2D.Collision.Shapes.b2MassData
  window.b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape
  window.b2CircleShape = Box2D.Collision.Shapes.b2CircleShape
  window.b2AABB = Box2D.Collision.b2AABB

  window.SCALE = 75

  class window.Game
    constructor: (@world, @fps) ->
      @world.SetContactListener(@)

      @walls = [
        new StaticGeo(@world, 5, 1, new b2Vec2(0, 3))
        new StaticGeo(@world, 1, 2, new b2Vec2(4, -1.2))
        new StaticGeo(@world, 1, 2, new b2Vec2(4,  1.2))
      ]

      @enemies = [
        new Enemy(@world, new b2Vec2(3, 0), 0) # Math.PI)
      ]

      @player = new Player(@world)

      window.game = @

    update: (diff, keyState) ->
      movement = new b2Vec2(0, 0)
      if (keyState[87] == true)
        movement.y -= 1
      if (keyState[83] == true)
        movement.y += 1
      if (keyState[65] == true)
        movement.x -= 1
      if (keyState[68] == true)
        movement.x += 1
      movement.Normalize()

      @world.Step(diff / 1000, 1, 1)
      @world.ClearForces()

      @enemies.forEach((enemy) ->
        enemy.update(diff)
      )

      @player.update(diff, movement)

    PreSolve: (contact, manifold) ->

    PostSolve: (contact, manifold) ->

    BeginContact: (contact) ->
      a = contact.GetFixtureA().GetBody().GetUserData()
      b = contact.GetFixtureB().GetBody().GetUserData()

      if (a instanceof Enemy)
        if (contact.GetFixtureA().IsSensor())
          sight = a
        else
          enemy = a
      else if (a instanceof Player)
        player = a

      if (b instanceof Enemy)
        if (contact.GetFixtureA().IsSensor())
          sight = b
        else
          enemy = b
      else if (b instanceof Player)
        player = b

      if (player && sight)
        sight.watching = player

    EndContact: (contact) ->
      a = contact.GetFixtureA().GetBody().GetUserData()
      b = contact.GetFixtureB().GetBody().GetUserData()

      if (a instanceof Enemy)
        if (contact.GetFixtureA().IsSensor())
          sight = a
        else
          enemy = a
      else if (a instanceof Player)
        player = a

      if (b instanceof Enemy)
        if (contact.GetFixtureA().IsSensor())
          sight = b
        else
          enemy = b
      else if (b instanceof Player)
        player = b

      if (player && sight)
        sight.watching = null


    draw: () ->
      ctx.save()
      ctx.fillStyle = 'white'
      ctx.fillRect(0, 0, canvas.width(), canvas.height())
      ctx.translate(canvas.width() / 2, canvas.height() / 2)

      ctx.save()
      pos = @player.body.GetPosition()
      ctx.translate(-Math.floor(pos.x * SCALE), -Math.floor(pos.y * SCALE))

      @enemies.forEach((enemy) ->
        enemy.draw()
      )

      @walls.forEach((wall) ->
        wall.draw()
      )

      ctx.restore()

      @player.draw()
      ctx.restore()


