class Bom < Sprite
    # playerと衝突したとき呼ばれるメソッドを追加
  def hit
    self.vanish
    GAME_INFO[:score] = 0  # スコアを0点にする
  end
end