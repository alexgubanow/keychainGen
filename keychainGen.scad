// Batch Keychain Generator v1.0
// by TheNewHobbyist 2013 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:101307
//
// I needed something to quickly generate custom models for
// a 3D printing demo I was doing. I was going to just
// make a pile of generic keychains but I thought it would
// be more fun if I could make customized models for each 
// person.
//
// Change Log:
//
// v1.0
// Initial Release
//
// v1.1
// ADDED Round Tag and Blocky style keychains

// by matroskin (http://0x0h.com)
// https://www.thingiverse.com/thing:2555679
//
// I needed this too, but for more letters
// And i rewrite it for more comfortable work
//
// Change Log:
//v1.2
//rewrite for more letters in row
//
//v1.3
//add textSize and blockSize
//
//v1.4
//left only one textBox
//
//v1.5
//tune all variables
//
//v2.0 Huge Update
//Added font picker, font size picker, a lot of new styles of keychains
//You can choose one or two lines of text

/* [Make It Your Own] */

//Choose style of your keychain (HashTag,Coin,Shield,Castle coming soon)
Keychain_Style = "Tag"; //["Classic":Classic, "HashTag":HashTag, "Coin":Coin, "Shield":Shield, "Castle":Castle, "Tag":Round Tag, "Block":Blocky]
//Choose plate height
Plate_Height = 3; //[1:50]

/* [Text] */

//Write your text of first line
Text = "Hello";
//Choose font size
Text_Y_offset = -3; //[-50:50]
//Choose font
Font_Style = "write/orbitron.dxf"; //["write/Letters.dxf":Letters, "write/BlackRose.dxf":BlackRose, "write/orbitron.dxf":Orbitron, "write/knewave.dxf":Knewave, "write/braille.dxf":Braille]
//Choose font size
Font_Size = 12; //[1:50]
//Choose font height
Font_Height = 2; //[1:50]

/////////////////////////
// Beat it Customizer //
///////////////////////

/* [Hidden] */

// preview[view:south, tilt:top]

use <write/Write.scad>
use <utils/build_plate.scad>

$fn=24;
if(Keychain_Style == "Classic") { classicKeychain(Text, Font_Size, Font_Style, Plate_Height,Text_Y_offset); }
else if(Keychain_Style == "HashTag") { hashtagKeychain(len(Text)); }
else if(Keychain_Style == "Coin"){ coinKeychain(Text, Font_Size, Font_Style, Font_Height, Plate_Height); }
else if(Keychain_Style == "Shield") { shieldKeychain(len(Text)); }
else if(Keychain_Style == "Castle") { castleKeychain(len(Text)); }
else if(Keychain_Style == "Tag") { tagKeychain(Text, Font_Size, Font_Style, Font_Height, Plate_Height); }
else if(Keychain_Style == "Block") { blockKeychain(Text, Font_Size, Font_Style, Font_Height, Plate_Height);}

module classicKeychain(Text, FontSize, FontStyle, Plate_Height,Text_Y_offset){
	if (Text != "")
	{
		translate([0,0,plateHeight/2]) {
			rotate([-90,0,0]){
				union() {
					for ( i = [0 : len(Text) - 1] )	{
						translate([FontSize*i,0,
                        -(FontSize - 4)]) 
                        cube([FontSize, Plate_Height,
                        FontSize/6],
                        center=true);
						translate([FontSize*i,0,Text_Y_offset]) 
                        rotate([90,0,0]) 
                        write(Text[i],
                            h=FontSize,
                            t=Plate_Height,
                            font=FontStyle,
                            space=1,
                            center=true);
					}
					difference(){
		translate([-FontSize + FontSize/5,0,-(FontSize - 4)])
        rotate([90,0,0]) 
        cylinder(r=FontSize/3, h=Plate_Height, $fn=100, center=true);
		translate([-FontSize + FontSize/5,0,-(FontSize - 4)]) 
        rotate([90,0,0])
        cylinder(r=FontSize/5, h=Plate_Height + 1, center=true);
        }
    }
				}
			}
		}
	}	
module coinKeychain(Text, FontSize, FontStyle, FontHeight, plateHeight){

	if (Text != ""){
		translate([0,0,plateHeight/2]) {
			rotate([-90,0,0]){
				difference(){					
					//translate([0,0,FontSize-1])
                    rotate([90,0,0])
                    cylinder(r=FontSize/2*len(Text)+ 3,h=plateHeight, center=true);
					translate([0,0,FontSize/2*len(Text) - FontSize/2.5 * 2 +2])
                    rotate([90,0,0])
                    cylinder(r=FontSize/2.5, h=plateHeight + 1, center=true);
					for ( i = [0 : len(Text) - 1] )	{
						translate([
                        -len(Text)*4+(FontSize*i),
                        -Plate_Height,0])
                        rotate([90,0,0])
                        write(Text[i],
                        h=FontSize,
                        t=Plate_Height+FontHeight,
                        font=FontStyle,
                        space=1, center=true);
					}
				}
			}
		}
	}	
}	
module tagKeychain(Text, FontSize, FontStyle, FontHeight, plateHeight){

	if (Text != ""){
		translate([0,0,plateHeight/2]) {
			rotate([-90,0,0]){
				difference(){
					
					hull() {
						translate([-FontSize-1,0,0]) rotate([90,0,0])
                        cylinder(r=FontSize,
                        h=plateHeight, center=true);
						translate([(len(Text) * FontSize - 3),0,0]) 
                        rotate([90,0,0]) 
                        cylinder(r=FontSize,
                        h=plateHeight, center=true);
					}
					translate([-FontSize,0,0]) rotate([90,0,0])
                    cylinder(r=FontSize/2.5, h=plateHeight + 1, center=true);
					for ( i = [0 : len(Text) - 1] )	{
						translate([
                        (FontSize*i+FontSize/4),
                        -Plate_Height,0])
                        rotate([90,0,0])
                        write(Text[i],
                        h=FontSize,
                        t=Plate_Height+FontHeight,
                        font=FontStyle,
                        space=1, center=true);
					}
				}
			}
		}
	}	
}
 
module blockKeychain(Text, FontSize, FontStyle, FontHeight, PlateHeight, BetweenLetters){
	if (Text != ""){
		translate([0,0,plateHeight/2]) {
			rotate([-90,0,0]){
				union() {
					for ( i = [0 : len(Text) - 1] )	{
						translate([FontSize*i,0,0]) 
                        cube([FontSize, Plate_Height,
                        FontSize/2],
                        center=true);
						translate([FontSize*i,-FontHeight/2+Plate_Height/2,0]) 
                        rotate([90,0,0]) 
                        write(Text[i],
                            h=FontSize,
                            t=FontHeight,
                            font=FontStyle,
                            space=1,
                            center=true);
					}
					difference(){
		translate([-FontSize + FontSize/5,0,0])
        rotate([90,0,0]) 
        cylinder(r=FontSize/2.5, h=Plate_Height, $fn=100, center=true);
		translate([-FontSize + FontSize/5,0,0]) 
        rotate([90,0,0])
        cylinder(r=FontSize/4.25, h=Plate_Height + 1, center=true);
        }
    }
				}
			}
	}	
}
























