jQuery ->
  r_canvas = jQuery('#drawable')
  r_ctx = r_canvas.get(0).getContext('2d')

  window.canvas = document.createElement('canvas')
  canvas.width = r_canvas.width()
  canvas.height = r_canvas.height()
  window.ctx = canvas.getContext('2d')
  window.canvas = jQuery(canvas)
  canvas.width(r_canvas.width())
  canvas.height(r_canvas.height())

  worldAABB = new b2AABB()
  worldAABB.lowerBound.Set(-1000, -1000)
  worldAABB.upperBound.Set(1000, 1000)
  gravity = new b2Vec2(0, 0)
  doSleep = true
  world = new b2World(gravity, doSleep)

  game = new Game(world, 60)

  keyState = {}
  for i in [48..90]
    keyState[i] = false
  jQuery(document.body).on('keydown', (e) ->
    keyState[e.which] = true
  )
  jQuery(document.body).on('keyup', (e) ->
    keyState[e.which] = false
  )


  fps_canvas = jQuery('#fps')
  fps_ctx = fps_canvas.get(0).getContext('2d')
  fpsOffset = 0

  lastUpdate = (new Date()).getTime()
  run = () ->
    now = (new Date().getTime())
    diff = now - lastUpdate
    lastUpdate = now
    game.update(diff, keyState)
    game.draw()
    r_ctx.save()
    r_ctx.fillStyle = 'white'
    r_ctx.fillRect(0, 0, r_canvas.width(), r_canvas.height())
    r_ctx.drawImage(canvas.get(0), 0, 0)
    r_ctx.restore()

    actualFPS = 1000 / diff
    percent = (1 - actualFPS/game.fps) * fps_canvas.height()
    fps_ctx.fillStyle = "black"
    fps_ctx.fillRect(fpsOffset, 0, 1, fps_canvas.height())
    fps_ctx.fillStyle = "white"
    fps_ctx.fillRect(fpsOffset, 0, 1, percent)
    fpsOffset = (fpsOffset + 1) % fps_canvas.width()
    fps_ctx.fillStyle = "yellow"
    fps_ctx.fillRect(fpsOffset, 0, 1, fps_canvas.height())

    requestAnimationFrame(run)
  requestAnimationFrame(run)
#  intervalID = setInterval(run, 1000 / game.fps)
