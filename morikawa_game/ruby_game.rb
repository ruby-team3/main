require 'dxruby'

require_relative 'player'
require_relative 'item'

#画像の表示
player_img = Image.load("image/player.png")
item_img = Image.load("image/item.png")
bom_img = Image.load("image/bom_image.png")

img_hwall = Image.new( 2, 480, C_BLACK) #縦の壁
img_vwall = Image.new(640,  2, C_BLACK) #横の壁


# ゲームの状態を記憶するハッシュを追加
GAME_INFO = {
  score: 0      # 現在のスコア
}

#画像の背景色の透明化(指定した色を透明化)
player_img.set_color_key(C_WHITE)
item_img.set_color_key(C_WHITE)
bom_img.set_color_key(C_WHITE)

player = Player.new(150, 150, player_img)
lwall = Sprite.new(  0,   0, img_hwall) #左の壁
rwall = Sprite.new(638,   0, img_hwall) #右の壁
twall = Sprite.new(  0,   0, img_vwall) #上の壁
dwall = Sprite.new(  0,  478, img_vwall) #下の壁

walls = [lwall, rwall, twall, dwall]

bom = Sprite.new(200, 300, bom_img)

dx =  4 #bomのx方向の速さ
dy = -4 #bomのy方向の速さ

#bomを動かすための関数
def move(sprite, speed_x, speed_y)
    sprite.x += speed_x
    sprite.y += speed_y
  end


#itemをランダムに20個生成
item = []
20.times do
  item << Item.new(rand(0..(640 - 32 - 1)), rand((480 - 32 - 1)), item_img)
end


#ウィンドウの左上にタイトルを表示
Window.caption = "爆弾をよけろ！"

font = Font.new(24)

Window.loop do
    player.update
    player.draw

    bom.draw

    Sprite.draw(item)
    Sprite.draw(walls)
    Sprite.check(player, item)

     # スコアを画面に表示する
    Window.draw_font(20, 20, "SCORE: #{GAME_INFO[:score]}", Font.default)

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

    #爆弾の移動と衝突判定
    move(bom, dx, 0)
    if bom === walls
      bom.x -= dx
      dx = -dx
    end

    move(bom, 0, dy)
    if bom === walls
      bom. y -= dy
      dy = -dy
    end

    if player === bom
      Window.draw_font(240, 320, "Boooom!", font, {:color => C_YELLOW})
      sleep(2)
      break                # breakで loopを抜ける
    end

end

Window.loop do
  Window.bgcolor= C_WHITE
  Window.draw_font(200, 200, "ゲームオーバー", font, {:color => C_BLACK})
  Window.draw_font(200, 230, "（ESCキーで終了）", font, {:color => C_BLACK})
  if Input.key_down?(K_ESCAPE)
    exit                 # exit でプログラムを終了する
  end
end