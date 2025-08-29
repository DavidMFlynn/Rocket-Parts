// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketSkippy.scad
// by David M. Flynn
// Created: 8/21/2025 
// Revision: 0.9.2  8/26/2025 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 98mm Body and 38mm motor. 
//  Recommended Motors: H242T
//
//
//  ***** Parts *****
//
//  ***** History *****
//
// 0.9.2  8/26/2025  Added EBay
// 0.9.1  8/25/2025  Fixes to fincan
// 0.9.0  8/21/2025  Copied from R75D
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// Nosecone();
// SpingTop(Tube_OD=Body_OD, Tube_ID=Body_ID, Spring_OD=SE_Spring_CS4323_OD(), Spring_ID=SE_Spring_CS4323_ID(), nRopes=3);
//
// *** Ball Lock ***
//
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=false, Xtra_r=0.2);
// rotate([180,0,0]) STB_Top();
// STB_Bottom();
// rotate([180,0,0]) STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=20); // Print 2
//
// *** petal deployer ***
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=3); // for dual deploy only
// rotate([-90,0,0]) PD_PetalSpringHolder();  // Print 6
// PD_Petals2(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
//
// *** Fin Can ***
//
// EBay(); // slips over top of motor tube
//
// rotate([180,0,0]) FinCan();
//
// RocketFin(HasSpiralVaseRibs=false);
//
// RailButton();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket(IsDualDeploy=DualDeploy, ShowInternals=false, ShowDoors=true);
// translate([300,0,0]) ShowRocket(IsDualDeploy=DualDeploy, ShowInternals=true, ShowDoors=false);
//
//
// ***********************************
include<TubesLib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<FinCan2Lib.scad>
use<SpringThingBooster.scad>
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad>			echo(SpringEndsLibRev());
use<R75Lib.scad>
use<AT_RMS_Lib.scad>
use<BatteryHolderLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Bolt4Inset=4;

// Nosecone param's
NC_Len=162;
NC_Tip_r=8;
NC_Wall_t=1.4;
NC_Base_L=15;

nPetals=3;
nLockBalls=5;

Petal_Len=100; // Main 'chute and lots of shock cord

AeroShell_OD=ULine102Body_OD;
AeroShell_ID=ULine102Body_ID;
AeroShell_Len=8*25.4;

Body_OD=ULine75Body_OD;
Body_ID=ULine75Body_ID;
Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;

MotorTube_OD=ULine38Body_OD;
MotorTube_ID=ULine38Body_ID;
MotorTubeHole_d=MotorTube_OD+IDXtra*3;

nFins=3;
//Fin_Post_h=14; // 38mm motor
Fin_Post_h=AeroShell_OD/2-MotorTubeHole_d/2-1.2; // 54mm motor
echo(Fin_Post_h=Fin_Post_h);
Fin_Root_L=120;
Fin_Root_W=8;
Fin_Tip_W=3.0;
Fin_Tip_L=70;
Fin_Span=70;
Fin_TipOffset=80;
Fin_Chamfer_L=32;
FinInset_Len=5;

FinCan_Len=Fin_Root_L+FinInset_Len*2; // Calculated fin can length

RailGuide_h=Body_OD/2+2;

// For display only, not used by parts
BodyTubeLen=160; 
MotorTubeLen=190; // min for 320NS case 190mm, 360NS case 240mm

echo(BodyTubeLen=BodyTubeLen);
echo(MotorTubeLen=MotorTubeLen);


module ShowRocket(ShowInternals=false, ShowDoors=false){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+FinCan_Len/2+1.7;
	MotorTube_Z=FinCan_Z+15;
	AeroShell_Z=FinCan_Z+FinCan_Len+Overlap*2;
	
	BallLock_Z=FinCan_Z+FinCan_Len+110;
	BodyTube_Z=BallLock_Z+15+Overlap*2;
	NoseCone_Z=AeroShell_Z+AeroShell_Len;
	
	echo(str("Overall Length = ",(NoseCone_Z+NC_Len)/25.4));

	translate([0,0,NoseCone_Z]){
		rotate([0,0,90]) Nosecone();
		}
				
	// Main parachute compartment parts
	if (ShowInternals){
		//translate([0,0,NoseCone_Z-60]) SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3);
		
		translate([0,0,BallLock_Z+Petal_Len+20+9]) rotate([180,0,0]) 
			PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=3);
			
		translate([0,0,BallLock_Z+Petal_Len+20]) rotate([180,0,0]) 
			PD_Petals2(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
	
		translate([0,0,BallLock_Z]) rotate([180,0,0]) 
			R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=false);
			
		translate([0,0,BallLock_Z]) rotate([180,0,0]) STB_Top();
	} // if (ShowInternals)
	
		
	if (ShowInternals){
		translate([0,0,BallLock_Z])
			rotate([180,0,0]) STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=20);
		
		//translate([0,0,BallLock_Z+10]) color("LightBlue") 
		//	Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	}
	
	if (!ShowInternals)
	translate([0,0,AeroShell_Z]) color("LightBlue") 
		Tube(OD=AeroShell_OD, ID=AeroShell_ID, Len=AeroShell_Len-Overlap*2, myfn=$preview? 90:360);
	
	if (ShowInternals)
	translate([0,0,MotorTube_Z]) color("Blue") 
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			
	translate([0,0,FinCan_Z]) color("White") FinCan();
	
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, AeroShell_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Yellow") RocketFin(false);
	
	
} // ShowRocket

// ShowRocket(ShowDoors=true);
// ShowRocket(ShowDoors=true);
// ShowRocket(ShowInternals=true);


module Nosecone(){
	AeroShellCoupler_Len=10;
	
	module BodyTubeAlignment(OD=100){
		nSpokes=7;
		
		Tube(OD=Body_OD+IDXtra*2+4.4, ID=Body_OD+IDXtra*2, Len=5, myfn=$preview? 90:360);
		for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j]) hull(){
			translate([0,Body_OD/2+1.2,0]) cylinder(d=2, h=5);
			translate([0,OD/2,0]) cylinder(d=2, h=5);
		} // hull
	} // BodyTubeAlignment
	
	BluntOgiveNoseCone(ID=AeroShell_ID, OD=AeroShell_OD, L=NC_Len, Base_L=NC_Base_L, 
		nRivets=0, RivertInset=0, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, FillTip=true);
		
	translate([0,0,-AeroShellCoupler_Len])
		Tube(OD=AeroShell_ID, ID=AeroShell_ID-4.4, Len=AeroShellCoupler_Len+Overlap, myfn=$preview? 90:360);
		
	difference(){
		cylinder(d=AeroShell_OD-1, h=3, $fn=$preview? 90:360);
		
		translate([0,0,-Overlap]) cylinder(d1=AeroShell_ID-4.4, d2=AeroShell_ID, h=3+Overlap*2, $fn=$preview? 90:360);
	} // difference
	
	
	translate([0,0,-AeroShellCoupler_Len]) BodyTubeAlignment(OD=AeroShell_ID-2);
	translate([0,0,40]) BodyTubeAlignment(OD=101);
		
} // Nosecone

// Nosecone();

module EBay(){

	module LiPoPocket(){
		LiPo_X=20;
		LiPo_Y=12.4;
		LiPo_Z=38;
		Wall_t=1.2;
		
		difference(){
			RoundRect(X=LiPo_X+Wall_t*2, Y=LiPo_Y+Wall_t*2, Z=LiPo_Z+Wall_t, R=0.5+Wall_t);
			translate([0,0,Wall_t]) RoundRect(X=LiPo_X, Y=LiPo_Y, Z=LiPo_Z+Wall_t, R=0.5);
		} // difference
	} // LiPoPocket
	
	rotate([0,0,-45]) translate([0,6.2+EBayTube_OD/2,0]) LiPoPocket();
	
	EBayTube_OD=MotorTubeHole_d+4.4;
	Tube(OD=EBayTube_OD, ID=MotorTubeHole_d, Len=62, myfn=$preview? 90:360);
	
	translate([0,-EBayTube_OD/2+2.1,32.75]) rotate([90,180,0]) RocketServoHolderRevC(IsDouble=false);
	
	rotate([0,0,-30]) translate([-EBayTube_OD/2+2.0,0,24.45]) rotate([0,-90,0]) BlueRavenMount();
} // EBay

// EBay();

module SpingTop(Tube_OD=Body_OD, Tube_ID=Body_ID, Spring_OD=SE_Spring_CS4323_OD(), Spring_ID=SE_Spring_CS4323_ID(), nRopes=3){
	Len=10;
	Engagement=7;
	Rope_d=4;
	HasAlTube=true;
	AlTube_OD=12.7;
	AlTube_a=30;
	
	difference(){
		cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
		
		translate([0,0,3]) Tube(OD=Body_OD+1, ID=Body_ID, Len=Len-3+Overlap, myfn=$preview? 90:360);
		translate([0,0,3]) Tube(OD=Body_ID-4.4, ID=Spring_OD+6, Len=Len-3+Overlap, myfn=$preview? 90:360);
		
		translate([0,0,-Overlap]) cylinder(d=Spring_ID, h=Len+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,3]) cylinder(d=Spring_OD, h=Len+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,6]) cylinder(d1=Spring_OD, d2=Spring_OD+2, h=Len+Overlap*2, $fn=$preview? 90:360);
		
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,Spring_OD/2+10,-Overlap]) cylinder(d=Rope_d, h=Len);
	} // difference
	
	rotate([0,0,AlTube_a])
	difference(){
		hull(){
			translate([0,0,-AlTube_OD/2]) rotate([90,0,0]) cylinder(d=AlTube_OD+6, h=Spring_ID+20, center=true, $fn=$preview? 90:360);
			cube([AlTube_OD+8, Spring_ID+20, Overlap], center=true);
		} // hull	
		
		translate([0,0,-AlTube_OD-10]) cylinder(d=Spring_ID, h=50, $fn=$preview? 90:360);
		translate([0,0,-AlTube_OD/2]) rotate([90,0,0]) cylinder(d=AlTube_OD, h=Spring_ID+20+Overlap, center=true, $fn=$preview? 90:360);
	} // difference
} // SpingTop

// rotate([180,0,0]) SpingTop();


module STB_Top(){
	STB_BallRetainerTop(Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, 
		nBolts=5, IntegratedCouplerLenXtra=-10,Body_ID=Body_ID, HasSecondServo=false, 
		UsesBigServo=false, Engagement_Len=20, HasLargeInnerBearing=false, Xtra_r=0.2);
} // STB_Top

// STB_Top();

module STB_Bottom(){
	STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, nLockBalls=nLockBalls, 
		HasSpringGroove=false, Engagement_Len=20, HasLargeInnerBearing=false, Xtra_r=0.2);
} // STB_Bottom

// STB_Bottom();

module FinCan(){
	FinBox_W=Fin_Root_W+2.4;
	FB_Xtra_Fwd=5;
	Coupler_Len=5;
	nBolts=5;
	BC_Len=10;
	
	difference(){
		union(){
			difference(){
				translate([0,0,FinCan_Len+BC_Len-3]) rotate([180,0,0]) BluntOgiveNoseCone(ID=AeroShell_ID, OD=AeroShell_OD, L=NC_Len, Base_L=BC_Len-1, 
						nRivets=0, RivertInset=0, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, FillTip=true);
				
				translate([0,0,-20]) cylinder(d=MotorTubeHole_d+6, h=23);
			} // difference
						
			// Body coupler
			BC_Len=10;
			difference(){
				translate([0,0,FinCan_Len-1]) Tube(OD=Body_ID, ID=Body_ID-4.4, Len=BC_Len+1, myfn=$preview? 90:360);
				for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Body_OD/2,FinCan_Len+5])
					rotate([-90,0,0]) Bolt4Hole();
			} // difference
			
			// AeroShell Alignment
			AeroShellCoupler_Len=3;
			translate([0,0,FinCan_Len+BC_Len-AeroShellCoupler_Len]) 
				Tube(OD=AeroShell_ID, ID=AeroShell_ID-4.4, Len=AeroShellCoupler_Len, myfn=$preview? 90:360);
			difference(){
				translate([0,0,FinCan_Len+BC_Len-6]) Tube(OD=AeroShell_ID+1, ID=AeroShell_ID-4.4, Len=3+Overlap, myfn=$preview? 90:360);
				translate([0,0,FinCan_Len+BC_Len-6-Overlap]) cylinder(d1=AeroShell_ID, d2=AeroShell_ID-4.4, h=3, $fn=$preview? 90:360);
			} // difference
			
			// Fin Boxes
			intersection(){
				translate([0,0,FinCan_Len]) rotate([180,0,0]) 
					rotate_extrude() BluntOgiveShape(L=NC_Len, D=AeroShell_OD, Base_L=2, Tip_R=NC_Tip_r); // Spherically blunted tangent ogive
				
				difference(){
					for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins]) 
						translate([-FinBox_W/2,0,0]) cube([FinBox_W, AeroShell_OD/2, FinCan_Len+FB_Xtra_Fwd]);
					
					// remove inside
					translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=FB_Xtra_Fwd+FinCan_Len+Overlap*2);
					
				} // difference
			} // intersection
			
			// motor tube sleve
			Tube(OD=MotorTubeHole_d+2.2, ID=MotorTubeHole_d, Len=FinCan_Len+Coupler_Len+BC_Len-5, myfn=$preview? 90:360);
			cylinder(d=ATRMS_38_Aft_d()+6, h=18, $fn=$preview? 90:360);
			translate([0,0,18-Overlap]) cylinder(d1=ATRMS_38_Aft_d()+6, d2=MotorTubeHole_d+2.2, h=4, $fn=$preview? 90:360);
		} // union
						
		// Fin Sockets
		translate([0,0,Fin_Root_L/2+FinInset_Len+2])
				TrapFin3Slots(Tube_OD=AeroShell_OD, nFins=nFins, Post_h=Fin_Post_h, 
					Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
			
						
		translate([0,0,-30]) cylinder(d=MotorTubeHole_d, h=30+FinCan_Len+1, $fn=$preview? 90:360);
		
		// Motor retainer
		translate([0,0,-Overlap]) cylinder(d=ATRMS_38_Aft_d(), h=15, $fn=$preview? 90:360);
		translate([0,0,3]) cylinder(d=ATRMS_38_Aft_d()+3, h=2+Overlap, $fn=$preview? 90:360);
		translate([0,0,5]) cylinder(d1=ATRMS_38_Aft_d()+3, d2=ATRMS_38_Aft_d(), h=3, $fn=$preview? 90:360);
	} // difference
} // FinCan

// FinCan();

module RocketFin(HasSpiralVaseRibs=true){
	
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, HasSpiralVaseRibs=HasSpiralVaseRibs);
				
	
} // RocketFin

// RocketFin(HasSpiralVaseRibs=false);





























