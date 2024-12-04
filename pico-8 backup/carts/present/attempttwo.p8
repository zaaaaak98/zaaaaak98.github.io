pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- Initialize game variables
function _init()
 x=0   -- player x position
 y=5   -- player y position
 izaak=1  -- sprite for the main character Izaak
 annie=3  -- sprite for the character Annie
 w,a =5, 30   -- used to control animation speed
 mx = 1 -- map selection flag
 scene = 0 -- keeps track of game scene state
end

-- Function to handle menu updates
function update_menu()
 -- If the player presses the X button (❎), start the game
 if btnp(❎) then
   openingscene()    -- Show opening scene
   instructions()    -- Show game instructions
   mapone()          -- Load first map
   _init()           -- Reinitialize game
 end
end

-- Function to draw the menu
function draw_menu()
 cls()  -- clear screen
 print("enjoy your present",30,63)  -- display title
 print("press ❎ to play",30,70)    -- prompt to start the game
end

-- Update function for game map one
function update_game_map_one()
 playermovement() -- Handles player movement
 -- Check for player entering specific areas (Superdry stores)
 enter_superdry(20,28,24,32)
 enter_superdry(36,44,24,32)
 enter_superdry(52,60,24,32)
 -- Restrict player from moving off the map
 if y>64 and scene==0 then
  y = 64
 end
 -- Change to second map if player moves past the right edge of the screen
 if x>124 and mx != 2 then
  maptwo()    -- Load second map
  enter_left() -- Move player to the left side of the new map
 end       
end

-- Update function for game map two
function update_game_map_two()
 playermovement() -- Handles player movement

 -- Return to first map if player moves past the left edge of the screen
 if x<0 and mx != 1 then
  mapone()    -- Load first map
  enter_right() -- Move player to the right side of the first map
 end

 -- Restrict player from moving off the map
 if y>64 and scene==0 then
  y = 64
 end
end

-- Drawing the first game map
function draw_game_map_one()
 showmap(1)   -- Display map one
 spr(izaak,x,y) -- Draw Izaak's sprite at current x and y coordinates
 printcoords()  -- Debugging: print coordinates for tracking

 -- Detect if the player is in certain regions and prompt action
 if y>24 and y<32 then
  if x>20 and x<28 then
   pressx()  -- Show "press X to enter" prompt
   scene = 1  -- Set current scene
  elseif x>36 and x<44 then
   pressx()
   scene = 2
  elseif x>52 and x<60 then
   pressx()
   scene = 3
  elseif x>92 and x<100 then
   pressx()
   scene = 4
  else
   scene = 0
  end 
 end
end

-- Drawing the second game map
function draw_game_map_two()
 showmap(2)   -- Display map two
 spr(izaak,x,y) -- Draw Izaak's sprite at current x and y coordinates
 printcoords()  -- Debugging: print coordinates for tracking
 -- Detect if the player is in certain regions and prompt action
 if y>24 and y<32 then
  if x>22 and x<26 then
   pressx()  -- Show "press X to enter" prompt
   scene = 5
  elseif x>46 and x<50 then
   pressx()
   scene = 6
  elseif x>86 and x<90 then
   pressx()
   scene = 7
  elseif x>102 and x<106 then
   pressx()
   scene = 8
  else
   scene = 0
  end
 end
end

-- Update function for scene one
function update_scene_one()
 -- Trigger scene dialogue if the player presses X
 playermovement()
end

-- Update functions for other scenes
function update_scene_two()
 playermovement()
end

function update_scene_three()
  playermovement()
 if btnp(❎) then
  mapone() -- Go back to map one
 end
end

-- Draw the first scene
function draw_scene_one()
 showmap(3) -- draw part of the map
 spr(1, x, 40) -- draw Izaak's sprite
 -- Draw based on scene state
 cutscene = true
 if scene==1 then
  spr(3, 100, 40) -- draw Annie's sprite
  print("welcome the new girl",8,80)
  if x==82 then
   scene_one_dialogue() -- Dialogue for scene one
   x=15
  end
  elseif scene==2 then
   print("speak to annie", 8, 80)
   anniemovement("back") -- draw Annie's sprite
   spr(annieback,100, 35)
   if x==82 then
    if annieback==65 then
      annie=4
    else 
      annie=3
    end
    scene_two_dialogue() -- Dialogue for scene two
    x=32
   end
  elseif scene==3 then
   spr(annie, 100, 40) 
   if x==82 then
    scene_three_dialogue() -- Dialogue for scene three
   end
   x=48
  end
 if cutscene == false then  
  y=30 -- Adjust y position
  _draw = draw_game_map_one -- Set drawing function back to game map
  _update = update_game_map_one -- Set update function back to game map
 end
end

-- Set initial update and draw functions for the game
_update = update_menu
_draw = draw_menu
-->8
--player code

-- Initialize player variables
function playerinit()
 x = 0
 y = 5
end

-- Move player to right edge of the screen
function enter_right()
 x = 124
end

-- Move player to left edge of the screen
function enter_left()
 x = 0
end

-- Player movement function
function playermovement()
 -- Check button input for player movement
 if btn(0) then x-=1 end -- move left
 if btn(1) then x+=1 end -- move right
 if btn(2) then y-=1 end -- move up
 if btn(3) then y+=1 end -- move down

 -- Animate the character sprite
 w=w-1
 if w<0 then
  izaak+=1
  if izaak > 2 then izaak = 1 end -- Loop between two sprites
  w = 5 -- Reset animation counter
 end
 
end

function anniemovement(facing)
  if facing=="back" then
   a=a-1
   annieback=64
   if a>15 then
    annieback+=1
    if annieback > 65 then annieback = 64 end -- Loop between two sprites
   elseif a<15 then
    if annieback < 65 then annieback = 64 end
    a = 30 -- Reset animation counter
   end
  end
end
-- Print player's coordinates (used for debugging)
function printcoords()
 print(x, 7)
 print(y, 7)
end

-->8
--map code

-- Function to display the map
function showmap(x)
 cls() -- Clear screen
 if x == 1 then
  map(0,0) -- Show first map
 elseif x == 2 then
  map(16,0) -- Show second map
 elseif x == 3 then
  map(0,16)
 end
end

-- Load first map
function mapone()
 _draw = draw_game_map_one
 _update = update_game_map_one
 mx = 1
end

-- Load second map
function maptwo()
 _draw = draw_game_map_two
 _update = update_game_map_two
 mx = 2
end

-- Handle different scenes
function scene_one()
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

-- Check if player enters a specific region (Superdry store)
function enter_superdry(x_one,x_two,y_one,y_two)
 if x>x_one and x<x_two then
  if y>y_one and y<y_two then
    cutscene = true
   if btnp(❎) and scene==1 then
    scene_one() -- Trigger scene one
   elseif btnp(❎) and scene==2 then
    scene_two() -- Trigger scene two
   elseif btnp(❎) and scene==3 then
    scene_three() -- Trigger scene three
   end
  end
 end
end

-->8
--dialogue code

-- Delay function (creates pause)
function sleep(s)
 for i=1, s*30 do flip() end -- Pauses for s seconds
end

-- Show "press X" prompt
function pressx()
 print("press ❎ to enter level",8,80)
end

-- Opening scene sequence
function openingscene()
 cls()
 print("this is a tale about a boy")
 print("named izaak...")
 sleep(5)
 print(" ")
 print(" ")
 print("and a girl named annie...")
 sleep(5)
 print(" ")
 print(" ")
 print("this story begins in 2019")
 sleep(5)
end

-- Game instructions
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

-- Dialogue for scene one
function scene_one_dialogue()
 if cutscene then
  remove_speaker()
  speaker("izaak") -- Show Izaak speaking
  speak("hey, how's it going?", 1)
  speak("my name is izaak.", 2)
  speak("what's your name?", 3)
  sleep(3) -- Wait 3 seconds
  remove_speaker() -- Clear dialogue box
  speaker("new girl") -- Show Annie speaking
  speak("hi, i'm annie.", 1)
  sleep(3)
  remove_speaker()
  speaker("izaak")
  speak("nice to meet you!",1)
  speak("have you only just started",2)
  speak("here?",3)
  sleep(3)
  remove_speaker()
  speaker("annie")
  speak("yeah, i've not been here",1)
  speak("very long.", 2)
  sleep(2)
  remove_speaker()
  speaker("izaak")
  speak("yeah, me too", 1)
  speak("i've been here for about", 2)
  speak("a month maybe?",3)
  sleep(2)
  remove_speaker()
  speaker("izaak")
  speak("how are you finding it ",1)
  speak("so far?", 2)
  sleep(2)
  remove_speaker()
  speaker("annie")
  speak("it's okay.",1)
  sleep(2)
  remove_speaker()
  speaker("izaak")
  speak("right, well i'd better",1)
  speak("get back to it. emma", 2)
  speak("will moan at me if i don't.", 3)
  sleep(3)
  remove_speaker()
  speaker("izaak")
  speak("catch you later annie", 1)
  sleep(2)
  remove_speaker()
  cutscene = false -- End cutscene
 end
end

-- Dialogue for scene two
function scene_two_dialogue()
 remove_speaker()
 speaker("izaak")
 speak("hey annie, can you do me", 1)
 speak("a favour?", 2)
 sleep(2)
 spr(annie,100,35)
 remove_speaker()
 speaker("annie")
 speak("yep?",1)
 sleep(2)
 remove_speaker()
 speaker("izaak")
 speak("would you be able to close", 1)
 speak("my section for me? i just", 2)
 speak("need to do something.", 3)
 sleep(3)
 remove_speaker()
 speaker("izaak")
 speak("i'll owe you a mcdonalds?", 1)
 sleep(2)
 remove_speaker()
 speaker("annie")
 speak("yeah of course.", 1)
 sleep(2)
 remove_speaker()
 speaker("izaak")
 speak("thank you so much!", 1)
 speak("i'll try and be quick.", 2)
 sleep(2)
 cutscene=false
end

-- Dialogue for scene three
function scene_three_dialogue()
 remove_speaker()
 speaker("izaak")
 speak("hey, you ready for that", 1)
 speak("mcdonalds?", 2)
 sleep(3)
 remove_speaker()
 speaker("annie")
 speak("yep. just let me get my", 1)
 speak("bag from the back.", 2)
 sleep(2)
 remove_speaker()
 speaker("izaak")
 speak("no problem, i'll wait", 1)
 speak("here", 2)
 sleep(2)
 cutscene=false

 end 

-- Display dialogue text letter by letter
function speak(words,lines)
 local x, y = 4, 80 + (lines-1)*8 -- Position text
 local current_text = ""
 for i=1,#words do
  current_text = current_text..sub(words,i,i)
  print(current_text,x,y,7) -- Display text
  flip() -- Wait for next frame
 end
end

-- Display speaker name
function speaker(person)
 print(person, 8, 68, 7)
 sleep(0.5) -- Pause to show name
end

-- Clear speaker name
function remove_speaker()
 rectfill(4,68,118,110,0) -- Clear the dialogue box area
 sleep(1)
end
__gfx__
00000000000000000000000000555500000000003333333333333333333333334444444444444444444444443333333354444445333333333333333333333333
00000000000ff0000000000000577500005555003333383333333333333333334444444444444444444444443335533354555544555555555555555555555555
00000000000ff000000ff00000577500005775003333388388833883888388834555555555555555555555543354453354566544544444444444444444444445
0000000000555500000ff00000222200005775003888888888838383838383334566666666666666666666543544445354566544566446644664466446644665
00000000050550500055550002522520002222003888888883838383883388334566566665666656666566545445544554566544566446644664466446644665
00000000000cc00005055050005cc500025225203333388383838383838383334565556655566555665556545446644554566544566446644664466446644665
00000000000cc000000cc000000cc000005cc5003333383383838833838388834565556655566555665556545446644554555544544444444444444444444445
00000000000cc000000cc000000cc000000cc0003333333333333333333333334565556655566555665556545445544554444444555555555555555555555555
33333333111111111111111109909009099009909900990099009090007777777777770039aa33333333aa935444444554444445333333331111111111111111
3333333311111111111111119000900909090900909090909090909000700007700007003a0a33333333a0a35444444544555545111111115555555555555555
3333333311111111118888110990900909900990909090909090090000700007700007003aa9333333339aa34444444444566545161616160000000000000000
33333333111111111188881100909009090009009900909099000900007000077000070033b3333333333b334664466444566545161616160555555555555550
33333333111111111188881199000990090009909090990090900900007000077000070033b39aa33aa93b334664466444566545161616160500000550000050
33333333111111111188881100000000000000000000000000000000007000077000070033b3a0a33a0a3b334664466444566545161616160507770550777050
33333333111111111111111100000000000000000000000000000000007000077000070033b3aa9339aa3b334444444444555545161616160507770550777050
33333333111111111111111100000000000000000000000000000000007777777777770033333b3333b333335555555544444445111111110507770550777050
33333333333333333333333333333333333333333333333333333333333333333333333333333333111111111111111111111111111111111111111111111111
33300333333000333330003333303333333000333330003333300033333000333330003333300033000800000000000000000000000000000000000055555555
33330333333330333333303333303033333033333330333333333033333030333330303333303033008080077707077007770707007707770700770000000000
33330333333000333333003333300033333000333330003333333033333000333330003333303033880008870007070707700707070707070700707055555555
33330333333033333333303333333033333330333330303333333033333030333333303333303033080008070007070707000777070707700700707050000005
33300033333000333330003333333033333000333330003333333033333000333330003333300033008880077707070707770777077007070770770050777705
33333333333333333333333333333333333333333333333333333333333333333333333333333333008080000000000000000000000000000000000050777705
33333333333333333333333333333333333333333333333333333333333333333333333333333333111111111111111111111111111111111111111150777705
4444444444444444444444440dd5dd0dddddd5dd0000000000000000000000007777777777777777700000000000000777777777000000007000000000000007
555555555555555555555555d5505505555550555555555555555555555555557000000000000007700000000000000700000000000000007000000000000007
44444444444444444444444450000050000000005707070557070705570707057000000000000007700000000000000700000000000000007000000000000007
4446444444446444444444440000000000000000530303055e0e0e05590909057000000000000007700000000000000700000000000000007000000000000007
4464644444464644444444440dd5dd0dddddd0dd530303055e0e0e05590909057000000000000007700000000000000700000000000000007000000000000007
444114444444224444444444d550550555555055530303055e0e0e05590909057000000000000007700000000000000700000000000000007000000000000007
4411114444422224444444445000005000000500530303055e0e0e05590909057000000000000007700000000000000700000000000000007000000000000007
41411414442422424444444400000000000000000000000000000000000000007000000000000007777777777777777700000000777777777000000000000007
00555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555500005555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555500005555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555500005555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02555520005555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555500025555200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000cc000005555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000cc000000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0100000000000000000000000000000001000000000000010101010000000000010101010101010101000000000000000000000000000000000000000000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
101010101010101010101010101010101010101010101010101a191010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1110000000000000101a191010100607100b100b10100b100b101d1d1d1d1d10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11100013141516001010101010100505100c0d1b0e0e1b0f1c102a2b2c2d2e10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11101718171817181010101010101a19100c08090a08090a1c101e1f2f1e1f10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111211121112111111111211111111111112111112111111111211121111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1a19102010211022101010102310101010101024101025101010102610271010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10101010101010101010101010101010101010101a1910101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101a19101010101010101010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
101010101010101010101010101010101010101010101010101010101a191010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
