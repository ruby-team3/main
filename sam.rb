require 'dxruby'

player_img = Image.load("image/player.png")
enemy_img = Image.load("image/enemy.png")

x = 100
y = 100
count = 0
move_x = []
move_y = []

Window.loop do
    count += 1

    y += 1
    if Input.key_push?(K_UP)
        y -= 30
    end
    if Input.key_push?(K_DOWN)
        y += 50
    end
    Window.draw(x,y,player_img)

    num = 0
    if count%20 == 0
        move_x.push(600)
        move_y.push(rand(1...500))
    end
    for i in move_y do
        move_x[num] -= 5
        if move_x[num] <= 50
            move_x.delete_at(num)
            move_y.delete_at(num)
            num += 1
            next
        end
        Window.draw(move_x[num],i,enemy_img)
        num += 1
    end
end