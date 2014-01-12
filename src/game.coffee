jQuery ->
  window.b2Vec2 = Box2D.Common.Math.b2Vec2
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

      @walls = []
      @walls.push(new StaticGeo(@world, 5, 1, new b2Vec2(0, 3)))
      @walls.push(new StaticGeo(@world, 1, 5, new b2Vec2(5, 0)))

      @enemies = []
      @enemies.push(new Enemy(@world, new b2Vec2(7, 0)))

      @player = new Player(@world)

      window.game = @

    update: (diff, keyState) ->
      @world.ClearForces()
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

      @player.update(diff, movement)
      @world.Step(diff / 1000, 1, 1)

    PreSolve: (a, b, c, d, e) ->
      console.log 'GOT IT'

    BeginContact: (a, b, c, d, e) ->
      console.log 'GOT IT'

    PostSolve: (a, b, c, d, e) ->
      console.log 'GOT IT'

    EndContact: (a, b, c, d, e) ->
      console.log 'GOT IT'


    draw: () ->
      ctx.save()
      ctx.fillStyle = 'white'
      ctx.fillRect(0, 0, canvas.width(), canvas.height())
      ctx.translate(canvas.width() / 2, canvas.height() / 2)

      ctx.save()
      pos = @player.body.GetPosition()
      ctx.translate(-Math.floor(pos.x * SCALE), -Math.floor(pos.y * SCALE))

      @walls.forEach((wall) ->
        wall.draw()
      )

      @enemies.forEach((enemy) ->
        enemy.draw()
      )
      ctx.restore()

      @player.draw()
      ctx.restore()


