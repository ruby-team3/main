require 'dxruby'

require_relative 'youerself'
require_relative 'trash'

#画像の表示
player_img = Image.load("image/player.png")
trash_img = Image.load("image/trash.png")
bom_img = Image.load("image/bom_image.png")

# ゲームの状態を記憶するハッシュを追加
GAME_INFO = {
  score: 0      # 現在のスコア
}

#画像の背景色の透明化(指定した色を透明にできる)
player_img.set_color_key(C_WHITE)
trash_img.set_color_key(C_WHITE)
bom_img.set_color_key(C_WHITE)

player = Player.new(150, 150, player_img)


trash = []
25.times do
  trash << Trash.new(rand(0..(640 - 32 - 1)), rand((480 - 32 - 1)), trash_img)
end


#ウィンドウの左上にタイトルを表示する
Window.caption = "お掃除"


Window.loop do
    player.update

    player.draw
    Sprite.draw(trash)
    Sprite.check(player, trash)

     # スコアを画面に表示する
     Window.draw_font(0, 0, "SCORE: #{GAME_INFO[:score]}", Font.default)

    #playerがウィンドウの端まで来たらストップ
    if player.x < 0
        player.x = 0
    elsif player.x > 640 - player_img.width
        player.x = 640 - player_img.width
    elsif player.y < 0
        player.y = 0
    elsif player.y > 480 - player_img.height
        player.y = 480 - player_img.height
    end
end