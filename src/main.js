
  $(function() {
    var doSleep, draw, fps, gravity, intervalID, run, update, world, worldAABB;
    window.canvas = $('#drawable');
    window.ctx = canvas.get(0).getContext('2d');
    update = function() {};
    draw = function() {
      ctx.save();
      ctx.fillStyle = 'white';
      ctx.fillRect(0, 0, canvas.width(), canvas.height());
      return ctx.restore();
    };
    worldAABB = new b2AABB();
    worldAABB.minVertex.Set(-1000, -1000);
    worldAABB.maxVertex.Set(1000, 1000);
    gravity = new b2Vec2(0, 0);
    doSleep = true;
    world = new b2World(worldAABB, gravity, doSleep);
    fps = 60;
    run = function() {
      update(1000 / fps);
      return draw();
    };
    return intervalID = setInterval(run, 1000 / fps);
  });
