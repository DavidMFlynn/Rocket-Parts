// ***********************************
// Project: 3D Printed Rocket
// Filename: TubeCutter.scad
// by David M. Flynn
// Created: 3/12/2023 
// Revision: 0.9.1 12/10/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A tubing cutter for body and coupler tubes from 29mm to 150mm
//
//  ***** History *****
//
// 0.9.1 12/10/2023   Stiffer frame.
// 0.9.0  3/12/2023   First code.
//
// ***********************************
//  ***** for STL output *****
//
// TubeRoller();
// RollerFrame();
//
// DremelRACover();
// DremelRAHolder();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRollers();
// 
// ***********************************

//include<TubesLib.scad>
include<involute_gears.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

BearingR8_OD=1.125*25.4;
BearingR8_ID=0.5*25.4;
BearingR8_W=5/16*25.4;

module DremelRAHead(){
	rotate([90,0,0]){
		cylinder(d=23, h=28);
		translate([0,0,28-Overlap]) cylinder(d=25, h=40);
		hull(){
			cylinder(d=23, h=11);
			translate([0,0,11.5+2.0]) rotate([0,90,0]) cylinder(d=23, h=50);
			translate([0,0,11.5+5.5]) rotate([0,90,0]) cylinder(d=23, h=50);
		} // hull
	} // rotate
} // DremelRAHead

//DremelRAHead();

Bolt6Inset=5;
Base_X=65;
BaseOffset_X=5;
Base_Y=50;
Base_H=50;
DRA_Clamp_X=Base_X-10;

module DremelBaseBoltPattern(){
	translate([(Base_X/2-Bolt6Inset),0,0]) children();
	translate([-(Base_X/2-Bolt6Inset),0,0]) children();
	translate([(Base_X/2-Bolt6Inset),(Base_Y/2-Bolt6Inset),0]) children();
	translate([-(Base_X/2-Bolt6Inset),(Base_Y/2-Bolt6Inset),0]) children();
	translate([(Base_X/2-Bolt6Inset),-(Base_Y/2-Bolt6Inset),0]) children();
	translate([-(Base_X/2-Bolt6Inset),-(Base_Y/2-Bolt6Inset),0]) children();
} // DremelBaseBoltPattern

module DremelRAHolderBoltPattern(){
	translate([(DRA_Clamp_X/2-Bolt6Inset),-20,0]) children();
	translate([-(DRA_Clamp_X/2-Bolt6Inset),-20,0]) children();
	translate([(DRA_Clamp_X/2-Bolt6Inset),20,0]) children();
	translate([-(DRA_Clamp_X/2-Bolt6Inset),20,0]) children();
} // DremelRAHolderBoltPattern

module DremelBase(){
	BasePlate_t=10;
	LeftGuide_X=75;
	Guide_X=20;
	Guide_Y=120;
	Guide_t=6;
	
	difference(){
		union(){
			rotate([0,0,90]) translate([-Base_X/2, -Base_Y/2, 0]) cube([Base_X, Base_Y, BasePlate_t]);
			translate([0, -Base_Y/2, 0]) RoundRect(X=Base_X+10, Y=Base_Y*2+20, Z=Guide_t, R=5);
			
			translate([-Base_X/2-LeftGuide_X, -Base_Y/2, 0]) cube([Guide_X, Guide_Y, Guide_t]);
			
			
			hull(){
				cylinder(d=20, h=Guide_t);
				translate([-Base_X/2-LeftGuide_X+10, -Base_Y/2+Guide_Y-10, 0]) cylinder(d=20, h=Guide_t);
			} // hull
			
			hull(){
				translate([0,-10,0]) cylinder(d=20, h=Guide_t);
				translate([-Base_X/2-LeftGuide_X+10, -Base_Y/2+10, 0]) cylinder(d=20, h=Guide_t);
			} // hull
		} // union
	
		rotate([0,0,90]) DremelBaseBoltPattern() rotate([180,0,0]) Bolt6HeadHole();
	} // difference
} // DremelBase

//DremelBase();

module DremelRACover(){
	Cover_H=15;
	
	difference(){
		hull(){
			translate([-DRA_Clamp_X/2,-Base_Y/2,0]) cube([DRA_Clamp_X,Base_Y,1]);
			translate([-DRA_Clamp_X/2+2,-Base_Y/2,Cover_H-1]) cube([DRA_Clamp_X-4,Base_Y,1]);
		} // hull
		
		difference(){
			translate([-DRA_Clamp_X/2-Overlap, -Base_Y/2-Overlap,5])
				cube([DRA_Clamp_X/2, Base_Y+Overlap*2, Cover_H+Overlap*2]);
				
			
			hull(){
				translate([-DRA_Clamp_X/2+Cover_H+5,0,-5]) 
					rotate([90,0,0]) cylinder(r=Cover_H+5, h=Base_Y+Overlap*4, center=true);
				translate([-DRA_Clamp_X/2-Overlap*2, -Base_Y/2-Overlap*2,0]) 
					cube([1, Base_Y+Overlap*4, 3]);
				translate([-DRA_Clamp_X/2+30,0,0])
					rotate([90,0,0]) cylinder(r=Cover_H, h=Base_Y+Overlap*4, center=true);}
		} // difference
		
		translate([-BaseOffset_X,12,0]) DremelRAHead();
		
		DremelRAHolderBoltPattern() translate([0,0,8]) Bolt6HeadHole();
	} // difference
} // DremelRACover

//DremelRACover();

module DremelRAHolder(){
	module LighteningHole(){
		hull(){
			translate([0,0,10]) rotate([0,90,0]) cylinder(d=10, h=Base_X+1, center=true);
			translate([0,0,30]) rotate([0,90,0]) cylinder(d=10, h=Base_X+1, center=true);
		}
	} // LighteningHole
	
	difference(){
		hull(){
			translate([-Base_X/2,-Base_Y/2,0]) cube([Base_X,Base_Y,1]);
			translate([-DRA_Clamp_X/2,-Base_Y/2,Base_H-1]) cube([DRA_Clamp_X,Base_Y,1]);
		} // hull
		
		translate([-BaseOffset_X,12,Base_H]) DremelRAHead();
		
		translate([0,10,0]) LighteningHole();
		translate([0,-10,0]) LighteningHole();
		
		DremelBaseBoltPattern() rotate([180,0,0]) Bolt6Hole();
		DremelRAHolderBoltPattern() translate([0,0,Base_H]) Bolt6Hole();
	} // difference
} // DremelRAHolder

//translate([90,60,0]) DremelRAHolder();

module ShowRollers(){
	rotate([90,0,0]) RollerFrame();
	translate([0,25,50]) rotate([90,0,0]) TubeRoller();
	translate([90,25,50]) rotate([90,0,0]) TubeRoller();
	translate([0,-25,50]) rotate([90,0,0]) TubeRoller();
	translate([90,-25,50]) rotate([90,0,0]) TubeRoller();
} // ShowRollers

//ShowRollers();

module TubeRoller(){
	Roller_W=24;
	RollerHub_W=24;
	Roller_d=80;
	RollerRimWall_t=1.6;
	RollerSpoke_t=1.2;
	nSpokes=5;
	
	// hub
	difference(){
		cylinder(d=BearingR8_OD+6, h=RollerHub_W);
		
		cylinder(d=BearingR8_OD-1, h=RollerHub_W);
		
		translate([0,0,-Overlap]) 
			cylinder(d=BearingR8_OD+IDXtra*2, h=BearingR8_W+0.5);
		
		translate([0,0,RollerHub_W-BearingR8_W-0.5]) 
			cylinder(d=BearingR8_OD+IDXtra*2, h=BearingR8_W+0.5+Overlap);
	} // difference

	// spokes
	for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j]) hull(){
		translate([0,BearingR8_OD/2+3-Overlap,0]) 
			cylinder(d=RollerSpoke_t, h=RollerHub_W);
		translate([0,Roller_d/2-RollerRimWall_t+Overlap,0]) cylinder(d=RollerSpoke_t, h=Roller_W);}
	
	// rim
	difference(){
		cylinder(d=Roller_d, h=Roller_W);
		
		translate([0,0,-Overlap]) cylinder(d=Roller_d-RollerRimWall_t*2, h=Roller_W+Overlap*2);
	} // difference
} // TubeRoller

//TubeRoller(); translate([90,0,0]) TubeRoller(); translate([45,70,0]) TubeRoller();

module RollerFrame(){
	Frame_W=24;
	Deck_t=8;
	Deck_Len=140;
	
	difference(){
		union(){
			translate([0,50,0]) cylinder(d=BearingR8_ID+6, h=Frame_W);
			translate([90,50,0]) cylinder(d=BearingR8_ID+6, h=Frame_W);
			
			hull(){
				translate([0,50,0]) cylinder(d=3, h=Frame_W);
				translate([30,0,0]) cylinder(d=3, h=Frame_W);
			} // hull
			
			hull(){
				translate([0,50,0]) cylinder(d=3, h=Frame_W);
				translate([-8,0,0]) cylinder(d=3, h=Frame_W);
			} // hull
			
			hull(){
				translate([90,50,0]) cylinder(d=3, h=Frame_W);
				translate([60,0,0]) cylinder(d=3, h=Frame_W);
			} // hull
			
			hull(){
				translate([90,50,0]) cylinder(d=3, h=Frame_W);
				translate([98,0,0]) cylinder(d=3, h=Frame_W);
			} // hull
			
			hull(){
				translate([90,50,0]) cylinder(d=3, h=Frame_W);
				translate([0,50,0]) cylinder(d=3, h=Frame_W);
			} // hull
			
			// Deck plate
			hull(){
				translate([45-Deck_Len/2,0,0]) cylinder(d=Deck_t, h=Frame_W);
				translate([45+Deck_Len/2,0,0]) cylinder(d=Deck_t, h=Frame_W);
			} // hull
		} // union
		
		translate([0,50,-Overlap]) cylinder(d=BearingR8_ID+IDXtra*2, h=Frame_W+Overlap*2);
		translate([90,50,-Overlap]) cylinder(d=BearingR8_ID+IDXtra*2, h=Frame_W+Overlap*2);
		
		// mounting bolts
		translate([45-Deck_Len/2+10,-Deck_t/2,Frame_W/2]) rotate([90,0,0]) Bolt10ClearHole();
		translate([45+Deck_Len/2-10,-Deck_t/2,Frame_W/2]) rotate([90,0,0]) Bolt10ClearHole();
		
	} // difference
} // RollerFrame

//RollerFrame();

Gear_Pitch=320;
nDriveGearTeeth=40;
nRollerGearTeeth=44;
Gear_W=9;

module RollerSuport(){
	
	difference(){
		union(){
			cylinder(d=BearingR8_OD+6, h=BearingR8_W+2);
			translate([0,0,Gear_W-Overlap]) cylinder(d=22, h=8);
			
		} // union
		cylinder(d=12.7+IDXtra*3, h=30);
		translate([0,0,-Overlap]) cylinder(d=BearingR8_OD+IDXtra*2, h=BearingR8_W+Overlap);
	} // difference
} // RollerSuport

//RollerSuport();

module RollerGear(){
	difference(){
		gear (
			number_of_teeth=nRollerGearTeeth,
			circular_pitch=Gear_Pitch, diametral_pitch=false,
			pressure_angle=20,
			clearance = 0.2,
			gear_thickness=Gear_W,
			rim_thickness=Gear_W,
			rim_width=3,
			hub_thickness=Gear_W,
			hub_diameter=BearingR8_OD+6,
			bore_diameter=BearingR8_OD-1,
			circles=0,
			backlash=0.1,
			twist=0,
			involute_facets=0,
			flat=false);
			
		translate([0,0,-Overlap]) cylinder(d=BearingR8_OD+IDXtra*2, h=BearingR8_W+Overlap);
		//translate([0,0,IdleGear_W-BearingR8_W]) 
		//	cylinder(d=BearingR8_OD+IDXtra*2, h=BearingR8_W+Overlap);
	} // difference
	
	difference(){
		union(){
			translate([0,0,Gear_W-Overlap]) cylinder(d=22, h=8);
			translate([0,0,BearingR8_W]) cylinder(d=40, h=2);
		} // union
		cylinder(d=12.7+IDXtra*3, h=30);
	} // difference
} // RollerGear

// RollerGear();

module DriveGear(){
	difference(){
		gear (
			number_of_teeth=nDriveGearTeeth,
			circular_pitch=Gear_Pitch, diametral_pitch=false,
			pressure_angle=20,
			clearance = 0.2,
			gear_thickness=Gear_W,
			rim_thickness=Gear_W,
			rim_width=10,
			hub_thickness=Gear_W*2,
			hub_diameter=12.7+10,
			bore_diameter=12.7+IDXtra,
			circles=0,
			backlash=0.1,
			twist=0,
			involute_facets=0,
			flat=false);
			
		// Setscrews
		translate([0,0,Gear_W*1.5]){
			rotate([90,0,0]) Bolt8Hole();
			rotate([90,0,90]) Bolt8Hole();
		}
	} // difference
} // DriveGear

//DriveGear();

//nDriveGearTeeth=40;

module TowerTop(){
	Base_X=50;
	Base_Y=50;
	Base_Z=25;
	AlTube_d=12.7;
	
	module BasePattern(N=0){
		if (N==0 || N==1) translate([-Base_X, Base_Y, 0]) children();
		if (N==0 || N==2) translate([Base_X, Base_Y, 0]) children();
		if (N==0 || N==3) translate([0, 0, 0]) children();
	}
	
	module BearingMount(){
	
			translate([12,-17,(BearingR8_OD+6)/2]) 
				rotate([0,90,0])
					cylinder(d=BearingR8_OD+6, h=BearingR8_W+2);
					
			hull(){
				translate([19,Base_Y,0]) cube([3,1,Base_Z]);
				translate([19,-17,(BearingR8_OD+6)/2]) 
					rotate([0,90,0]) cylinder(d=BearingR8_OD+6, h=3);
			}
			}
			
	
	difference(){
		union(){
			BasePattern() cylinder(d=AlTube_d+6, h=Base_Z);
			
			translate([0,-17,(BearingR8_OD+6)/2]) 
				rotate([0,90,0])
					cylinder(d=BearingR8_OD+6, h=25, center=true);
					
			BearingMount();
			mirror([1,0,0]) BearingMount();
			
			//hull() BasePattern() cylinder(d=20, h=6);
			hull(){
				BasePattern(1) cylinder(d=3, h=Base_Z);
				BasePattern(2) cylinder(d=3, h=Base_Z);
				}
			hull(){
				BasePattern(2) cylinder(d=3, h=Base_Z);
				BasePattern(3) cylinder(d=3, h=Base_Z);
				}
			hull(){
				BasePattern(1) cylinder(d=3, h=Base_Z);
				BasePattern(3) cylinder(d=3, h=Base_Z);
				}
		} // union
		
		// Bearing hole
		translate([0,-17,(BearingR8_OD+6)/2]){
			rotate([0,90,0]) cylinder(d=AlTube_d+8, h=50, center=true);
			translate([14,0,0]) rotate([0,90,0]) cylinder(d=BearingR8_OD+IDXtra*2, h=BearingR8_W+1);
			translate([12-Overlap,0,0]) rotate([0,90,0]) cylinder(d=BearingR8_OD-1, h=BearingR8_W+1);
			translate([-14,0,0]) rotate([0,-90,0]) cylinder(d=BearingR8_OD+IDXtra*2, h=BearingR8_W+1);
			translate([-12+Overlap,0,0]) rotate([0,-90,0]) cylinder(d=BearingR8_OD-1, h=BearingR8_W+1);
		}
		
		
		translate([0,0,-Overlap]) BasePattern() cylinder(d=AlTube_d+IDXtra, h=10+Base_Z+Overlap*2);
		//translate([0,0,6]) BasePattern() Bolt8ButtonHeadHole();
	} // difference
} // TowerTop

//TowerTop();

module TowerPivit(){
	AlTube_d=12.7;
	
	difference(){
		union(){
			translate([34,0,0]) rotate([0,90,0]) cylinder(d=AlTube_d+6, h=20, center=true);
			translate([-34,0,0]) rotate([0,90,0]) cylinder(d=AlTube_d+6, h=20, center=true);
			translate([34,-15,0]) rotate([90,0,0]) cylinder(d=AlTube_d+6, h=30, center=true);
			translate([-34,-15,0]) rotate([90,0,0]) cylinder(d=AlTube_d+6, h=30, center=true);
			hull(){
				translate([34,-25,0]) rotate([90,0,0]) cylinder(d=AlTube_d+6, h=10, center=true);
				translate([-34,-25,0]) rotate([90,0,0]) cylinder(d=AlTube_d+6, h=10, center=true);
			} // hull
		} // union
	
		rotate([0,90,0]) cylinder(d=AlTube_d+IDXtra, h=120, center=true);
		
		translate([34,-25,0]) rotate([90,0,0]) cylinder(d=AlTube_d+IDXtra, h=30, center=true);
		translate([-34,-25,0]) rotate([90,0,0]) cylinder(d=AlTube_d+IDXtra, h=30, center=true);
	} // difference
} // TowerPivit

//translate([0,-17,(BearingR8_OD+6)/2]) TowerPivit();
/*
translate([23,-200,56]) rotate([0,90,0]) rotate([0,0,15]){
 DriveRollerMount();
 DriveMount();}
/**/

module TowerBase(){
	Base_X=50;
	Base_Y=50;
	Base_Z=25;
	AlTube_d=12.7;
	
	module BasePattern(N=0){
		if (N==0 || N==1) translate([-Base_X, Base_Y, 0]) children();
		if (N==0 || N==2) translate([Base_X, Base_Y, 0]) children();
		if (N==0 || N==3) translate([0, 0, 0]) children();
	}
	
	difference(){
		union(){
			BasePattern() cylinder(d=AlTube_d+6, h=Base_Z);
			hull() BasePattern() cylinder(d=20, h=6);
			hull(){
				BasePattern(1) cylinder(d=6, h=Base_Z);
				BasePattern(2) cylinder(d=6, h=Base_Z);
				}
			hull(){
				BasePattern(2) cylinder(d=6, h=Base_Z);
				BasePattern(3) cylinder(d=6, h=Base_Z);
				}
			hull(){
				BasePattern(1) cylinder(d=6, h=Base_Z);
				BasePattern(3) cylinder(d=6, h=Base_Z);
				}
		} // union
		
		translate([0,0,6]) BasePattern() cylinder(d=AlTube_d+IDXtra, h=Base_Z);
		translate([0,0,6]) BasePattern() Bolt8ButtonHeadHole();
	} // difference
} // TowerBase

//TowerBase();

function DriveGearOffset()=GetPitch_Radius(nDriveGearTeeth, Gear_Pitch)+
							GetPitch_Radius(20, Gear_Pitch);
							
module DriveRollerMount(){
	AlTube_d=12.7;
	
	RollerGearOffset=GetPitch_Radius(nDriveGearTeeth, Gear_Pitch)+GetPitch_Radius(nRollerGearTeeth, Gear_Pitch);
	
	difference(){
		union(){
			translate([0,DriveGearOffset(),0]) rotate([0,0,30]) translate([0,-RollerGearOffset,0])
				cylinder(d=AlTube_d+8, h=20);
				
			translate([0,DriveGearOffset(),0]) rotate([0,0,120]) translate([0,-RollerGearOffset,0]){
				cylinder(d=AlTube_d+8, h=20);
				
				rotate([0,0,-135]) translate([0,0,20-(AlTube_d+6)/2]) 
					rotate([-90,0,0]) cylinder(d=AlTube_d+6, h=30);
					
				rotate([0,0,-135]) translate([0,0,20-(AlTube_d+6)/2-68]) 
					rotate([-90,0,0]) cylinder(d=AlTube_d+6, h=30);
					
				
				hull(){
						
					rotate([0,0,-135]) translate([0,30,20-(AlTube_d+6)/2]) 
						rotate([-90,0,0]) cylinder(d=AlTube_d+6, h=3);
					
					rotate([0,0,-135]) translate([0,30,20-(AlTube_d+6)/2-68]) 
						rotate([-90,0,0]) cylinder(d=AlTube_d+6, h=3);
				}
				
				hull(){
					rotate([0,0,-135]) translate([0,-105,6]) 
						cube([AlTube_d+6,Overlap,3], center=true); //cylinder(d=AlTube_d+6, h=3);
						
					rotate([0,0,-135]) translate([0,0,20-(AlTube_d+6)/2-68]) 
						cube([AlTube_d+6,Overlap,3], center=true); //cylinder(d=AlTube_d+6, h=3);
				}
				hull(){
					
					rotate([0,0,-135]) translate([0,-95,0]) 
						cylinder(d=3, h=20);
						
					rotate([0,0,-135]) translate([0,0,20-(AlTube_d+6)/2]) 
						rotate([-90,0,0]) cylinder(d=3, h=30);
					
					rotate([0,0,-135]) translate([0,0,20-(AlTube_d+6)/2-68]) 
						rotate([-90,0,0]) cylinder(d=3, h=30);
				}
				
			}
				
			translate([0,0,10]) hull(){
				DriveMountBoltPattern() cylinder(d=12, h=10);
				translate([0,DriveGearOffset(),0]) rotate([0,0,30])
					translate([0,-RollerGearOffset,0]) cylinder(d=12.7+8, h=10);
			} // hull
			
			translate([0,0,10]) hull(){
				translate([0,DriveGearOffset(),0]) rotate([0,0,30])
					translate([0,-RollerGearOffset,0]) cylinder(d=12.7+8, h=10);
			
				translate([0,DriveGearOffset(),0]) rotate([0,0,120])
					translate([0,-RollerGearOffset,0]) cylinder(d=12.7+8, h=10);
			} // hull
			
			hull(){
				translate([0,DriveGearOffset(),0]) rotate([0,0,30])
					translate([0,-RollerGearOffset,0]) cylinder(d=8, h=20);
			
				translate([0,DriveGearOffset(),0]) rotate([0,0,120])
					translate([0,-RollerGearOffset,0]) cylinder(d=8, h=20);
			} // hull
		} // union
	
	
		translate([0,0,20]) DriveMountBoltPattern() Bolt8Hole();
		
		translate([0,DriveGearOffset(),-Overlap]) rotate([0,0,30]) 
			translate([0,-RollerGearOffset,0])
				cylinder(d=12.7+IDXtra, h=20+Overlap*2);
				
		translate([0,DriveGearOffset(),-Overlap]) rotate([0,0,120])
			translate([0,-RollerGearOffset,0]){
				cylinder(d=12.7+IDXtra, h=20+Overlap*2);
				
				rotate([0,0,-135]) translate([0,7,20-(AlTube_d+6)/2]) 
					rotate([-90,0,0]) cylinder(d=AlTube_d+IDXtra, h=40);
					
				rotate([0,0,-135]) translate([0,7,20-(AlTube_d+6)/2-68]) 
					rotate([-90,0,0]) cylinder(d=AlTube_d+IDXtra, h=40);
					}
			
	} // difference
} // DriveRollerMount

//rotate([180,0,0]) DriveRollerMount();

module DriveMountBoltPattern(){
	translate([20,0,0]) children();
	translate([-20,0,0]) children();
	translate([0,-20,0]) children();
} // DriveMountBoltPattern

module DriveMount(){
	// Borrowed from braiding machine
	DM_Base_h=10;
	BeltPulleySpacing=67;
	MotorBC_d=22.5;
	MotorFace_d=32;
	MotorPlate_h=12;
	
	difference(){
		union(){
			hull(){
				cylinder(d=BearingR8_OD, h=DM_Base_h);
				translate([20,0,0]) cylinder(d=12, h=DM_Base_h);
				translate([-20,0,0]) cylinder(d=12, h=DM_Base_h);
				translate([0,10,DM_Base_h/2]) cube([50,1,DM_Base_h],center=true);
			} // hull
			hull(){
				cylinder(d=BearingR8_OD, h=DM_Base_h);
				translate([0,-20,0]) cylinder(d=12, h=DM_Base_h);
			} // hull
			hull(){
				translate([0,12,DM_Base_h+Overlap]) cube([50,4,DM_Base_h*2+Overlap*2],center=true);
				translate([0,DriveGearOffset(),0])
					cylinder(d=BearingR8_OD+6, h=DM_Base_h*2);
		
			} // hull
			
			hull(){
				translate([0,12,MotorPlate_h/2]) cube([50,4,MotorPlate_h],center=true);
				translate([0,DriveGearOffset(),0]){
					cylinder(d=BearingR8_OD+6, h=MotorPlate_h);
					rotate([0,0,15])
						translate([-BeltPulleySpacing,0,0]) 
							cylinder(d=MotorFace_d+6, h=MotorPlate_h);
					}
			} // hull
				
		} // union
	
		translate([0,0,DM_Base_h]) cylinder(d=BearingR8_OD+IDXtra*2, h=DM_Base_h+Overlap);
		DriveMountBoltPattern() rotate([180,0,0]) Bolt8HeadHole();
		
		
		translate([0,DriveGearOffset(),-Overlap]){
			cylinder(d=BearingR8_OD-1, h=DM_Base_h*2+Overlap*2);
			cylinder(d=BearingR8_OD+IDXtra*2, h=BearingR8_W+Overlap);
			translate([0,0,DM_Base_h*2-BearingR8_W]) 
				cylinder(d=BearingR8_OD+IDXtra*2, h=BearingR8_W+Overlap*4);
			}
		
		// motor
		translate([0,DriveGearOffset(),0]) rotate([0,0,15]) translate([-BeltPulleySpacing,0,0]) {
			for (j=[0:3]) rotate([0,0,90*j]) translate([0,MotorBC_d/2,0])
				rotate([180,0,0]) Bolt8ButtonHeadHole();
			translate([0,0,MotorPlate_h-4]) cylinder(d=MotorFace_d, h=MotorPlate_h);
			translate([0,0,-Overlap]) cylinder(d=7, h=MotorPlate_h+Overlap*2);
		}
	} // difference
	
	if ($preview) translate([0,DriveGearOffset(),DM_Base_h*2+0.1]) DriveGear();
} // DriveMount

//DriveMount();









































