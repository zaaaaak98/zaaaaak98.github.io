pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--game code
function _init()
	x=0
	y=5
	izaak=1
	annie=3
	w=5
 --mx used to help with map 
 --select
	mx = 1
 scene = 0
end

function update_menu()
	--code for menu logic
	if btnp(❎) then
	 --start game
	 openingscene()
	 instructions()
	 mapone()
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
 enter_superdry(20,28,24,32)
 enter_superdry(36,44,24,32)
 enter_superdry(52,60,24,32)
 if y>64 and scene==0 then
  y = 64
 end
 if x>124 and mx != 2 then
  maptwo()
  enter_left()
 end       
end

function update_game_map_two()
 --code for game map logic
	playermovement()
 if x<0 and mx != 1 then
  mapone()
  enter_right()
 end
 if y>64 and scene==0 then
  y = 64
 end
end

function draw_game_map_one()
	--code for drawing map
 showmap(1)
 spr(izaak,x,y)
 printcoords()
 if y>24 and y<32 then
  if x>20 and x<28 then
   pressx()
   scene = 1
  elseif x>36 and x<44 then
 		pressx()
 		scene = 2
 	elseif x>52 and x<60 then
 		pressx()
 		scene = 3
    else scene = 0
 	end 
 end
end

function draw_game_map_two()
 showmap(2)
 spr(izaak,x,y)
 printcoords()
end

function update_scene_one()
	--code for scene one goes here
	spr(izaak,x,y)
 --printcoords()
 if btnp(❎) then
  --start game
  mapone()
 end
end

function update_scene_two()
 if btnp(❎) then
  --start game
  mapone()
 end
end

function update_scene_three()
 if btnp(❎) then
  --start game
  mapone()
 end
end

function draw_scene_one()
 cls()
 map(0,16)
 --moves player off of level start position
 if scene==1 and cutscene then x=15 scene_one_dialogue()
 elseif scene==2 and cutscene then x=32 scene_two_dialogue()
 elseif scene==3 and cutscene then x=48 scene_three_dialogue() end
 y=30
 _draw = draw_game_map_one
 _update = update_game_map_one
end

_update = update_menu
_draw = draw_menu
-->8
--player code

function playerinit()
	x = 0
	y = 5
end

--get character on right side of screen
function enter_right()
	x = 124
end

--get character on left side of screen
function enter_left()
 x = 0
end

--player movement function
function playermovement()
	if btn(0) then x-=1 end
	if btn(1) then x+=1 end
 if btn(2) then y-=1 end
 if btn(3) then y+=1 end
 w=w-1
 if w<0 then
  izaak+=1
  if izaak > 2 then izaak = 1 end
  w = 5
	end
end

--coordinates print for debug
function printcoords()
	print(x)
	print(y)
end




-->8
--map code
function showmap(x)
	cls()
	if x == 1 then map(0,0)
	elseif x == 2 then map(16,0) end
end

function mapone()
	_draw = draw_game_map_one
	_update = update_game_map_one
	mx = 1
end

function maptwo()
	_draw = draw_game_map_two
	_update = update_game_map_two
	mx = 2
end

function scene_one()
 cutscene=true
 _draw = draw_scene_one
 _update = update_scene_one
end

function scene_two()
	_draw = draw_scene_one
	_update = update_scene_two
end

function scene_three()
	_draw = draw_scene_one
	_update = update_scene_three
end

function enter_superdry(x_one,x_two,y_one,y_two)
 if x>x_one and x<x_two then
  if y>y_one and y<y_two then
   if btnp(❎) and scene==1 then
    scene_one()
   elseif btnp(❎) and scene==2 then 
   	scene_two()
   elseif btnp(❎) and scene==3 then
   	scene_three()
   end
  end
 end
end

-->8
--dialogue code

--function to allow for delay
function sleep(s)
	for i=1, s*30 do flip() end
end

function pressx()
	print("press ❎ to enter level",8,80)
end

--opening credits
function openingscene()
 cls()
	print("this is a tale about a boy")
	print("named izaak...")
	sleep(5)
	print(" ")
	print("and a girl named annie...")
	sleep(5)
    print(" ")
    print(" ")
	print("this story begins in 2019")
	sleep(5)
end

--game instructions
function instructions()
	cls()
	print("press the arrows to move around")
	print(" ")
	print(" ")
	print("press ❎ to interact")
	print("with objects")
	sleep(5)
	cls()
end

--working on this
function scene_one_dialogue()
 speaker(1)
 speak("line one test.", 1)
 speak("line two test.", 2)
 speak("line three test.", 3)
 sleep(3)
 speaker(2)
 speak("line one test annie",1)
 cutscene = false
end

function scene_two_dialogue()
 speak("scene two.", 1)
end 

function scene_three_dialogue()
 speak("scene three.", 1)
end

--max 29 char 1 full stop
function speak(words, lines)
 local x = 4
 local y = 80 + (lines - 1) * 8  -- calculate y position based on line number
 local current_text = ""
 -- Typewriter effect: print one letter at a time
 for i = 1, #words do
  current_text = current_text .. sub(words, i, i)  -- add one letter at a time
  print(current_text, x, y)
  flip()  -- wait for a frame to simulate typewriter effect
 end
end

function speaker(person)
 if person==1 then
  print("izaak", 8, 68)
 else
  print("annie", 96, 72)
 end
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
33333333111111111111111109909009099009909900990099009090007777777777770039aa33333333aa930000000000000000000000000000000000000000
3333333311111111111111119000900909090900909090909090909000700007700007003a0a33333333a0a30000000000000000000000000000000000000000
3333333311111111118888110990900909900990909090909090090000700007700007003aa9333333339aa30000000000000000000000000000000000000000
33333333111111111188881100909009090009009900909099000900007000077000070033b3333333333b330000000000000000000000000000000000000000
33333333111111111188881199000990090009909090990090900900007000077000070033b39aa33aa93b330000000000000000000000000000000000000000
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
4444444444444444444444440dd5dd0dddddd5dd0000000000000000000000007777777777777777700000000000000777777777000000007000000000000007
555555555555555555555555d5505505555550555555555555555555555555557000000000000007700000000000000700000000000000007000000000000007
44444444444444444444444450000050000000005707070557070705570707057000000000000007700000000000000700000000000000007000000000000007
4446444444446444444444440000000000000000530303055e0e0e05590909057000000000000007700000000000000700000000000000007000000000000007
4464644444464644444444440dd5dd0dddddd0dd530303055e0e0e05590909057000000000000007700000000000000700000000000000007000000000000007
444114444444224444444444d550550555555055530303055e0e0e05590909057000000000000007700000000000000700000000000000007000000000000007
4411114444422224444444445000005000000500530303055e0e0e05590909057000000000000007700000000000000700000000000000007000000000000007
41411414442422424444444400000000000000000000000000000000000000007000000000000007777777777777777700000000777777777000000000000007
__gff__
0100000000000000000000000000000001000000000000010101010000000000010101010101010101010000000000000000000000000000000000000000000001010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
383c3c3c3c3c3c3c3c3c3c3c3c3c3c39383c3c3c3c3c3c3c3c3c3c3c3c3c3c39000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3e00000000000000000000000000003f3e00000000000000000000000000003f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3e00000000000000000000000000003f3e00000000000000000000000000003f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3e00000000000000000000000000003f3e00000000000000000000000000003f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3e00000000000000000000000000003f3e00000000000000000000000000003f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3a3d3d3d3d3d3d3d3d3d3d3d3d3d3d3b3a3d3d3d3d3d3d3d3d3d3d3d3d3d3d3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3334333433343334333433343334333400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3530313636313737303235353031303600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3532313636313737303135353232313600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3530313631373735303236363130323700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
383c3c3c3c3c3c3c3c3c3c3c3c3c3c3900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3e00000000000000000000000000003f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3e00000000000000000000000000003f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3e00000000000000000000000000003f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3e00000000000000000000000000003f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3a3d3d3d3d3d3d3d3d3d3d3d3d3d3d3b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
