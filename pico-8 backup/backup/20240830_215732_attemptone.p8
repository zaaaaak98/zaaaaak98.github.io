pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
    x=0
    y=5
    s=1
    w=5
end

function update_menu()
				--code for menu logic
				if btnp(❎) then
					--start game
					_update = update_game_map_one
					_draw = draw_game_map_one
					_init()
				end
end

function draw_menu()
				--code for drawing menu
				cls()
				print("enjoy your present",30,63)
				print("press ❎ to play",30,70)
end

function update_game_map_one()
	--code for game map logic
	playermovement()
 	if x>20 and x<28 then
 		if y>24 and y<32 then
    if btnp(❎) then
     _update = update_scene_one
 			 _draw = draw_scene_one
    end
 		end
 	end
 if y>64 then
 	y = 64
 	end
 if x>124 then
  _draw = draw_game_map_two
  _update = update_game_map_two
 end       
end

function update_game_map_two()
 --code for game map logic
	playermovement()
 if x<124 then
  _draw = draw_game_map_one
  _update = update_game_map_one
 end
end

function draw_game_map_one()
	--code for drawing map
 showmap(1)
 spr(s,x,y)
 printcoords()
end

function draw_game_map_two()
 showmap(2)
 spr(s,x,y)
 printcoords()
end

function update_scene_one()
	--code for scene one goes here
	spr(s,x,y)
 map()
 printcoords()
 if btnp(❎) then
  --start game
  _update = update_game_map_one
  _draw = draw_game_map_one
 end
end

function draw_scene_one()
	cls()
	print("scene one start",31,63)
 print("press ❎ to return to map", 28, 70)
 x=15
 y=30
end

_update = update_menu
_draw = draw_menu
-->8
--player movement function
function playermovement()
	if btn(0) then x-=1 end
	if btn(1) then x+=1 end
 if btn(2) then y-=1 end
 if btn(3) then y+=1 end
 w=w-1
 if w<0 then
 	s+=1
 	if s > 2 then s = 1 end
 		w=5
	end
end

--coordinates print for debug
function printcoords()
	print(x)
	print(y)
end

function showmap(x)
	cls()
	if x == 1 then map(0,0)
	elseif x == 2 then map() end
end
__gfx__
00000000000000000000000000555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000ff0000000000000577500005555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000ff000000ff00000577500005775000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000555500000ff00000222200005775000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000050550500055550002522520002222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000cc00005055050005cc500025225200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000cc000000cc000000cc000005cc5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000cc000000cc000000cc000000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333111111111111111104404004044004404400440044004040007777777777770039aa33333333aa930000000000000000000000000000000000000000
3333333311111111111111114000400404040400404040404040404000700007700007003a0a33333333a0a30000000000000000000000000000000000000000
3333333311111111118888110440400404400440404040404040040000700007700007003aa9333333339aa30000000000000000000000000000000000000000
33333333111111111188881100404004040004004400404044000400007000077000070033b3333333333b330000000000000000000000000000000000000000
33333333111111111188881144000440040004404040440040400400007000077000070033b39aa33aa93b330000000000000000000000000000000000000000
33333333111111111188881100000000000000000000000000000000007000077000070033b3a0a33a0a3b330000000000000000000000000000000000000000
33333333111111111111111100000000000000000000000000000000007000077000070033b3aa9339aa3b330000000000000000000000000000000000000000
33333333111111111111111100000000000000000000000000000000007777777777770033333b3333b333330000000000000000000000000000000000000000
33333333333333333333333333333333333333333333333333333333333333333333333333333333000000000000000000000000000000000000000000000000
33300333333000333330003333303333333000333330003333300033333000333330003333300033000000000000000000000000000000000000000000000000
33330333333330333333303333303033333033333330333333333033333030333330303333303033000000000000000000000000000000000000000000000000
33330333333000333333003333300033333000333330003333333033333000333330003333303033000000000000000000000000000000000000000000000000
33330333333033333333303333333033333330333330303333333033333030333333303333303033000000000000000000000000000000000000000000000000
33300033333000333330003333333033333000333330003333333033333000333330003333300033000000000000000000000000000000000000000000000000
33333333333333333333333333333333333333333333333333333333333333333333333333333333000000000000000000000000000000000000000000000000
33333333333333333333333333333333333333333333333333333333333333333333333333333333000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77707700777077707770007000700777007000077707770070077007770000000000000000000000000000000000000000000000000000000000000000000000
70707070700070007000000707000070070700070000700707070700700000000000000000000000000000000000000000000000000000000000000000000000
77707700770077707770000070000070070700077700700777077000700000000000000000000000000000000000000000000000000000000000000000000000
70007070700000700070000707000070070700000700700707070700700000000000000000000000000000000000000000000000000000000000000000000000
70007070777077707770007000700070007000077700700707070700700000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0100000000000000000000000000000001000000000000010101010000000000010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1010101010101010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1110000000000000101a19101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1110001314151600101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1110171817181718101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111211121112111111111111111111111111111111111111111010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1a19102010211022101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101a19101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3031323334353637000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
