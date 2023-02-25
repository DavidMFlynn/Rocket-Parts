// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketOmega54.scad
// by David M. Flynn
// Created: 2/21/2023
// Revision: 0.9.5  2/24/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  2.1" Upscale of Estes Astron Omega
//  Two Stage Rocket with 54mm Body.
//  H242T-6 to H123W-P
//  Uses CableRelease as a spring thing
//  Booster uses motor ejection
//
//  ***** History *****
// 0.9.5  2/24/2023   Ready for first printing and test assembly.
// 0.9.4  2/24/2023   Added SpringThing Parts
// 0.9.3  2/23/2023   Added Nosecone and Cable Release parts to STL list.
// 0.9.2  2/21/2023   Copied from RocketOmega.scad, Simple fin cans
// 0.9.1  11/14/2022  Worked on booster fin can. 
// 0.9.0  10/10/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// OmegaNosecone();
// NoseconeBase(OD=ROmega_Coupler_OD, L=ROmega_Coupler_OD*0.8, NC_Base=21, HasUBolt=false);
//
//  *** SpringThing Parts ***
//
// ST_TubeEnd(Tube_OD=ROmega_Coupler_OD, Tube_ID=ROmega_Coupler_ID); // print 2
// rotate([180,0,0]) ST_TubeLockLanyard(Skirt_ID=ROmega_Coupler_ID-2-IDXtra);
// ST_TubeLock(Tube_OD=ROmega_Coupler_OD, Skirt_ID=ROmega_Coupler_ID-2, SkirtLen=15);
// ST_SpringMiddle(Tube_ID=ROmega_Coupler_OD);
// ST_SpringGuide(InnerTube_ID=ROmega_Body_ID);
//
//  *** Cable Release Parts ***
//
// rotate([180,0,0]) CR_Housing();
// LockPlate();
// LockingPin();
// BallRetainer();
// LockPlateStop();
// rotate([180,0,0]) HousingStop(OD=PML54Body_ID);
// TopMountS5245Tray();
// ServoWheelB(UsesHS5245MGServo=true);
// LockPlateExtension(Len=12);
// ServoWheel(HasLockingBar=true, HasHoles=false);
// 
//  *** Electronics Bay ***
//
// Omega54EBay();
// AltDoor54(Tube_OD=ROmega_Body_OD, IsLoProfile=false, DoorXtra_X=0, DoorXtra_Y=0);
// Batt_Door54(Tube_OD=ROmega_Body_OD, HasSwitch=true);
// ShockCordMount(OD=ROmega_Coupler_OD, ID=ROmega_MtrTube_OD+IDXtra*2, AnchorRod_OD=12.7); // optional
//
//  *** Fins & Fin Cans ***
//
// FinCan54();
// RocketOmegaFin();
//
// InterstageCouplerS();
// InterstagePiston();
// rotate([180,0,0]) BoosterFinCan();
// RocketOmegaBoosterFin()
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocketOmega();
//
// ***********************************
include<TubesLib.scad>
use<SpringThing2.scad>
use<Fairing54.scad>
use<NoseCone.scad>
use<FinCan.scad>
use<AltBay.scad>
use<CableRelease.scad>
use<BatteryHolderLib.scad>

//also included
 //include<RailGuide.scad>
 //include<Fins.scad>
 //include<TubesLib.scad>
 //include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Scale=BT54Body_OD/41.58; // Body tube diameters
echo(Scale=Scale);

ROmega_Body_OD=BT54Body_OD;
ROmega_Body_ID=BT54Body_ID;
ROmega_Coupler_OD=BT54Coupler_OD;
ROmega_Coupler_ID=BT54Coupler_ID;
ROmega_MtrTube_OD=PML38Body_OD;
ROmega_MtrTube_ID=PML38Body_ID;
ROmega_BMtrTube_OD=BT38Body_OD;
ROmega_BMtrTube_ID=BT38Body_ID;


nFins=4;
// Sustainer Fin
ROmega_Fin_Post_h=ROmega_Body_OD/2-ROmega_MtrTube_OD/2;
ROmega_Fin_Root_L=72*Scale;
ROmega_Fin_Root_W=5*Scale;
//echo(ROmega_Fin_Root_W=ROmega_Fin_Root_W);
ROmega_Fin_Tip_W=2*Scale;
ROmega_Fin_Tip_L=ROmega_Fin_Root_L*0.75;
ROmega_Fin_Span=ROmega_Fin_Root_L*0.75;
ROmega_Fin_TipOffset=0;
ROmega_Fin_Chamfer_L=ROmega_Fin_Root_W*3;

// Booster Fin
ROmegaBooster_Fin_Post_h=ROmega_Body_OD/2-ROmega_BMtrTube_OD/2;
ROmegaBooster_Fin_Root_L=90*Scale;
ROmegaBooster_Fin_Root_W=5.7*Scale;
ROmegaBooster_Fin_Tip_W=2*Scale;
ROmegaBooster_Fin_Tip_L=ROmegaBooster_Fin_Root_L*0.75;
ROmegaBooster_Fin_Span=ROmegaBooster_Fin_Root_L*0.75;
ROmegaBooster_Fin_TipOffset=0;
ROmegaBooster_Fin_Chamfer_L=ROmegaBooster_Fin_Root_W*3;
//echo(ROmegaBooster_Fin_Root_L=ROmegaBooster_Fin_Root_L);
//echo(ROmegaBooster_Fin_Span=ROmegaBooster_Fin_Span);



EBay_Len=162;
ScaleBooster_Body_Len=5*25.4*Scale; // too short to fit a parachute
echo(ScaleBooster_Body_Len=ScaleBooster_Body_Len);

PBay_Len=5*25.4*Scale;
LowerTube_Len=80;
SusFinCan_Len=ROmega_Fin_Root_L+40;

BoostFinCan_Len=ROmegaBooster_Fin_Root_L+40;
InterstageTube_Len=115; // 115 gives 85 for paradhute
Booster_Body_Len=BoostFinCan_Len+InterstageTube_Len;
//echo(Booster_Body_Len=Booster_Body_Len);

// Phenolic Body and Coupler Tube Lengths
echo("Upper Body Tube = ",440);
echo("Lower Body Tube = ",LowerTube_Len);
echo("Sustainer Motor Tube = ",SusFinCan_Len+LowerTube_Len+25);
echo("Booster Body = ",InterstageTube_Len);
echo("Booster Coupler = ",InterstageTube_Len-10);
echo("Booster Motor Tube = ",ROmegaBooster_Fin_Root_L+30);

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=170*Scale;
NC_Tip_r=5;
NC_Base=5;
NC_Lock_H=5;

//BodyTubeLen=36*25.4;

module ShowCableRelease(){
	Offset_Y=7;
	Offset_Z=55;
	
	translate([0,3,0]){
	translate([0,-Offset_Y,Offset_Z]) CR_Housing();
	// LockPlate();
	translate([0,-Offset_Y,Offset_Z-7]) LockingPin();
	// BallRetainer();
	// LockPlateStop();
	translate([0,0,Offset_Z+10]) HousingStop(OD=PML54Body_ID);
	translate([0,0,Offset_Z-55]) TopMountS5245Tray();
	// ServoWheelB(UsesHS5245MGServo=true);
	// LockPlateExtension(Len=12);
	// ServoWheel(HasLockingBar=true, HasHoles=false);
	}
} // ShowCableRelease

//ShowCableRelease();

module ShowBooster(){
	
	translate([0,0,BoostFinCan_Len+0.1]) color("White") 
		Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=InterstageTube_Len-0.2, myfn=$preview? 90:360);
	
	color("White") BoosterFinCan();
	
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([ROmega_Body_OD/2-ROmega_Fin_Post_h, 0, ROmegaBooster_Fin_Root_L/2+20]) 
			rotate([0,90,0]) color("Blue") RocketOmegaBoosterFin();
			
	MtrRMS38_240();
} // ShowBooster

//ShowBooster();

module ShowRocketOmega(){
	
	
	InterstageCoupler_Len=InterstageTube_Len;
	
	SusFinCan_Z=BoostFinCan_Len+InterstageCoupler_Len+1;
	LowerTube_Z=SusFinCan_Z+SusFinCan_Len;
	
	BH_Z=SusFinCan_Z+SusFinCan_Len+LowerTube_Len;
	EBay_Z=BH_Z;//+76;
	CR_Z=EBay_Z+EBay_Len+20;
	SpringThing_Z=CR_Z+90;
	UpperTube_Z=EBay_Z+EBay_Len;
	UpperTube_Len=265;
	PBay_Z=UpperTube_Z+UpperTube_Len;
	
	NC_Z=PBay_Z+PBay_Len;
	Spring_Len=100;
	ParachuteSleeve_Len=185;
	//echo("Sustainer Upper Tube = ", PBay_Len+UpperTube_Len);
	
	//*
	translate([0,0,NC_Z]){
		color("Black") OmegaNosecone();
		//translate([0,0,-ROmega_Coupler_OD*0.8])
		//	NoseconeBase(OD=ROmega_Coupler_OD, L=ROmega_Coupler_OD*0.8, NC_Base=21, HasUBolt=false);
		}
	
	//translate([0,0,NC_Z-ROmega_Coupler_OD*0.8-ParachuteSleeve_Len])
	//	Tube(OD=ROmega_Coupler_OD, ID=ROmega_Coupler_ID, Len=ParachuteSleeve_Len, myfn=$preview? 90:360);
	/*	
	translate([0,0,PBay_Z+0.1]) color("Silver") 
		Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=PBay_Len-0.2, myfn=$preview? 90:360);
	
	translate([0,0,UpperTube_Z+0.1]) color("White") 
		Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=UpperTube_Len-0.2, myfn=$preview? 90:360);
	/**/
		
	//translate([0,0,SpringThing_Z]) color("Gray") cylinder(d=54, h=Spring_Len);
	//translate([0,0,CR_Z]) rotate([0,0,120]) ShowCableRelease();
	/**/
	
	translate([0,0,EBay_Z]) {
		rotate([0,0,180-180/nFins]) color("White") Omega54EBay(ShowDoors=false);
		//translate([0,0,15-0.3])
		//	rotate([180,0,0]) ShockCordMount(OD=ROmega_Coupler_OD, ID=ROmega_MtrTube_OD, AnchorRod_OD=12.7);
	}
	

	//translate([0,0,LowerTube_Z+0.1]) color("White") 
		//Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=LowerTube_Len-0.2, myfn=$preview? 90:360);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([ROmega_Body_OD/2-ROmega_Fin_Post_h, 0, SusFinCan_Z+ROmega_Fin_Root_L/2+20]) 
			rotate([0,90,0]) color("Blue") RocketOmegaFin();
	/**/
	translate([0,0,SusFinCan_Z]) {
		
		color("White") FinCan54();
		color("Tan") Tube(OD=ROmega_MtrTube_OD, ID=ROmega_MtrTube_ID, Len=SusFinCan_Len+LowerTube_Len+25, myfn=$preview? 90:360);
		MtrRMS38_240(HasEyeBolt=true);
		}
	
	//ShowBooster();
} // ShowRocketOmega

//ShowRocketOmega();

module OmegaNosecone(){
	BluntOgiveNoseCone(ID=ROmega_Coupler_OD+IDXtra*2, OD=ROmega_Body_OD+IDXtra*2, L=190, 
			Base_L=20, Tip_R=9, Wall_T=2.2, Cut_Z=0, LowerPortion=false);
	
} // OmegaNosecone

//OmegaNosecone();

module Omega54EBay(ShowDoors=false){
	RailGuide_Z=EBay_Len-40;
	BattDoor_Z=EBay_Len/2+12;
	BattDoor_a=0;
	Rail_a=90;
	
	difference(){
		union(){
			Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=EBay_Len, myfn=$preview? 90:360);
			translate([0,0,15]) 
				CenteringRing(OD=ROmega_Body_OD-1, ID=ROmega_MtrTube_OD+IDXtra*3, 
								Thickness=5, nHoles=4, Offset=0);
			translate([0,0,EBay_Len-20])
				CenteringRing(OD=ROmega_Body_OD-1, ID=ROmega_MtrTube_OD+IDXtra*3, 
								Thickness=5, nHoles=4, Offset=0);
			// Stringers
			difference(){
				for (j=[0:1]) rotate([0,0,90+180*j]) translate([-3,-ROmega_Body_OD/2+1,15])
					cube([6,10,EBay_Len-30]);
					
				cylinder(d=ROmega_MtrTube_OD+IDXtra*3, h=EBay_Len);
			} // difference
		} // union
		
		// Rail Guide Bolts
		translate([0,0,RailGuide_Z]) rotate([0,0,Rail_a]) 
			translate([0,ROmega_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
			
		translate([0,0,EBay_Len/2]) rotate([0,0,180])
			Alt_BayFrameHole(Tube_OD=ROmega_Body_OD, DoorXtra_X=0, DoorXtra_Y=0);
			
		translate([0,0,BattDoor_Z]) rotate([0,0,BattDoor_a])
			Batt_BayFrameHole(Tube_OD=ROmega_Body_OD, Door_X=43, HasSwitch=true);
	} // difference
	
	translate([0,0,EBay_Len/2]) rotate([0,0,180])
		Alt_BayDoorFrame(Tube_OD=ROmega_Body_OD, Tube_ID=ROmega_Body_ID, 
						DoorXtra_X=0, DoorXtra_Y=0, ShowDoor=ShowDoors);

	translate([0,0,BattDoor_Z]) rotate([0,0,BattDoor_a])
		Batt_BayDoorFrame(Tube_OD=ROmega_Body_OD, Tube_ID=ROmega_Body_ID, 
						Door_X=43, HasSwitch=true, ShowDoor=false);
	//*
	// Rail Guide
	rotate([0,0,Rail_a])
	difference(){
		translate([0,0,RailGuide_Z]) 
			RailGuidePost(OD=ROmega_Body_OD, MtrTube_OD=ROmega_MtrTube_OD+IDXtra*3, 
							H=ROmega_Body_OD/2+2, TubeLen=40, Length = 30, BoltSpace=12.7);
		
		rotate([0,0,90]) translate([0,ROmega_Body_OD/2,RailGuide_Z]) 
			rotate([0,0,120]) cube([ROmega_Body_OD-10,ROmega_Body_OD*2,60],center=true);
		
		rotate([0,0,-150]) translate([0,ROmega_Body_OD/2,RailGuide_Z]) 
			rotate([0,0,120]) cube([ROmega_Body_OD-10,ROmega_Body_OD*2,60],center=true);
	} // difference
	/**/
	
	if (ShowDoors) translate([0,0,BattDoor_Z]) rotate([0,0,BattDoor_a])
		rotate([90,0,0]) Batt_Door54(Tube_OD=PML54Body_OD, HasSwitch=true);
} // Omega54EBay

//Omega54EBay(ShowDoors=true);
//AltDoor54(Tube_OD=ROmega_Body_OD, IsLoProfile=false, DoorXtra_X=0, DoorXtra_Y=0);

module FinCan54(){
	TB_Xtra=20;
	Can_Len=ROmega_Fin_Root_L+TB_Xtra*2;
	echo(Can_Len=Can_Len);
	RailGuide_Z=50;
	
	module InnitionWirePath(){
		rotate([0,0,-45]) translate([0,ROmega_Body_ID/2-2.25,TB_Xtra-5]) children();
	}
	
	difference(){
		union(){
			intersection(){
				translate([0,0,Can_Len/2]) TrapFin2Slots(Tube_OD=ROmega_Body_OD-1, nFins=nFins, 	
				Post_h=ROmega_Fin_Post_h, Root_L=ROmega_Fin_Root_L+9, 
				Root_W=ROmega_Fin_Root_W+4.4, Chamfer_L=ROmega_Fin_Chamfer_L);
				
				Tube(OD=ROmega_Body_OD-1, ID=ROmega_MtrTube_OD+1, Len=Can_Len, myfn=$preview? 36:360);
			}
			
			translate([0,0,TB_Xtra-5]) rotate([0,0,45])
				CenteringRing(OD=ROmega_Body_OD-1, ID=ROmega_MtrTube_OD+1, Thickness=5, nHoles=4, Offset=0);
			translate([0,0,Can_Len-TB_Xtra]) rotate([0,0,45])
				CenteringRing(OD=ROmega_Body_OD-1, ID=ROmega_MtrTube_OD+1, Thickness=5, nHoles=4, Offset=0);
			translate([0,0,Can_Len/2-2.5]) rotate([0,0,45])
				CenteringRing(OD=ROmega_Body_OD-1, ID=ROmega_MtrTube_OD+1, Thickness=5, nHoles=4, Offset=0);
			
			// Ignition Wire Guide
			InnitionWirePath() cylinder(d=4.4+2.2, h=Can_Len-TB_Xtra*2+10);
			
			Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=Can_Len, myfn=$preview? 90:360);
			translate([0,0,TB_Xtra-5])
			Tube(OD=ROmega_MtrTube_OD+4.4, ID=ROmega_MtrTube_OD+IDXtra*3, Len=ROmega_Fin_Root_L+10, myfn=$preview? 36:360);
			
		} // union
		
		// Ignition Wire Guide
		InnitionWirePath() translate([0,0,-Overlap]) 
			cylinder(d=4.5, h=Can_Len-TB_Xtra*2+10+Overlap*2);
			
		// Rail Guide Bolts
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,ROmega_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
			
		translate([0,0,Can_Len/2]) TrapFin2Slots(Tube_OD=ROmega_Body_OD, nFins=nFins, 	
			Post_h=ROmega_Fin_Post_h, Root_L=ROmega_Fin_Root_L, 
			Root_W=ROmega_Fin_Root_W, Chamfer_L=ROmega_Fin_Chamfer_L);
			
	} // difference
	
	//*
	// Rail Guide
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			RailGuidePost(OD=ROmega_Body_OD, MtrTube_OD=ROmega_MtrTube_OD+IDXtra*3, H=ROmega_Body_OD/2+2, TubeLen=40, Length = 30, BoltSpace=12.7);
		
		translate([0,0,RailGuide_Z]) TrapFin2Slots(Tube_OD=ROmega_Body_OD, nFins=nFins, 	
			Post_h=ROmega_Fin_Post_h, Root_L=ROmega_Fin_Root_L, Root_W=ROmega_Fin_Root_W, Chamfer_L=ROmega_Fin_Chamfer_L);
			
		// Ignition Wire Guide
		InnitionWirePath() translate([0,0,-Overlap]) 
			cylinder(d=4.5, h=Can_Len-TB_Xtra*2+10+Overlap*2);
	} // difference
	/**/
} // FinCan54

//FinCan54();
//MtrRMS38_240(HasEyeBolt=true);

module RocketOmegaFin(){
	//echo(ROmega_Fin_Post_h=ROmega_Fin_Post_h);
	
	TrapFin2(Post_h=ROmega_Fin_Post_h, Root_L=ROmega_Fin_Root_L, Tip_L=ROmega_Fin_Tip_L, 
			Root_W=ROmega_Fin_Root_W, Tip_W=ROmega_Fin_Tip_W, 
			Span=ROmega_Fin_Span, Chamfer_L=ROmega_Fin_Chamfer_L,
					TipOffset=ROmega_Fin_TipOffset);

	if ($preview==false){
		translate([-ROmega_Fin_Root_L/2+10,0,0]) cylinder(d=ROmega_Fin_Root_W*2.5, h=0.9); // Neg
		translate([ROmega_Fin_Root_L/2-10,0,0]) cylinder(d=ROmega_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // RocketOmegaFin

// RocketOmegaFin();

module MtrRMS38_240(HasEyeBolt=false){
	color("Red") cylinder(d=38, h=127);
	translate([0,0,-10+Overlap])  color("DarkGray") cylinder(d=42, h=10);
	if (HasEyeBolt){
		translate([0,0,127]) color("Green") {
			cylinder(d=38, h=3);
			cylinder(d=26,h=18);
			cylinder(d=16,h=30);
		}
		color("Silver") translate([0,0,127+30+15])  rotate([90,0,0])
			rotate_extrude() translate([12.7,0,0]) circle(d=6);
	}else{
		translate([0,0,127]) color("Blue") {
			cylinder(d=38, h=3);
			cylinder(d=26,h=18);
		}
	} // if
} // MtrRMS38_240

//MtrRMS38_240();
//MtrRMS38_240(HasEyeBolt=true);

module InterstageCouplerS(){
	difference(){
		Tube(OD=ROmega_Coupler_OD, ID=ROmega_Coupler_ID, Len=40, myfn=$preview? 36:360);
		for (j=[0:3]) rotate([0,0,90*j]) translate([0,ROmega_Coupler_ID/2-2,40-9]) 
			rotate([-90,0,0]) cylinder(d=10, h=5);
	} // difference
	cylinder(d=ROmega_Coupler_OD-1, h=5);
	
	translate([0,16,-1]) 
	rotate([90,0,0])scale([1,0.5,1])
	difference(){
		cylinder(d=25, h=7);
		translate([0,0,-Overlap]) cylinder(d=16, h=7+Overlap*2);
	} // difference
} // InterstageCouplerS

/*
translate([0,0,ROmegaBooster_Fin_Root_L+40+InterstageTube_Len-25]) difference(){
	InterstageCouplerS();
	translate([0,0,-Overlap]) cube([50,50,50]);
	}
/**/

module InterstagePiston(){
	
	Tube(OD=ROmega_Coupler_ID-IDXtra*2, ID=ROmega_Coupler_ID-4.4-IDXtra*2, Len=40, myfn=$preview? 36:360);
		
	translate([0,0,10]) 
	difference(){
		cylinder(d=ROmega_Coupler_ID-1, h=5);
		translate([0,ROmega_Coupler_ID/2-5,-Overlap]) cylinder(d=4, h=6);
	} // difference
	
	
} // InterstagePiston

/*
translate([0,0,ROmegaBooster_Fin_Root_L+26]) difference(){ 
	InterstagePiston();
	translate([0,0,-Overlap]) cube([50,50,50]);
	}
/**/

/*
	// Sustainer Motor
	//translate([0,0,ROmegaBooster_Fin_Root_L+40+InterstageTube_Len]) MtrRMS38_240(HasEyeBolt=true);
	
	// Booster Coupler
	translate([0,0,ROmegaBooster_Fin_Root_L+25])
		color("LightBlue") Tube(OD=ROmega_Coupler_OD, ID=ROmega_Coupler_ID, Len=InterstageTube_Len-10, myfn=$preview? 36:360);
		
	// Interstage Tube
	//translate([0,0,ROmegaBooster_Fin_Root_L+40+1])
	//	color("LightBlue") Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=InterstageTube_Len, myfn=$preview? 36:360);
		
	// Motor Tube
	color("LightBlue") Tube(OD=ROmega_BMtrTube_OD, ID=ROmega_BMtrTube_ID, Len=ROmegaBooster_Fin_Root_L+30, myfn=$preview? 36:360);
/**/

module BoosterFinCan(){
	TB_Xtra=20; //(Can_Len-ROmegaBooster_Fin_Root_L)/2;
	Can_Len=ROmegaBooster_Fin_Root_L+TB_Xtra*2; //Booster_Body_Len;
	
	echo(TB_Xtra=TB_Xtra);
	echo(Can_Len=Can_Len);
	RailGuide_Z=50;
	
	difference(){
		union(){
			intersection(){
				translate([0,0,Can_Len/2]) TrapFin2Slots(Tube_OD=ROmega_Body_OD-1, nFins=nFins, 	
				Post_h=ROmegaBooster_Fin_Post_h, Root_L=ROmegaBooster_Fin_Root_L+9, 
				Root_W=ROmegaBooster_Fin_Root_W+4.4, Chamfer_L=ROmegaBooster_Fin_Chamfer_L);
				
				Tube(OD=ROmega_Body_OD-1, ID=ROmega_BMtrTube_OD+1, Len=Can_Len, myfn=$preview? 36:360);
			}
			
			translate([0,0,TB_Xtra-5]) rotate([0,0,45])
				CenteringRing(OD=ROmega_Body_OD-1, ID=ROmega_BMtrTube_OD+1, Thickness=5, nHoles=4, Offset=0);
			translate([0,0,Can_Len-TB_Xtra]) rotate([0,0,45])
				CenteringRing(OD=ROmega_Body_ID-IDXtra*2, ID=ROmega_BMtrTube_OD+1, Thickness=5, nHoles=4, Offset=0);
			translate([0,0,Can_Len/2-2.5]) rotate([0,0,45])
				CenteringRing(OD=ROmega_Body_OD-1, ID=ROmega_BMtrTube_OD+1, Thickness=5, nHoles=4, Offset=0);
			
			// Shock cord anchor tube
			rotate([0,0,45]) translate([0,ROmega_Body_ID/2-2,Can_Len/2-2.5]) cylinder(d=7, h=Can_Len/2-15);
			
			// Body
			translate([0,0,15])
				Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=Can_Len-15, myfn=$preview? 90:360);
			
			// Inner tube
			difference(){
				Tube(OD=ROmega_BMtrTube_OD+4.4, ID=ROmega_BMtrTube_OD+IDXtra*3, 
					Len=Can_Len-TB_Xtra+5, myfn=$preview? 36:360);
				
				// Shock cord anchor access
				rotate([0,0,45]) translate([0,ROmega_Body_ID/2-2,Can_Len/2-2.5-10]) 
					rotate([90,0,0]) cylinder(d=20, h=10);
			} // difference
			
			// Tailcone
			cylinder(d1=ROmega_BMtrTube_OD+8, d2=ROmega_Body_OD, h=15+Overlap, $fn=$preview? 90:360);
		} // union
	
		// Shock cord anchor tube
		rotate([0,0,45]) translate([0,ROmega_Body_ID/2-2,Can_Len/2-2.5-Overlap]) 
			cylinder(d=4, h=Can_Len/2-15+Overlap*2);
		
		translate([0,0,Can_Len/2]) TrapFin2Slots(Tube_OD=ROmega_Body_OD, nFins=nFins, 	
			Post_h=ROmegaBooster_Fin_Post_h, Root_L=ROmegaBooster_Fin_Root_L, 
			Root_W=ROmegaBooster_Fin_Root_W, Chamfer_L=ROmegaBooster_Fin_Chamfer_L);
			
		translate([0,0,-Overlap]) cylinder(d=ROmega_BMtrTube_OD+IDXtra*3, h=20+Overlap*3);
		translate([0,0,-Overlap]) cylinder(d=ROmega_BMtrTube_OD+6, h=15);
	} // difference
	
} // BoosterFinCan

//BoosterFinCan();


module RocketOmegaBoosterFin(){
	TrapFin2(Post_h=ROmegaBooster_Fin_Post_h, Root_L=ROmegaBooster_Fin_Root_L, Tip_L=ROmegaBooster_Fin_Tip_L, 
			Root_W=ROmegaBooster_Fin_Root_W, Tip_W=ROmegaBooster_Fin_Tip_W, 
			Span=ROmegaBooster_Fin_Span, Chamfer_L=ROmegaBooster_Fin_Chamfer_L,
					TipOffset=ROmegaBooster_Fin_TipOffset);

	if ($preview==false){
		translate([-ROmegaBooster_Fin_Root_L/2+10,0,0]) cylinder(d=ROmegaBooster_Fin_Root_W*2.5, h=0.9); // Neg
		translate([ROmegaBooster_Fin_Root_L/2-10,0,0]) cylinder(d=ROmegaBooster_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // RocketOmegaBoosterFin

// RocketOmegaBoosterFin();




































