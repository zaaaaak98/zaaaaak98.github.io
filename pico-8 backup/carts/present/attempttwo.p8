pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

function update_menu()
    if btnp(❎) then
        _update = update_game
        _draw = draw_game
    end
end

function draw_menu()
    cls()
    print("press ❎ to start", 30,60)
end

function update_game()

end

function draw_game()
    cls()
    circfill(63,63,5,11)
end

_update = update_menu

_draw = draw_menu