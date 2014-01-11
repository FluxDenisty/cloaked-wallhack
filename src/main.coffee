jQuery ->
  window.canvas = jQuery('#drawable')
  window.ctx = canvas.get(0).getContext('2d')

  # Initialization code
  worldAABB = new b2AABB()
  worldAABB.minVertex.Set(-1000, -1000)
  worldAABB.maxVertex.Set(1000, 1000)
  gravity = new b2Vec2(0, 0)
  doSleep = true
  world = new b2World(worldAABB, gravity, doSleep)

  game = new Game(world, 60)

  run = () ->
    game.update(1000 / game.fps)
    game.draw()
  intervalID = setInterval(run, 1000 / game.fps)
