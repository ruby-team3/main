require 'dxruby'

require_relative 'player'
require_relative 'enemy'

player_img = Image.load("image/player.png")
enemy_img = Image.load("image/enemy.png")

player = Player.new(100, 100, player_img)
enemies = []
10.times do
  enemies << Enemy.new(rand(0..(640 - 32 - 1)), rand((480 - 32 - 1)), enemy_img)
end

Window.loop do
  player.update

  player.draw
  Sprite.draw(enemies)

  Sprite.check(player, enemies)
end
