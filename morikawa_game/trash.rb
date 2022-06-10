class Trash < Sprite
    def hit
      self.vanish
      GAME_INFO[:score] += 10
    end
  end
  