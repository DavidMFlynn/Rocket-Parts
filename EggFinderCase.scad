// ***********************************
// Project: 3D Printed Rocket
// Filename: EggFinderCase.scad
// by David M. Flynn
// Created: 8/21/2023 
// Revision: 1.0.0  8/21/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  ***** History *****
//
// 1.0.0  8/21/2023  First Code.
//
// ***********************************
//  ***** for STL output *****
//
// CaseFront();
// CaseSides(IncludeBackLightSwitch=false);
// CaseBack(Name="Dave Flynn", Phone="(626) 893-6654");
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// CaseFront();
// translate([0,0,-24]) CaseSides();
// translate([0,0,-22]) CaseBack();
//
// ***********************************
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Batt_X=35.5;
Batt_Y=51;
Batt_Z=23.3;


Bolt4Inset=4;
Case_X=110;
Case_Y=120;
Case_R=5;
CaseWall_t=1.8;
Face_t=4;
Face_Z=Case_R+3;
CaseBoltInset=Case_R+Bolt4Inset;

	
module MainPCBHolePattern(){
	Holes_X=75;
	Holes_Y=31;
	
	translate([-Holes_X/2, Holes_Y/2, 0]) children();
	translate([Holes_X/2, Holes_Y/2, 0]) children();
	translate([-Holes_X/2, -Holes_Y/2, 0]) children();
	translate([Holes_X/2, -Holes_Y/2, 0]) children();
} // MainPCBHolePattern

//MainPCBHolePattern() Bolt4Hole();

module LCD_Hole(){
	PCB_X=80;
	PCB_Y=36;
	Offset_Y=0;
	LCD_X=71.2;
	LCD_Y=24.4;
	LCD_Z=7;
	LCD_Offset_Y=-(PCB_Y-31)/2+1.5;
	
	translate([-(LCD_X+IDXtra*3)/2, LCD_Offset_Y-LCD_Y/2, 0]) cube([LCD_X+IDXtra*3, LCD_Y+IDXtra*3, 20]);
} // LCD_Hole

// LCD_Hole();

module LCD_PCB(){
	PCB_X=80;
	PCB_Y=36;
	Offset_Y=0;
	
	LCD_X=71.2;
	LCD_Y=24.4;
	LCD_Z=7;
	LCD_Offset_Y=-(PCB_Y-31)/2+2;
	
	translate([-LCD_X/2, LCD_Offset_Y-LCD_Y/2, 0]) cube([LCD_X, LCD_Y, LCD_Z]);
	difference(){
		translate([-PCB_X/2, Offset_Y-PCB_Y/2,-1.6]) cube([PCB_X, PCB_Y, 1.6]);
		MainPCBHolePattern() Bolt4ClearHole();
	} // difference
} // LCD_PCB

//LCD_PCB();

module MainPCB(){

	PCB_X=82;
	PCB_Y=52;
	
	Offset_Y=-(PCB_Y-31)/2+2.5; // Align to center of display PCB.
	
	translate([PCB_X/2-13.5, Offset_Y+PCB_Y/2+1, 0.5]){
		cube([6.35,2,6.35],center=true);
		rotate([-90,0,0]) cylinder(d=6.35, h=10);
	}
		
	difference(){
		translate([-PCB_X/2, Offset_Y-PCB_Y/2,-1.6]) cube([PCB_X, PCB_Y, 1.6]);
		MainPCBHolePattern() Bolt4ClearHole();
	} // difference
} // MainPCB

//MainPCB();

module GPS_HolePattern(){
	Hole_X=37;
	Hole_Y=16.2;
	
	translate([-Hole_X/2, Hole_Y/2, 0]) children();
	translate([Hole_X/2, Hole_Y/2, 0]) children();
	translate([-Hole_X/2, -Hole_Y/2, 0]) children();
	translate([Hole_X/2, -Hole_Y/2, 0]) children();

} // GPS_HolePattern

module GPS_LEDHole(){
	Hole_X=37;
	Hole_Y=16.2;

	// LED hole
	translate([Hole_X/2-10.5, -Hole_Y/2, 0]) cylinder(d=3, h=20);
} // GPS_LEDHole

//GPS_HolePattern() Bolt4Hole();

module GPS_PCB(){
	Hole_X=37;
	Hole_Y=16.2;
	
	PCB_X=42;
	PCB_Y=21.5;
	
	difference(){
		translate([-PCB_X/2, -PCB_Y/2, -1.6]) cube([PCB_X, PCB_Y, 1.6]);
		
		GPS_HolePattern() Bolt4ClearHole();
	} // difference
	
	// GPS
	translate([-5,0,3.25]) cube([18,18,6.5], center=true);
	// LED
	translate([Hole_X/2-10.5, -Hole_Y/2, 0]) cylinder(d=3, h=4);
} // GPS_PCB

//GPS_PCB();

module VoiceHolePattern(){
	Hole_X=42.2;
	Hole_X2=24.5;
	Hole_Y=27;
	
	translate([Hole_X/2, Hole_Y/2, 0]) children();
	translate([Hole_X2/2, -Hole_Y/2, 0]) children();
	translate([-Hole_X/2, Hole_Y/2, 0]) children();
	translate([-Hole_X2/2, -Hole_Y/2, 0]) children();
} // VoiceHolePattern

module VoiceJackHole(){
	PCB_X=47.6;
	PCB_Y=32;
	
	translate([-PCB_X/2+11.5, PCB_Y/2-19, 0]) cylinder(d=6.35+IDXtra, h=12);
	translate([-PCB_X/2+11.5, PCB_Y/2-19, 10.5]) cylinder(d=10, h=10);
} // VoiceJackHole

//VoiceJackHole();

module VoicePCB(){
	PCB_X=47.6;
	PCB_Y=32;
	
	translate([-PCB_X/2+11.5, PCB_Y/2-19, 0]) cylinder(d=6.35, h=12);
	difference(){
		translate([-PCB_X/2, -PCB_Y/2, -1.6]) cube([PCB_X, PCB_Y, 1.6]);
		VoiceHolePattern() Bolt4ClearHole();
	} // difference
} // VoicePCB

//VoicePCB();

module Battery(){
	
	
	cube([Batt_X, Batt_Y, Batt_Z], center=true);
	
} // Battery

//Battery();

	
module CaseBoltPattern(){
	translate([Case_X/2-CaseBoltInset, Case_Y/2-CaseBoltInset, 0]) children();
	translate([Case_X/2-CaseBoltInset, -Case_Y/2+CaseBoltInset, 0]) children();
	translate([-Case_X/2+CaseBoltInset, Case_Y/2-CaseBoltInset, 0]) children();
	translate([-Case_X/2+CaseBoltInset, -Case_Y/2+CaseBoltInset, 0]) children();
} // CaseBoltPattern

//CaseBoltPattern();

module FaceBoltBoss(H=7){
	translate([0,0,Face_Z-H]) children();
} // FaceBoltBoss

module CaseFace(Standoff_Len=Face_Z){
	difference(){
		union(){
			difference(){
				hull(){
					RoundRect(X=Case_X, Y=Case_Y, Z=1, R=Case_R);
					
					translate([Case_X/2-Case_R, Case_Y/2-Case_R, Face_Z-Case_R]) sphere(r=Case_R);
					translate([Case_X/2-Case_R, -Case_Y/2+Case_R, Face_Z-Case_R]) sphere(r=Case_R);
					translate([-Case_X/2+Case_R, Case_Y/2-Case_R, Face_Z-Case_R]) sphere(r=Case_R);
					translate([-Case_X/2+Case_R, -Case_Y/2+Case_R, Face_Z-Case_R]) sphere(r=Case_R);
				} // hull
		
				rotate([180,0,0]) RoundRect(X=Case_X+Overlap, Y=Case_Y+Overlap, Z=10, R=Case_R+Overlap/2);
				
				translate([0,0,-Overlap]) 
					RoundRect(X=Case_X-CaseWall_t*4, Y=Case_Y-CaseWall_t*4, 
								Z=Face_Z-Face_t, R=Case_R-CaseWall_t);
			
				difference(){
					translate([0,0,-Overlap]) RoundRect(X=Case_X+Overlap, Y=Case_Y+Overlap, Z=2, R=Case_R);
					translate([0,0,-Overlap*2]) 
						RoundRect(X=Case_X-CaseWall_t*2, Y=Case_Y-CaseWall_t*2, 
									Z=2+Overlap*4, R=Case_R-CaseWall_t);
				} // difference
			
			} // difference
			
			translate([0,0,Face_Z-Standoff_Len]) CaseBoltPattern() cylinder(r=Bolt4Inset, h=Standoff_Len-1);
			
		} // union
		
		translate([0,0,Face_Z]) CaseBoltPattern() Bolt4ButtonHeadHole();

	} // difference
	
} // CaseFace

//CaseFace();

module CaseBack(Name="Dave Flynn", Phone="(626) 893-6654"){
	
	difference(){
		union(){
			rotate([180,0,0]) CaseFace(Standoff_Len=Face_Z-3);
			
			// Battery cage
			translate([-22,-28,-Face_Z+Face_t-Overlap+Batt_Z/2])
				difference(){
					cube([Batt_X+4,Batt_Y+4,Batt_Z], center=true);
					
					cube([Batt_X,Batt_Y,Batt_Z+1], center=true);
				} // difference
		} // union
		
		translate([15,-28,-Face_Z]) rotate([0,180,0]){
			linear_extrude(2,center=true) text(Name, size=8, halign="center", valign="center");
			translate([0,-12,0])
			linear_extrude(2,center=true) text(Phone, size=6, halign="center", valign="center");
			}
	} // difference
} // CaseBack

// translate([0,0,-22]) CaseBack();

module CaseFront(){
	MainPCB_Loc_X=0;
	MainPCB_Loc_Y=Case_Y/2-15.5-CaseWall_t*2-5;
	MainPCB_Z=7;
	Antenna_Z=MainPCB_Z+12.5;
	GPSPCB_Loc_X=20;
	GPSPCB_Loc_Y=-40;
	GPSPCB_Z=13;
	VoicePCB_Loc_X=25;
	VoicePCB_Loc_Y=-7;
	VoicePCB_Z=9+Face_t;
	
	difference(){
		union(){
			CaseFace();
			
			translate([MainPCB_Loc_X, MainPCB_Loc_Y, 0])
				MainPCBHolePattern() FaceBoltBoss(H=MainPCB_Z) cylinder(d=6, h=MainPCB_Z-1);
				
			translate([GPSPCB_Loc_X, GPSPCB_Loc_Y, 0])
				GPS_HolePattern() FaceBoltBoss(H=GPSPCB_Z) cylinder(d=6, h=GPSPCB_Z-1);
				
			translate([VoicePCB_Loc_X,VoicePCB_Loc_Y,0])
				VoiceHolePattern() FaceBoltBoss(H=VoicePCB_Z) cylinder(d=6, h=VoicePCB_Z-1);
		} // union
		
		
		translate([0,0,Face_Z]) CaseBoltPattern() Bolt4ButtonHeadHole();

		translate([MainPCB_Loc_X, MainPCB_Loc_Y, 0]){
			MainPCBHolePattern() FaceBoltBoss(H=MainPCB_Z) rotate([180,0,0]) Bolt4Hole(depth=MainPCB_Z-2);
			LCD_Hole();
		}
			
		translate([GPSPCB_Loc_X, GPSPCB_Loc_Y, 0]){
				GPS_HolePattern() FaceBoltBoss(H=GPSPCB_Z) rotate([180,0,0]) Bolt4Hole(depth=GPSPCB_Z-2);
				GPS_LEDHole();
		}
		
		
		translate([VoicePCB_Loc_X,VoicePCB_Loc_Y,0]){
			VoiceHolePattern() FaceBoltBoss(H=VoicePCB_Z) rotate([180,0,0]) Bolt4Hole(depth=VoicePCB_Z-2);
			translate([0,0,-Face_t]) VoiceJackHole();
				
			translate([-13, -13, Face_Z-1])	 linear_extrude(height=3) 
				text("Voice", size=6, halign="center", valign="center");
		}
				
		translate([0, 10, Face_Z-1]) linear_extrude(height=3) 
			text("Egg Finder", size=10, halign="center", valign="center");
			
		translate([GPSPCB_Loc_X-13, GPSPCB_Loc_Y-8, Face_Z-1]) linear_extrude(height=3) 
			text("GPS FIX", size=6, halign="center", valign="center");
	} // difference
	
	//*
	if ($preview){
		translate([MainPCB_Loc_X, MainPCB_Loc_Y, Face_Z-7]) color("Green") LCD_PCB();
		translate([MainPCB_Loc_X, MainPCB_Loc_Y, Face_Z-7-1.6-11]) color("Green") MainPCB();
		translate([VoicePCB_Loc_X,VoicePCB_Loc_Y,Face_Z-VoicePCB_Z]) color("Green") VoicePCB();
		translate([GPSPCB_Loc_X, GPSPCB_Loc_Y, Face_Z-GPSPCB_Z]) color("Green") GPS_PCB();
		translate([-22,-28,Face_Z-Face_t-12]) color("Gray") Battery();
	}
	/**/
		
} // CaseFront

//CaseFront();

module CaseSides(IncludeBackLightSwitch=false){
	Case_H=26;
	Lip_H=2.5;
	
	SW_Y=Case_X/2+Overlap;
	Ant_Y=Case_Y/2+Overlap;
	SW_d=6.5;
	PBSW_d=7;
	Ant_d=7;
	PowerSW_X=Case_Y/2-27;
	PowerSW_Z=SW_d/2+4;
	BackLightSW_X=-Case_Y/2+27;
	BackLightSW_Z=SW_d/2+4;
	PBSW_X=PowerSW_X-20;
	PBSW_Z=PBSW_d/2+4;
	
	Antenna_X=82/2-14;
	MainPCB_Z=7; // Face to Standoff
	Antenna_ZF=MainPCB_Z+12.5-2; // -2 for lip
	Antenna_Z=Case_H+5-Antenna_ZF; // Front face - ZF
	
	
	
	difference(){
		union(){
			RoundRect(X=Case_X, Y=Case_Y, Z=Case_H, R=Case_R);
			
		} // union
		
		
		
		translate([0,0,-Overlap]){
				RoundRect(X=Case_X-CaseWall_t*2, Y=Case_Y-CaseWall_t*2, 
					Z=Lip_H+Overlap, R=Case_R-CaseWall_t);
					
				RoundRect(X=Case_X-CaseWall_t*4, Y=Case_Y-CaseWall_t*4, 
					Z=Case_H+Overlap*2, R=Case_R-CaseWall_t*2);
		}
					
		translate([0,0,Case_H-Lip_H]) 
				RoundRect(X=Case_X-CaseWall_t*2, Y=Case_Y-CaseWall_t*2, 
					Z=Lip_H+Overlap, R=Case_R-CaseWall_t);
		
		
		
		// Holes for switches
		rotate([0,0,90]) translate([PowerSW_X,SW_Y,PowerSW_Z]) rotate([90,0,0]) cylinder(d=SW_d, h=10);
		
		if(IncludeBackLightSwitch){
			rotate([0,0,-90]) translate([BackLightSW_X,SW_Y,BackLightSW_Z]) 
				rotate([90,0,0]) cylinder(d=SW_d, h=10);
			rotate([0,0,-90]) translate([BackLightSW_X,SW_Y,BackLightSW_Z+10]) rotate([90,0,180])
				linear_extrude(2, center=true) text("BL", size=8, halign="center", valign="center");
		}
		
		rotate([0,0,90]) translate([PBSW_X,SW_Y,PBSW_Z]) rotate([90,0,0]) cylinder(d=PBSW_d, h=10);
		
		rotate([0,0,90]) translate([PowerSW_X,SW_Y,PowerSW_Z+10]) rotate([90,0,180])
			linear_extrude(2, center=true) text("1/0", size=8, halign="center", valign="center");
	
		
			
		// Hole for Antenna
		translate([Antenna_X,Ant_Y,Antenna_Z]){
			rotate([90,0,0]) cylinder(d=Ant_d, h=10);
			translate([0,-CaseWall_t*2,0]) cube([Ant_d+1, 3, Ant_d+1], center=true);
		}
	} // difference
	
	
} // CaseSides

//translate([0,0,-24]) CaseSides();





















