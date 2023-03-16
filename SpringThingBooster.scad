// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringThingBooster.scad
// by David M. Flynn
// Created: 2/26/2023
// Revision: 1.0.0   3/16/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Built to deploy a parachute from a booster with a spring.
// 80mm of 54mm tube is required. 
//
// Electronics:
//  Motor Topper PCB (Req. A23 12V Battery)
//  Rocket Servo PCB (Req. 9V Battery)
//  SG90 or Eqiv. 9g Micro Servo
//
// Hardware:
//  #4-40 x 1/2" Socket Head Cap Screw (5 Req.)
//  #2-56 x 1/4" Socket Head Cap Screw (2 Req.)
//  3/16" Dia. x 1/8" Thick Magnet (2 Req.)
//  3/8" Delrin Ball (3 Req.)
//  MR84 Bearing 8mm OD x 4mm ID x 3mm Thick (5 Req.)
//  Steel Dowel Pin 4mm (Undersized) x 10mm (3 Req.)
//  Steel Dowel Pin 4mm (Undersized) x 16mm (3 Req.)
//
//  ***** History *****
echo("SpringThingBooster Rev. 0.9.5");
// 1.0.0   3/16/2023  Fixed STB_DrillingJig, it works.
// 0.9.5   3/10/2023  Fixes to STB_Cover
// 0.9.4   3/2/2023   Added notes, Code clean-up, FC need to print and test one.
// 0.9.3   3/1/2023   Added STB_Cover(), Added Manuan Arm/Disarm holes, fixed OD
// 0.9.2   2/28/2023  Many fixes, added SpringSeat(), DrillingJig()
// 0.9.1   2/27/2023  Three parts ready for first printing.
// 0.9.0   2/26/2023  First code.
//
// ***********************************
//  ***** for STL output *****
//
// STB_Cover(BT_ID=PML54Body_ID);
// STB_BallRetainerTop(BT_ID=PML54Body_ID, CT_ID=PML54Coupler_ID);
// STB_LockDisk(BT_ID=PML54Body_ID, CT_ID=PML54Coupler_ID);
// STB_BallRetainerBottom(BT_ID=PML54Body_ID, CT_ID=PML54Coupler_ID);
// STB_SpringSeat(CT_ID=PML54Coupler_ID, Base_H=14);
//
//  *** Tools ***
//
//  ** Drill the end of the coupler tube before gluing on the body tube. **
// STB_DrillingJig(BT_ID=PML54Body_ID, CT_OD=BT54Coupler_OD); 
//
// ***********************************
//  ***** Routines *****
//
// function STB_LockPinBC_d(BT_ID=PML54Body_ID,)=BT_ID-LockBall_d*2-BearingMR84_OD;
// STB_CT_Section(CT_OD=PML54Coupler_OD, CT_ID=PML54Coupler_ID);
// STB_ShockCordHolePattern(BT_ID=PML54Body_ID);
// ManualDisArmingHole(BT_ID=PML54Coupler_OD);
// ManualArmingHole(BT_ID=PML54Body_ID);
//
// ***********************************
//  ***** for Viewing *****
//
// STB_ShowExpandedBosterSpringThing(BT_ID=PML54Body_ID, CT_ID=PML54Coupler_ID);
// STB_ShowBosterSpringThing();
//
// STB_ShowLockBearings(BT_ID=PML54Body_ID);
// STB_ShowMyBalls(BT_ID=PML54Body_ID, InLockedPosition=true);
//
// ***********************************

include<TubesLib.scad>
use<SG90ServoLib.scad>
use<BatteryHolderLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

BearingMR84_OD=8;
BearingMR84_ID=4;
BearingMR84_W=3;

BearingR8_ID=12.7;
BearingR8_OD=1.125*25.4;
BearingR8_W=5/16*25.4;

Bearing6702_ID=15;
Bearing6702_OD=21;
Bearing6702_W=4;

nLockBalls=3;
LockBall_d=3/8*25.4;

Bolt4Inset=4;
Magnet_d=4.8;
Magnet_h=3.2;
Dowel_d=4;
MagnetPost_a=14;

// Deployment Spring big and light
ST_DSpring_OD=44.30;
ST_DSpring_ID=40.50;
ST_DSpring_CBL=22; // coil bound length
ST_DSpring_FL=200; // free length

LockDisk_H=10; // length of dowel pins
LockDiskHole_H=LockDisk_H+1;
Unlocked_a=25;
function STB_LockPinBC_d(CT_OD=PML54Coupler_OD)=CT_OD-LockBall_d*2-BearingMR84_OD;

module STB_ShowExpandedBosterSpringThing(BT_ID=PML54Body_ID, CT_ID=PML54Coupler_ID){

	translate([0,0,110]) STB_Cover(BT_ID=BT_ID);
	
	translate([0,0,40]) STB_BallRetainerTop(BT_ID=BT_ID, CT_ID=CT_ID);
	
	translate([0,0,20])
	//rotate([0,0,Unlocked_a]) // unlocked
	{ STB_LockDisk(BT_ID=BT_ID, CT_ID=CT_ID); 
		STB_ShowLockBearings(BT_ID=BT_ID); }
	
	STB_BallRetainerBottom(BT_ID=BT_ID, CT_ID=CT_ID);
	
	translate([0,0,-40]) STB_SpringSeat(CT_ID=PML54Coupler_ID, Base_H=14);
} // STB_ShowExpandedBosterSpringThing

//STB_ShowExpandedBosterSpringThing();

module STB_ShowBosterSpringThing(BT_ID=PML54Body_ID, CT_ID=PML54Coupler_ID){

	difference(){
		union(){
			translate([0,0,52.5]) color("Orange") STB_Cover(BT_ID=BT_ID);
			translate([0,0,0.1]) color("LightBlue") STB_BallRetainerTop(BT_ID=BT_ID, CT_ID=CT_ID);
			
			//rotate([0,0,Unlocked_a])  // unlocked
			{ STB_LockDisk(BT_ID=BT_ID, CT_ID=CT_ID); 
				STB_ShowLockBearings(BT_ID=BT_ID); }
			
			color("Green") STB_BallRetainerBottom(BT_ID=BT_ID, CT_ID=CT_ID);
			
			translate([0,0,-33]) color("Gray") STB_SpringSeat(CT_ID=PML54Coupler_ID, Base_H=14);
		} // union
		
		translate([-100,-50,-50]) cube([100,50,150]);
	} // difference
} // STB_ShowBosterSpringThing

//STB_ShowBosterSpringThing();

module STB_SpringSeat(CT_ID=PML54Coupler_ID, Base_H=14){
	
	echo("Spring Seat = ",Base_H+ST_DSpring_CBL);
	
	difference(){
		union(){
			translate([0,0,-Overlap]) cylinder(d=ST_DSpring_ID, h=ST_DSpring_CBL);
			translate([0,0,-Base_H]) cylinder(d=CT_ID, h=Base_H);
		} // union
		
		translate([0,0,-Base_H-Overlap]) cylinder(d=ST_DSpring_ID-4.4, h=Base_H+ST_DSpring_CBL+Overlap*2);
	} // difference
} // STB_SpringSeat

//STB_SpringSeat();

module STB_CT_Section(CT_OD=PML54Coupler_OD, CT_ID=PML54Coupler_ID){
	difference(){
		translate([0,0,-25]) Tube(OD=CT_OD, ID=CT_ID, Len=40, myfn=$preview? 36:360);
		
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,CT_OD/2+1,0]) rotate([90,0,0]) cylinder(d=LockBall_d, h=10);
	} // difference
} // STB_CT_Section

//STB_CT_Section();

module STB_ShowMyBalls(BT_ID=PML54Body_ID, InLockedPosition=true){
	BallInset=InLockedPosition? LockBall_d/2:LockBall_d/2+3;
	
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,CT_OD/2-BallInset,0]) 
				color("Red") sphere(d=LockBall_d);

} // STB_ShowMyBalls

//STB_ShowMyBalls(InLockedPosition=true);
//STB_ShowMyBalls(InLockedPosition=false);

module STB_ShowLockBearings(BT_ID=PML54Body_ID){
	
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
		translate([0,STB_LockPinBC_d(BT_ID)/2,0]) {
			color("Red") cylinder(d=BearingMR84_ID, h=10+Overlap, center=true);
			color("Blue") cylinder(d=BearingMR84_OD, h=BearingMR84_W, center=true);
		} // for
} // ShowLockBearings

//STB_ShowLockBearings();

module STB_LockDisk(BT_ID=PML54Body_ID, CT_ID=PML54Coupler_ID){

	difference(){
		union(){
			// Hub
			cylinder(d=BearingMR84_OD+6, h=LockDisk_H, center=true);
			
			// Bearing holders
			for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
				cylinder(d=BearingMR84_OD+2, h=LockDisk_H, center=true);
				translate([0,STB_LockPinBC_d(BT_ID)/2,0])
					cylinder(d=BearingMR84_OD-1, h=LockDisk_H, center=true);
				}
				
			// Magnetic latch
			rotate([0,0,15]) translate([Magnet_h/2,0,0])
			hull(){
				cylinder(d=Magnet_h, h=LockDisk_H, center=true);
				translate([0,-STB_LockPinBC_d(BT_ID)/2-2,0])
					cylinder(d=Magnet_h, h=LockDisk_H, center=true);
			}
		} // union
		
		// Magnet
		rotate([0,0,15]) translate([Magnet_h/2,-STB_LockPinBC_d(BT_ID)/2,0])
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_h+Overlap*2, center=true);
		
		// Center Bearings
		cylinder(d=BearingMR84_OD-1, h=LockDisk_H+Overlap*2, center=true);
		translate([0,0,-LockDisk_H/2-Overlap]) 
			cylinder(d=BearingMR84_OD+IDXtra*2, h=BearingMR84_W+Overlap);
		translate([0,0,LockDisk_H/2-BearingMR84_W]) 
			cylinder(d=BearingMR84_OD+IDXtra*2, h=BearingMR84_W+Overlap);
			
		// Lock axles and bearings
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,STB_LockPinBC_d(BT_ID)/2,0]) {
				cylinder(d=BearingMR84_ID+IDXtra, h=LockDisk_H+Overlap*2, center=true);
				cylinder(d=BearingMR84_OD+2, h=BearingMR84_W+1, center=true);
				}
	} // difference
} // STB_LockDisk

//STB_LockDisk();

//rotate([0,0,Unlocked_a]) 
//{ STB_LockDisk(); STB_ShowLockBearings(); }

module STB_ShockCordHolePattern(BT_ID=PML54Body_ID){
	rotate([0,0,-45]){
		translate([0,BT_ID/2-6,0]) children();
		translate([0,10,0]) children();
	}
} // STB_ShockCordHolePattern

//hull() STB_ShockCordHolePattern() cylinder(d=3, h=3);

module STB_BR_BoltPattern(CT_ID=PML54Coupler_ID){
	// Body bolt pattern
	rotate([0,0,13])
	for (j=[0:nLockBalls-1]) {
			rotate([0,0,360/nLockBalls*j+22.5]) translate([0,CT_ID/2-Bolt4Inset,0]) children();
			//rotate([0,0,360/nLockBalls*j-22.5]) translate([0,CT_ID/2-Bolt4Inset,0]) children();
		}
} // STB_BR_BoltPattern

// STB_BR_BoltPattern(CT_ID=PML54Coupler_ID) Bolt4Hole();

module STB_DrillingJig(BT_ID=BT54Body_ID, CT_OD=BT54Coupler_OD){
	// This is a tool for drilling holes in a coupler tube.
	difference(){
		union(){
			translate([0,0,10]) Tube(OD=CT_OD+6, ID=CT_OD-6, Len=4, myfn=$preview? 90:360);
			translate([0,0,-10]) Tube(OD=CT_OD+6, ID=CT_OD+IDXtra*3, Len=24, myfn=$preview? 90:360);
		} // union
	
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			rotate([-90,0,0]) cylinder(d=LockBall_d-2, h=CT_OD);
			
		ManualDisArmingHole(BT_ID=PML54Coupler_OD);
		ManualArmingHole(BT_ID=PML54Body_ID);
	} // difference
	
	
} // STB_DrillingJig

// STB_DrillingJig();

module STB_CoverBoltPattern(BT_ID=PML54Body_ID){
	for (j=[0:1]) rotate([0,0,180*j-53]) translate([0,BT_ID/2-6,0]) children();
} // STB_CoverBoltPattern

// STB_CoverBoltPattern() Bolt4Hole();

module STB_Cover(BT_ID=PML54Body_ID){
	Plate_T=3;
	Cover_h=21;
	BH_Depth=13;
	Lip_h=3;
	
	
	Tube(OD=BT_ID-IDXtra*2, ID=BT_ID-IDXtra*2-4.4, Len=Cover_h+Plate_T, myfn=$preview? 90:360);
	
	// Top
	difference(){
		union(){
			translate([0,0,Cover_h]) cylinder(d=BT_ID-1, h=Plate_T);
			
			STB_CoverBoltPattern(BT_ID=BT_ID) hull(){
				cylinder(d=8, h=Cover_h+Overlap);
				translate([-4.5,4,0]) cube([9,1,Cover_h+Overlap]);
				}
		} // union
		
		// Shock Cord
		rotate([0,0,10])translate([0,0,Cover_h-Overlap]) 
			hull() STB_ShockCordHolePattern() cylinder(d=3, h=Plate_T+Overlap*2);
			
		// Bolts
		translate([0,0,3]) STB_CoverBoltPattern(BT_ID=BT_ID) Bolt4HeadHole(depth=8,lHead=Cover_h+Plate_T);
	} // difference
	
	
	// Skirt, Overlaps into top
	difference(){
		intersection(){
			difference(){
				union(){
					Tube(OD=BT_ID-IDXtra*2-4.4+Overlap, ID=BT_ID-IDXtra*2-4.4-4.4, 
								Len=7, myfn=$preview? 90:360);
					
					translate([0,0,-Lip_h]) 
						Tube(OD=BT_ID-IDXtra*2-4.4-IDXtra, ID=BT_ID-IDXtra*2-4.4-4.4, 
								Len=Lip_h+Overlap, myfn=$preview? 90:360);
					
					
					// Bolt Bosses
					translate([0,0,-Lip_h]) STB_CoverBoltPattern(BT_ID=BT_ID) hull(){
						cylinder(d=8, h=10+Overlap);
						translate([-4.5,4,0]) cube([9,1,10+Overlap]);
						}
				}
			
				translate([0,0,-Lip_h-Overlap])
					Tube(OD=BT_ID, ID=BT_ID-IDXtra*2-4.4, Len=10+Overlap*2, myfn=$preview? 90:360);
				translate([0,0,3]) 
					cylinder(d1=BT_ID-IDXtra*2-4.4-4.4, d2=BT_ID-IDXtra*2-4.4+Overlap, h=4+Overlap);
			} // difference
			
			union(){
				translate([0,0,-Lip_h]) STB_CoverBoltPattern(BT_ID=BT_ID) hull(){
					cylinder(d=8, h=10+Overlap);
					translate([-4.5,4,0]) cube([9,1,10+Overlap]);
					}
					
				translate([-10,0,-Lip_h]) cube([20,BT_ID/2,10]);
				
				rotate([0,0,-68]) translate([-4,0,-Lip_h]) cube([8,BT_ID/2,10]);
				rotate([0,0,-180]) translate([-4,0,-Lip_h]) cube([8,BT_ID/2,10]);
				rotate([0,0,147]) translate([-12,0,-Lip_h]) cube([24,BT_ID/2,10]);
				rotate([0,0,57]) translate([-3,0,-Lip_h]) cube([6,BT_ID/2,10]);
			} // union
		} // intersection
		
		// Bolt holes
		translate([0,0,3]) STB_CoverBoltPattern(BT_ID=BT_ID) Bolt4HeadHole(depth=20);
	} // difference
		
	// Motor Topper Hold Down
	intersection(){
		hull(){
			translate([-4,BT_ID/2-12,4]) cube([8,12,1]);
			translate([-4,BT_ID/2-1,18]) cube([8,1,1]);
		} // hull
		cylinder(d=BT_ID-1, h=20);
	} // intersection
	
	// Battery Hold Down
	intersection(){
		rotate([0,0,57]) translate([0, -BT_ID/2+14.0, 0])
			difference(){
				union(){
					translate([0,0,-10]) SingleBatteryPocket(ShowBattery=false);
					translate([-10,-15,0]) cube([20,5,46]);
					translate([0,0,BH_Depth]) RoundRect(X=30, Y=20, Z=2, R=2);
				} // union
			
				translate([10,10,-Overlap]) cylinder(d1=25, d2=20, h=5);
				translate([10,-5,-Overlap]) cube([10,10,BH_Depth+Overlap]);
			} // difference
			
		cylinder(d=BT_ID-1, h=BH_Depth+2);
	} // intersection
} // STB_Cover

//translate([0,0,40+12.1]) STB_Cover();

module ManualArmingHole(BT_ID=PML54Body_ID){
		rotate([0,0,Unlocked_a]) translate([0,STB_LockPinBC_d(BT_ID)/2,LockDiskHole_H/2-2])
			rotate([0,-90,0]) cylinder(d=2, h=50);
	} // ManualArmingHole
	
//ManualArmingHole();

module STB_BallRetainerTop(BT_ID=PML54Body_ID, CT_ID=PML54Coupler_ID){
	Plate_T=3;
	LockDisk_d=STB_LockPinBC_d(BT_ID)+BearingMR84_OD;
	
	Top_H=LockDiskHole_H/2+Plate_T;
	Skirt_H=40;
	CT_Len=12;
	
	// Bolt bosses to attach cover
	translate([0,0,CT_Len+Skirt_H-5])difference(){
		union(){
			translate([0,0,-8-Overlap]) 
				STB_CoverBoltPattern(BT_ID=BT_ID) hull(){
					cylinder(d=8, h=8);
					translate([-4.5,4,0]) cube([9,1,8]);
				}
			
			STB_CoverBoltPattern(BT_ID=BT_ID) hull(){
				translate([0,0,-8-Overlap])  cylinder(d=8, h=Overlap);
				translate([-4.5,4,-8-Overlap]) cube([9,1,Overlap]);
				translate([0,5,-20])  cylinder(d=1, h=Overlap);
			}
		}
		
		STB_CoverBoltPattern(BT_ID=BT_ID) Bolt4Hole(depth=9);
	}
	
	difference(){
		union(){
			cylinder(d=CT_ID-IDXtra, h=Top_H);
			
			difference(){
				union(){
					Tube(OD=CT_ID-IDXtra, ID=CT_ID-IDXtra-4.4, Len=CT_Len, myfn=$preview? 90:360);
					translate([0,0,10]) cylinder(d=BT_ID-IDXtra*2, h=2, $fn=$preview? 90:360);
					
				} // union
				translate([0,0,10-Overlap]) 
					cylinder(d1=CT_ID-5.4, d2=BT_ID-4.4, h=2+Overlap*2, $fn=$preview? 90:360);
			} // difference
			
			// Skirt
			translate([0,0,CT_Len-Overlap]) 
				Tube(OD=BT_ID-IDXtra*2, ID=BT_ID-IDXtra*2-4.4, Len=Skirt_H+Overlap, myfn=$preview? 90:360);
			
			// Servo Mount
			translate([-10,4,18]) rotate([180,0,-90]) 
				ServoSG90TopBlock(Xtra_Len=0, Xtra_Width=2.4, Xtra_Height=6);
				
		} // union
		
		ManualArmingHole(BT_ID=BT_ID);
		
		// Balls go here
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
			translate([0,BT_ID/2-LockBall_d/2,0]) sphere(d=LockBall_d+IDXtra*3);
			translate([0,CT_ID/2-LockBall_d/2-1,0]) sphere(d=LockBall_d+IDXtra*3);
			translate([0,BT_ID/2-LockBall_d/2,0.3]) sphere(d=LockBall_d+IDXtra*3);
			translate([0,CT_ID/2-LockBall_d/2-1,0.3]) sphere(d=LockBall_d+IDXtra*3);
		}
		
		// Bolt holes
		translate([0,0,Top_H]) STB_BR_BoltPattern(CT_ID=CT_ID) Bolt4HeadHole();
		
		// Shock Cord
		translate([0,0,-Overlap]) 
			hull() STB_ShockCordHolePattern() cylinder(d=3, h=Top_H+Overlap*2);
			
		// Arming slot
		translate([CT_ID/2-12, 0, LockDiskHole_H/2-Overlap]) 
			RoundRect(X=2.2, Y=8, Z=Plate_T+Overlap*2, R=1);
		
		// Lock Disk goes here
		cylinder(d=LockDisk_d+1, h=LockDiskHole_H, center=true);
		
		// Lock disk axle goes here
		cylinder(d=BearingMR84_ID+IDXtra, h=20, center=true);
		
		// Locked stop
		translate([BearingMR84_OD/2+Dowel_d/2,STB_LockPinBC_d(BT_ID)/2,0]) 
			cylinder(d=Dowel_d, h=Top_H*2+Overlap*2,center=true);
			
		// Unlocked Stop
		rotate([0,0,Unlocked_a+120]) 
			translate([-BearingMR84_OD/2-Dowel_d/2,STB_LockPinBC_d(BT_ID)/2,0]) 
				cylinder(d=Dowel_d, h=Top_H*2+Overlap*2, center=true);
		
		// Servo
		translate([-10,4,18]) rotate([180,0,-90]) ServoSG90(TopMount=false,HasGear=false); 
		
		//notch for magnet latch
		rotate([0,0,MagnetPost_a]) translate([-Magnet_h/2,0,0])
			hull(){
				translate([0,-10,0])
					cylinder(d=Magnet_h+IDXtra*4, h=LockDisk_H+4, center=true);
				translate([0,-STB_LockPinBC_d(BT_ID)/2-5,0])
					cylinder(d=Magnet_h+IDXtra*4, h=LockDisk_H+4, center=true);
			}
	} // difference
	
	// Shock cord hole
	difference(){
		hull() STB_ShockCordHolePattern() cylinder(d=5.4, h=Top_H);
		
		translate([0,0,-Overlap])
			hull() STB_ShockCordHolePattern() cylinder(d=3, h=Top_H+Overlap*2);
	} // difference
	
	// Rocket Servo PCB Rails
	RS_PCB_X=15.4;
	translate([0,0,LockDisk_H/2+Plate_T-Overlap])
	intersection(){
		rotate([0,0,90]) translate([0, CT_ID/2-4.5, Skirt_H/2])
			difference(){
				hull(){
					cube([RS_PCB_X+2.4,1,Skirt_H],center=true);
					translate([0,5,0]) cube([RS_PCB_X+7,1,Skirt_H],center=true);
				} // hull
				
				cube([RS_PCB_X-2,8,Skirt_H+Overlap],center=true);
				translate([0,2,0]) cube([RS_PCB_X,3,Skirt_H+Overlap],center=true);
			} // difference
		
		union(){	
			translate([0,0,3-Overlap]) cylinder(d=CT_ID+1, h=Skirt_H);
			cylinder(d=CT_ID-1, h=3);
		}
	} // intersection
	
	// Motor Topper PCB Rails
	MT_PCB_X=26.5;
	MT_PCB_Back_Y=3.5;
	difference(){
		translate([0.5,0,LockDisk_H/2+Plate_T-Overlap])
			intersection(){
				translate([-2, CT_ID/2-7-MT_PCB_Back_Y, Skirt_H/2])
					difference(){
						hull(){
							cube([MT_PCB_X+2.4,1,Skirt_H],center=true);
							translate([0,5,0]) cube([MT_PCB_X+7,2+MT_PCB_Back_Y,Skirt_H],center=true);
						} // hull
						
						translate([0,5,0]) cube([MT_PCB_X-2, 14, Skirt_H+Overlap],center=true);
						translate([0,1.5,0]) cube([MT_PCB_X,2,Skirt_H+Overlap],center=true);
						
						translate([1,5,10]) cube([MT_PCB_X-2, MT_PCB_Back_Y+2, Skirt_H+Overlap],center=true);
					} // difference
		
				union(){	
					translate([0,0,3-Overlap]) cylinder(d=CT_ID+1, h=Skirt_H);
					cylinder(d=CT_ID-1, h=3);
				} // union
			} // intersection
			
		// Shock Cord
		hull() STB_ShockCordHolePattern() cylinder(d=3, h=Top_H+5);
			
		// Bolt holes
		translate([0,0,LockBall_d/2+Plate_T]) STB_BR_BoltPattern(CT_ID=CT_ID) Bolt4HeadHole();
	} // difference
	
	// Battery mount
	intersection(){
		rotate([0,0,57]) translate([0, -CT_ID/2+12.3, 5])
			difference(){
				union(){
					SingleBatteryPocket(ShowBattery=false);
					translate([-10,-15,0]) cube([20,5,46]);
				} // union
				translate([0,0,-Overlap]) cylinder(d=40, h=CT_Len);
				hull(){
					translate([-25,-15,5]) cube([50,30,1]);
					translate([-25,0,30]) cube([50,30,1]);
				} // hull
				translate([-25,0,0]) cube([50,50,50]);
			} // difference
				
			translate([0,0,LockDisk_H/2+Plate_T-Overlap])
				union(){	
					translate([0,0,3-Overlap]) cylinder(d=CT_ID+1, h=Skirt_H);
					cylinder(d=CT_ID-1, h=3);
				} // union
	} // intersection
} // STB_BallRetainerTop

// STB_BallRetainerTop();

module ManualDisArmingHole(BT_ID=BT54Body_ID){
	rotate([0,0,120]) translate([0,STB_LockPinBC_d(BT_ID)/2,-LockDiskHole_H/2+2])
		rotate([0,90,0]) cylinder(d=2, h=50);
} // ManualDisArmingHole

// ManualDisArmingHole();
	
module STB_BallRetainerBottom(BT_ID=BT54Body_ID, CT_ID=PML54Coupler_ID){
	Plate_T=3;
	SpringGroove_H=1.5;
	
	Bottom_H=LockDiskHole_H/2+Plate_T+SpringGroove_H;
	LockDisk_d=STB_LockPinBC_d(BT_ID)+BearingMR84_OD;
	
	echo(Bottom_H=Bottom_H);
	
	difference(){
		translate([0,0,-Bottom_H]) 
			cylinder(d=CT_ID-IDXtra, h=LockDiskHole_H/2+Plate_T+SpringGroove_H);
		
		ManualDisArmingHole(BT_ID=BT_ID);
		
		// Balls go here
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
			translate([0,BT_ID/2-LockBall_d/2,0]) sphere(d=LockBall_d+IDXtra*3);
			translate([0,CT_ID/2-LockBall_d/2-1,0]) sphere(d=LockBall_d+IDXtra*3);
		}
		
		// Bolt holes
		STB_BR_BoltPattern(CT_ID=CT_ID) Bolt4Hole();
		
		// Shock cord hole
		translate([0,0,-Bottom_H-Overlap]) 
			hull() STB_ShockCordHolePattern() cylinder(d=3, h=Bottom_H+Overlap*2);
			
		// Lock Disk goes here
		cylinder(d=LockDisk_d+1, h=LockDiskHole_H, center=true);
		
		// Lock disk axle goes here
		cylinder(d=BearingMR84_ID+IDXtra, h=LockDiskHole_H*2+Overlap*2, center=true);
		
		// Locked stop
		translate([BearingMR84_OD/2+Dowel_d/2, STB_LockPinBC_d(BT_ID)/2, 0]) 
			cylinder(d=Dowel_d, h=Bottom_H*2+Overlap*2,center=true);
			
		// Unlocked Stop
		rotate([0,0,Unlocked_a+120]) 
			translate([-BearingMR84_OD/2-Dowel_d/2,STB_LockPinBC_d(BT_ID)/2,0]) 
				cylinder(d=Dowel_d, h=Bottom_H*2+Overlap*2, center=true);
				
		// Spring Groove
		translate([0,0,-LockDiskHole_H/2-Plate_T-1]) rotate_extrude() hull(){
			translate([ST_DSpring_OD/2-1,0,0]) circle(d=2);
			translate([ST_DSpring_OD/2-1,-1,0]) circle(d=2);
		}
	} // difference
	
	// Shock cord hole
	difference(){
		translate([0,0,-Bottom_H+SpringGroove_H]) 
			hull() STB_ShockCordHolePattern() cylinder(d=5.4, h=Bottom_H-SpringGroove_H);
		translate([0,0,-Bottom_H-Overlap]) 
			hull() STB_ShockCordHolePattern() cylinder(d=3, h=Bottom_H+Overlap*2);
	} // difference
	
	// Magnetic latch
	difference(){
		rotate([0,0,MagnetPost_a]) translate([-Magnet_h/2,0,0])
			hull(){
				translate([0,-10,0])
					cylinder(d=Magnet_h, h=LockDisk_H+2, center=true);
				translate([0,-STB_LockPinBC_d(BT_ID)/2-5,0])
					cylinder(d=Magnet_h, h=LockDisk_H+2, center=true);
			}
			
		// Magnet
		rotate([0,0,MagnetPost_a]) translate([-Magnet_h/2,-STB_LockPinBC_d(BT_ID)/2,0])
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_h+Overlap*2, center=true);
	} // difference
} // STB_BallRetainerBottom

//STB_BallRetainerBottom();



































