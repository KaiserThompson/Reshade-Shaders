------------------------------------------------------------------------------------------------------------------------------------------------------
Reshade Placement Order

------------------------------------------------------------------------------------------------------------------------------------------------------
UIDetectMulti(ALWAYS FIRST, This detects the ui elements before any effects are applied so it has to go first)

UIDetectMulti_Before(This grabs the masked elements as is so any shaders before this will affect the whole screen)

Place shaders that you don't want to affect masked elements here

UIDetectMulti_After(This applies the Masked elements grabbed from UIDetectMulti_Before as a layer placed on top of the game)

------------------------------------------------------------------------------------------------------------------------------------------------------
Creating A Mask

------------------------------------------------------------------------------------------------------------------------------------------------------
Each mask can affect up to 3 ui elements, one for red, one for blue, and one for green. The easiest way ive found to create the masks is to use a picture editing program that allows for layers like gimp or photoshop. Import a screenshot that shows the ui element, create a new transparent layer, and then start drawing in the color that you want to use (pure red, green or blue) over the UI element you are looking to mask. Once you are satisfied with the mask or masks on your image, delete the layer that contains your screenshot and create a new layer that is pure white. Make sure the white layer is at the bottom of your list of layers. Now go to your mask layer and set the layer mode to subtract. The colors should change and that is perfect if they do. Green becomes magenta, red becomes cyan, and blue becomes yellow. Once that is done, go ahead and export the image to the reshade textures folder as UIDetectMaskRGBMulti.png (add 2, 3, 4, or 5 before the .png to set up additional masks if you have more than 3 you would like to affect.)  Now you've got a mask ready to be turned on. Congrats. 

------------------------------------------------------------------------------------------------------------------------------------------------------
Selecting A Pixel To Use For A Mask and Applying The Mask

------------------------------------------------------------------------------------------------------------------------------------------------------
Now that you have your custom mask, its time to make the mask actually do the work it was made for. This can be a bit complicated but thankfully has been made much easier now that certain features have been added.

The first thing you're going to want to do is open up UIDetectMulti.Fxh(hopefully on a second monitor if you can, it makes things much easier.) Now that you have that file open, your probably a bit lost if you have never looked at code before. Dont panic. You are just going to be copying numbers from your game.

Speaking of which, go ahead and open the game and get one of the ui elements that you made your mask for on screen. Now open up your reshade menu(default button is the home key in the latest version of reshade) and find and select UiDetectMulti, UIDetectMulti_Before, and UIDetectMulti_After. Turn them on and move UiDetectMulti and UiDetectMulti_Before to the top of your list, best place is right below UIDetectMulti, move After below any shaders you dont want affecting your ui. Now make sure performance mode is toggled off, and you should see a menu option for uidetectmulti in the bottom panel. Once you've found it, click on preprocessor definitions and change UIDM_DIAGNOSTICS from 0 to 1.

When you do that a bunch of things are going to change on screen, any effects you had on are being hidden for now to make this tool easier to use. You should see a crosshair up at the top left and some text in the middle of the screen. If you do great, we're almost there.

Back in the reshade menu, a new category will have appeared called pixel selection. go ahead and expand that and you should find 2 sliders and a toggle, by sliding the top slider, you will move the crosshair left and right and by moving the second slider, your will move the crosshair up and down. The toggle allows for you to change the font color of the text if it is difficult to read in the environment you are in in game.

Now that were up to speed with the menu, its time to find a good pixel for your ui. A good pixel is one that doesnt change so long as the ui is visible. This means dont choose a pixel on a health bar or stamina bar that can deplete, the outside edges are much better for use.

Once you have found a good pixel or at least the area you think there could be a good pixel, move the center of the crosshair to the pixel you want to use. Once you are there, leave the crosshair on it and move around in game. Watch the text on screen and if the numbers dont change at all even when you change light levels(such as entering a cave or looking at the sun) then you have found a good pixel. If it changes when moving around then you should look for another pixel to use. Dont be discouraged if you keep running into pixels that change colors. Transparant ui elements cause lots of problems. (if none of the pixels are unchanging there is another option that i will outline below.)

Now that you have found a good pixel, take note of the slider values and the numbers in the text on Screen. We're going to need all 5 of those numbers and what they correspond to. Now its time to go back to that document we opened earlier. When you scroll down, you should see the phrase #define PIXELNUMBER. Below that is where we need to enter those numbers. Go ahead and delete all but one of the lines that start with float3 from both of the lists.

Now inside the parenthesis of the first float 3, you should see 3 numbers seperated by commas. The first number corresponds to the X coordinate you got earlier. Go ahead and remove the first number and put in your number instead. The next number is the Y coorsinate you got earlier. Do the same for that number. The third number gets tricky and relates back to the mask you made in part 1.

If you saved the mask as UIDetectMaskRGBMulti.png, then the third number will be 1, 2, or 3, depending on what color you made that ui elements mask. If the color was red(cyan now if you have to open the file again to remember) then the third number is 1, green(magenta) is 2, and blue(yellow) is 3. If you saved the mask as UIDetectMaskRGBMulti2.png those shift to 4, 5, and 6 and so on, counting up with the other three mask names you could have chosen.

Thats the first set of values and if you didnt start with the red mask first, dont fret, so long as you keep all entries for each mask together(1-3, 4-6, and so on) you shouldnt have any problems.

Now on to the second section with float4. This is where you will be putting in your color values, red for the first number, green for the second, blue for the third. Once you have that entered, go ahead and go back up to #define PIXELNUMBER and change the number after that from its current value to 1. Save the file and go back to your game.

Now we're going to test your mask. Change UIDM_DIAGNOSTICS back to 0 and you should see your effects turn back on everywhere but the area that you masked. Congratulations, you made a mask and applied it. For the other 2-14 masks, you just repeat these steps, entering more float3 and float4 values in UIDetectMulti.fxh.

Make sure you keep your entries aligned between the top set and bottom set. If you put the entries in in a different order than eachother then the shader may be looking in the wrong place. Each float3 on the top list is required to have a corresponding float4 on the bottom list and if they get mixed up in some way, the entries will correspond incorrectly and pixel 2 might end up looking for pixel 3's color.

If you cannot find a good pixel for a ui element, all of them change in some way or another, make sure UIDM_EVERYPIXEL is set to 0 (it should be by default) and choose a pixel that changes the least such as a health bar or a weather icon. And take down every value that you see for the colors as they change. Try and get every value that can show up as even a single missed color value can cause the mask to turn off. Once you have all the values go back into UIDetectMulti.fxh and put in as many float3s into the top list with the correct x,y,mask number values as you have colors values. In the bottom list, you're going to need to make a float4 for each and every color value you captured so the shader will look and see if any of them are correct. If one is then the mask turns on. If none are correct numbers then the mask turns off. 
