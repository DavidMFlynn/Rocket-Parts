// ***********************************
// Project: 3D Printed Rocket
// Filename: BoosterPooper3.scad
// Created: 9/3/2022 
// Revision: 0.9.2  9/9/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 2 strap-on boosters. 
//  Boosters have 38mm motors w/ 54mm body
//  Sustainer has 54mm motor w/ 98mm body
//
// See Fairing54.scad for booster fairing
//
//  ***** History *****
// 
// 0.9.2  9/9/2022  Still working on ForwardBoosterLock
// 0.9.1  9/8/2022  Booster is ready to print, still working on ForwardBoosterLock and parts. 
// 0.9.0  9/3/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// ForwardBoosterLock(); // not ready to print
// BB_Lock();
//
// BP_Fin();
// rotate([180,0,0]) LowerFinCan();
// UpperFinCan();
//
// *** Strap-On Booster Parts ***
// 
/*
FairingCone(Fairing_OD=BP_Booster_Body_OD, 
					FairingWall_T=2.2,
					NC_Base=5, 
					NC_Len=95, 
					NC_Wall_t=2,
					NC_Tip_r=5);
/**/
// NoseLockRing();
//
/*
 F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=BP_Booster_Fairing_OD,
				Wall_T=BP_Booster_Fairing_Wall_t,
				Len=BP_Booster_Fairing_Len); // Booster Fairing, the parachute goes in here. 
/**/
//
/*
 F54_FairingHalf(IsLeftHalf=false, 
				Fairing_OD=BP_Booster_Fairing_OD,
				Wall_T=BP_Booster_Fairing_Wall_t,
				Len=BP_Booster_Fairing_Len); // Booster Fairing, the parachute goes in here. 
/**/
//
// rotate([180,0,0]) FairingBase(); // Pring w/ support
// FairingBaseLockRing();
//  rotate([180,0,0]) BB_LockShaft(Len=LockShaftLen);
//
// SpringEndCap();
//
// Booster_E_Bay();
// AltDoor54(Tube_OD=BP_Booster_Body_OD);
// rotate([180,0,0]) BoosterTail();
// BoosterButton();
//
// ***********************************
//  ***** Routines *****
//
// TailCone5438(OD=BP_Booster_Body_OD, ID=BP_Booster_MtrTube_OD, Len=50);
// BoosterThrustRing();
// BB_ThrustPoint();
// BB_LockingThrustPoint();
//
// ***********************************
//  ***** for Viewing *****
//
// ShowBooster();
// ShowBoosterPooper();
//
// ***********************************

include<LD-20MGServoLib.scad>
include<Fairing54.scad>
include<BoosterDropperLib.scad>
include<FinCan.scad>
include<AltBay.scad>

//also included
 //include<NoseCone.scad>
 //include<ChargeHolder.scad>
 //include<CablePuller.scad>
 //include<FairingJointLib.scad>
 //include<RailGuide.scad>
 //include<Fins.scad>
 //include<TubesLib.scad>
 //include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=4;
nBoosters=2;

BP_Booster_Body_OD=PML54Body_OD;
BP_Booster_Body_ID=PML54Body_ID;
BP_Booster_MtrTube_OD=PML38Body_OD;
BP_Booster_MtrTube_ID=PML38Body_ID;
BP_Booster_MtrRtr_OD=PML38Body_OD+6;
BP_Booster_Fairing_Len=130;
BP_Booster_Fairing_OD=BP_Booster_Body_OD;
BP_Booster_Fairing_Wall_t=2.2;
BP_Booster_Fairing_ID=BP_Booster_Fairing_OD-BP_Booster_Fairing_Wall_t*2;

BP_Body_OD=PML98Body_OD;
BP_Body_ID=PML98Body_ID;
BP_MtrTube_OD=BT54Mtr_OD; //PML54Body_OD;


BP_Fin_Post_h=10;
BP_Fin_Root_L=240;
BP_Fin_Root_W=12;
BP_Fin_Tip_W=6;
BP_Fin_Tip_L=100;
BP_Fin_Span=180;
BP_Fin_TipOffset=40;
BP_Fin_Chamfer_L=24;

ThrustRing_h=BoosterButtonMinor_d+6;
EBay_Len=120;
BP_BoosterTailConeLen=70;
BP_MtrTubeLen=BP_Fin_Root_L+140;

BP_BoosterButton1_z=100;
BP_BoosterButtonSpacing=BP_Fin_Root_L+85;
BP_BoosterButton2_z=BP_BoosterButton1_z+BP_BoosterButtonSpacing;

BP_BoosterTubeLen=BP_BoosterButtonSpacing-ThrustRing_h-40;
echo(BP_BoosterTubeLen=BP_BoosterTubeLen);
BP_BoosterMotorTubeLen=BP_BoosterButtonSpacing+ThrustRing_h+BP_BoosterTailConeLen-10;
echo(BP_BoosterMotorTubeLen=BP_BoosterMotorTubeLen);

LockShaftLen=48.5;

//NoseLockRing(Fairing_ID =BP_Booster_Fairing_ID);
//FairingBaseLockRing(Tube_ID=BP_Booster_Body_ID, Fairing_ID=BP_Booster_Fairing_ID, Interface=Overlap);
//mirror([0,0,1])F54_Retainer(IsLeftHalf=true, Fairing_OD=BP_Booster_Fairing_OD, Wall_T=BP_Booster_Fairing_Wall_t);

module ShowBooster(){
	
	// Booster nosecone
	translate([0,0,BP_BoosterButton2_z+EBay_Len+ThrustRing_h/2+Fairing_Len+Overlap*3]){
		color("Green") FairingCone();
		color("Tan") NoseLockRing();
	}

	// Booster fairing
	translate([0,0,BP_BoosterButton2_z+EBay_Len+ThrustRing_h/2+Overlap*3]) 
		F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=BP_Booster_Body_OD,
				Wall_T=BP_Booster_Fairing_Wall_t,
				Len=BP_Booster_Fairing_Len);
	
	// Booster electronics bay
	translate([0,0,BP_BoosterButton2_z+Overlap*2]) rotate([0,0,-90]) color("Orange") Booster_E_Bay();
	
	// Booster body tube
	color("LightBlue")
	translate([0,0,BP_BoosterButton1_z+ThrustRing_h/2+20+Overlap])
		Tube(OD=BP_Booster_Body_OD, ID=BP_Booster_Body_ID, 
			Len=BP_BoosterTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	// Booster tail
	translate([0,0,BP_BoosterButton1_z]) 
		rotate([0,0,-90]) color("Orange") BoosterTail();
	
	// Booster motor tube
	color("LightBlue")
	translate([0,0,BP_BoosterButton1_z-ThrustRing_h/2-60])
		Tube(OD=BP_Booster_MtrTube_OD, ID=BP_Booster_MtrTube_ID, 
			Len=BP_BoosterMotorTubeLen, myfn=$preview? 90:360);
			
	translate([-BP_Booster_Body_OD/2-BoosterButtonOA_h,0,BP_BoosterButton1_z])
		rotate([0,90,0]) BoosterButton();
	translate([-BP_Booster_Body_OD/2-BoosterButtonOA_h,0,BP_BoosterButton2_z])
		rotate([0,90,0]) BoosterButton();

} // ShowBooster

//ShowBooster();

module ShowBoosterPooper(){
	
	translate([0,0,BP_BoosterButton2_z+Overlap*2]) rotate([0,0,45]) rotate([0,90,0]) BB_LockShaft(Len=LockShaftLen);
	
	
	//*
	translate([0,0,BP_BoosterButton2_z+Overlap*2])
		rotate([0,0,-45]) {
			translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]){
				BB_Lock();
				color("Gray") BB_LockingThrustPoint();
				}
			rotate([0,0,180]) translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) 
				rotate([-90,0,0]) {
					BB_Lock();
					color("Gray") BB_LockingThrustPoint();
					}
	} /**/
	
	
	translate([0,0,BP_BoosterButton2_z+Overlap*2]) rotate([0,0,-45]) ForwardBoosterLock();
	
	/*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([BP_Body_OD/2-BP_Fin_Post_h,0,BP_Fin_Root_L/2+50]) 
			rotate([0,90,0]) color("Yellow") BP_Fin();
	/**/
	
	/*  // Motor Tube
	translate([0,0,17]) color("Blue") Tube(OD=BP_MtrTube_OD, ID=54, 
			Len=BP_MtrTubeLen, myfn=$preview? 90:360);
	/**/
	 
	//translate([0,0,BP_Fin_Root_L+100+Overlap]) color("White") UpperFinCan();
	//color("LightGreen") LowerFinCan();
	
	// Boosters 
	/*
	rotate([0,0,45]) translate([BP_Booster_Body_OD/2+BP_Body_OD/2,0,0]) ShowBooster();
	rotate([0,0,45+180]) translate([BP_Booster_Body_OD/2+BP_Body_OD/2,0,0]) ShowBooster();
	/**/
		
} // ShowBoosterPooper

//ShowBoosterPooper();

//FairingBaseLockRing(Tube_ID=BP_Booster_Body_ID, 
//	Fairing_ID=BP_Booster_Fairing_ID, Interface=Overlap);

module Booster_E_Bay(){
	// Z=0 center of Booster button
	TopOfTube=EBay_Len+ThrustRing_h/2;
	CablePullerInset=-1;
	CP_a=-5;
	
	// The Fairing clamps onto this. 
	translate([0,0,TopOfTube-4]) 
		FairingBaseLockRing(Tube_ID=BP_Booster_Body_ID, 
		Fairing_ID=BP_Booster_Fairing_ID, Interface=Overlap);
	
	difference(){
		translate([0,0,TopOfTube-7]) cylinder(d=BP_Booster_Body_ID+1, h=3+Overlap);
		translate([0,0,TopOfTube-7-Overlap]) 
				cylinder(d2=BP_Booster_Body_ID-4.2, d1=BP_Booster_Body_ID, h=3+Overlap*3, $fn=$preview? 90:360);
	} // difference
	
	// Standard E-Bay module
	difference(){
		translate([0,0,ThrustRing_h/2-Overlap]) rotate([0,0,90])
			AltBay54(Tube_OD=BP_Booster_Body_OD, Tube_ID=BP_Booster_Body_ID, Tube_Len=EBay_Len);
		
		// Cable Puller Bolt Holes
		translate([0,0,TopOfTube-12]) rotate([0,90,135]) 
			translate([0,0,BP_Booster_Body_ID/2-CablePullerInset]) 
				rotate([CP_a,0,0]) CablePullerBoltPattern() Bolt4Hole();
	} // difference
		
	// Upper Thrust Point, The motor tube stops here. 
	translate([0,0,-ThrustRing_h/2])
		BoosterThrustRing(MtrTube_OD=BP_Booster_MtrTube_OD, BodyTube_OD=BP_Booster_Body_OD);
	
	// Lower Coupler Tube Socket
	translate([0,0,-ThrustRing_h/2-20])
		Tube(OD=BP_Booster_Body_OD, ID=BP_Booster_Body_ID, 
			Len=20+Overlap, myfn=$preview? 90:360);
	
	// Shock code path, keep it out of the way. 
	
	rotate([0,0,10])
	difference(){
		Y1=30;
		Y2=65;
		Y3=110;
		H=6;
		
		union(){
			translate([0,-BP_Booster_Body_OD/2+4.4,Y1]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
			translate([0,-BP_Booster_Body_OD/2+4.4,Y2]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
			translate([0,-BP_Booster_Body_OD/2+4.4,Y3]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
		}// union
		
		translate([0,-BP_Booster_Body_OD/2+4.4,Y1-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		translate([0,-BP_Booster_Body_OD/2+4.4,Y2-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		translate([0,-BP_Booster_Body_OD/2+4.4,Y3-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		// Conform to OD of E-Bay
		
		difference(){
			cylinder(d=BP_Booster_Body_ID+20, h=200);
			translate([0,0,-Overlap]) cylinder(d=BP_Booster_Body_ID+1, h=200+Overlap*2);
		} // difference
	} // difference
	
	translate([0,0,TopOfTube-12]) rotate([0,90,135]) 
	difference(){
		// Cable Puller Bolt Bosses
		translate([0,0,BP_Booster_Body_ID/2-CablePullerInset]) 
			rotate([CP_a,0,0]) CablePullerBoltPattern() 
				hull(){
					rotate([180,0,0]) cylinder(d=8, h=8);
					translate([12,0,0]) rotate([180,0,0]) cylinder(d=3, h=Overlap);
				} // hull
		
		// Cable Puller Bolt Holes
		translate([0,0,BP_Booster_Body_ID/2-CablePullerInset]) 
			rotate([CP_a,0,0]) CablePullerBoltPattern() Bolt4Hole();
		
		// Conform to OD of E-Bay
		rotate([0,90,0]) translate([0,0,-10])
		difference(){
			cylinder(d=BP_Booster_Body_ID+20, h=100);
			translate([0,0,-Overlap]) cylinder(d=BP_Booster_Body_ID+1, h=100+Overlap*2);
		} // difference
	} // difference
} // Booster_E_Bay

//Booster_E_Bay();
//AltDoor54(Tube_OD=BP_Booster_Body_OD);
//translate([0,0,EBay_Len+ThrustRing_h/2-12]) rotate([0,90,135]) translate([0,0,BP_Booster_Body_ID/2+1]) 
	//		rotate([-5,0,0]) translate([0,0,-20]) CR_Cage();

module TailCone5438(OD=BP_Booster_Body_OD, ID=BP_Booster_MtrTube_OD, Len=50){
	TC_d=(OD-ID)/2;
	TC_h=TC_d*1.7;
	MtrRetainer_OD=BP_Booster_MtrRtr_OD;
	MtrRetainer_L=16;
	MtrRetainer_Inset=5;
	
	difference(){
		hull(){
			translate([0,0,Len-Overlap]) cylinder(d=OD, h=Overlap, $fn=$preview? 90:360);
			translate([0,0,TC_h]) rotate_extrude($fn=$preview? 90:360) translate([OD/2-TC_d/2,0,0]) circle(d=TC_d, $fn=$preview? 36:90);
			cylinder(d=ID, h=Overlap, $fn=$preview? 90:360);
		} // hull
		
		translate([0,0,-Overlap]) cylinder(d=ID+IDXtra*3, h=Len+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) cylinder(d=MtrRetainer_OD+IDXtra*2, h=MtrRetainer_L+MtrRetainer_Inset+Overlap*2, $fn=$preview? 90:360);
		cylinder(d=OD, h=MtrRetainer_Inset);
	} // difference
	
} // TailCone

//TailCone5438();

module BoosterTail(){
	// Z=0 : center of thrust ring
	TC_Len=BP_BoosterTailConeLen;
	
	translate([0,0,ThrustRing_h/2-Overlap]) 
		Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=20, myfn=$preview? 90:360);
	translate([0,0, -ThrustRing_h/2]) 
		BoosterThrustRing(MtrTube_OD=BP_Booster_MtrTube_OD, BodyTube_OD=BP_Booster_Body_OD);
	translate([0,0,-ThrustRing_h/2+Overlap-TC_Len]) TailCone5438(Len=TC_Len);
} // BoosterTail

//rotate([0,0,45]) translate([BP_Booster_Body_OD/2+BP_Body_OD/2,0,100]) rotate([0,0,-90]) BoosterTail();


module ForwardBoosterLock(){
	// Z=0, BoosterButton center line
	Bottom_Z=-85;
	OAL_Z=135;
	CentralCavity_Y=58;
	CentralCavity2_Y=44;
	
	module BD_Holes(){
		translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]) BB_LTP_Hole();
		rotate([0,0,180]) translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]) BB_LTP_Hole();
		
		// d=33 Ball Bearing OD - 4
		rotate([-90,0,0]) cylinder(d=33, h=BP_Body_OD, center=true);
	} // BD_Holes
	
	
	rotate([-90,0,0]) rotate([0,0,90]) BB_LockStop(Len=50, Extra_H=4);
	
	//*
	difference(){
		translate([0,0,Bottom_Z]) Tube(OD=BP_Body_OD, ID=BP_Body_ID, Len=OAL_Z, myfn=$preview? 36:360);
		BD_Holes();
	} // difference
	/**/
	
	difference(){
		union(){
			translate([0,0,-40]) 
				RailButtonPost(OD=BP_Body_OD, MtrTube_OD=BP_MtrTube_OD, H=5.5*25.4/2);
			translate([0,0,-40-25]) rotate([0,0,30]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*3, Thickness=5, nHoles=6);
			translate([0,0,-40+20])  rotate([0,0,30]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*3, Thickness=5, nHoles=6);
		} // union
		
		BD_Holes();
	} // difference
	
	difference(){
		translate([0,0,Bottom_Z+20]) cylinder(d=BP_Body_OD-1, h=OAL_Z-40, $fn=$preview? 90:360);
			
		// Clean up base below centering ring
		translate([0,0,Bottom_Z+15-Overlap]) cylinder(d1=BP_Body_OD, d2=BP_Body_OD-50, h=25);
		translate([-BP_Body_OD/2,-CentralCavity2_Y/2,Bottom_Z-Overlap]) 
			cube([BP_Body_OD,CentralCavity2_Y,OAL_Z+Overlap*2]);
		
		// Servo
		G_a=22.5;
		rotate([0,G_a,0]) translate([0,-8,24*300/180]) rotate([0,90-G_a,0]) 
			rotate([-90,0,0]) Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=1.2, Xtra_h=1);
		
		
		/*
		translate([0,0,27]) cylinder(d1=CentralCavity2_Y, d2=BP_Body_OD-2, h=8+Overlap);
		hull(){
			translate([-BP_Body_OD/2,-CentralCavity_Y/2,Bottom_Z-Overlap])
				cube([BP_Body_OD,CentralCavity_Y,45]);
			translate([-BP_Body_OD/2,-CentralCavity2_Y/2,Bottom_Z+45+CentralCavity_Y-CentralCavity2_Y])
				cube([BP_Body_OD,CentralCavity2_Y,Overlap]);
		} // hull
		/**/
		BD_Holes();
	} // difference
	
	
} // ForwardBoosterLock

//G_a=30;
//ForwardBoosterLock();

//translate([0,0,0]) rotate([-90,0,0]) BB_LockShaft(Len=LockShaftLen);
//rotate([0,G_a,0]) translate([0,11,24*300/180]) rotate([-90,0,0]) 
//rotate([0,0,180/24]) 
//BB_Gear();



module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan3(Tube_OD=BP_Body_OD, Tube_ID=BP_Body_ID, MtrTube_OD=BP_MtrTube_OD, nFins=nFins,
			Post_h=BP_Fin_Post_h, Root_L=BP_Fin_Root_L, Root_W=BP_Fin_Root_W, 
			Chamfer_L=BP_Fin_Chamfer_L, HasTailCone=false); 

} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	
	
	for (j=[0:nBoosters-1])
		rotate([0,0,360/nBoosters*j-180/nFins]) 
		translate([0,BP_Body_OD/2-BoosterButtonOA_h,BP_BoosterButton1_z]) 
		rotate([-90,0,0]) BB_ThrustPoint(BodyTube_OD=BP_Body_OD, BoosterBody_OD=BP_MtrTube_OD);

	difference(){
		union(){
			translate([0,0,BP_BoosterButton1_z+BoosterButtonMajor_d/2+1]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*2, Thickness=5);
			translate([0,0,BP_BoosterButton1_z-BoosterButtonMajor_d*2.5-5]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*2, Thickness=5);
		} // union
		
		translate([0,0,50]) TrapFin2Slots(Tube_OD=BP_Body_OD, nFins=nFins, 	
			Post_h=BP_Fin_Post_h, Root_L=BP_Fin_Root_L, Root_W=BP_Fin_Root_W, Chamfer_L=BP_Fin_Chamfer_L);
	} // difference

	difference(){
		FinCan3(Tube_OD=BP_Body_OD, Tube_ID=BP_Body_ID, MtrTube_OD=BP_MtrTube_OD, nFins=nFins, 
			Post_h=BP_Fin_Post_h, Root_L=BP_Fin_Root_L, Root_W=BP_Fin_Root_W, 
			Chamfer_L=BP_Fin_Chamfer_L, HasTailCone=true); // Lower Half of Fin Can
		
		for (j=[0:nBoosters-1])
			rotate([0,0,360/nBoosters*j-180/nFins]) translate([0,BP_Body_OD/2-BoosterButtonOA_h,
					BP_BoosterButton1_z]) rotate([-90,0,0]) BB_ThrustPoint_Hole();
	} // difference

	translate([0,0,60]) rotate([0,0,-180/nFins]) 
			RailButtonPost(OD=BP_Body_OD, MtrTube_OD=BP_MtrTube_OD, H=5.5*25.4/2);

} // LowerFinCan

// LowerFinCan();


module BP_Fin(){
	
	TrapFin2(Post_h=10, Root_L=BP_Fin_Root_L, Tip_L=BP_Fin_Tip_L, 
			Root_W=BP_Fin_Root_W, Tip_W=BP_Fin_Tip_W, 
			Span=BP_Fin_Span, Chamfer_L=BP_Fin_Chamfer_L, TipOffset=BP_Fin_TipOffset, 
			Bisect=false, Bisect_X=0);
	
	if ($preview==false){
		translate([-BP_Fin_Root_L/2+10,0,0]) cylinder(d=BP_Fin_Root_W*2.5, h=0.9); // Neg
		translate([BP_Fin_Root_L/2-10,0,0]) cylinder(d=BP_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // BP_Fin

//BP_Fin();



























