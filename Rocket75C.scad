// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket75C.scad
// by David M. Flynn
// Created: 8/6/2023 
// Revision: 1.3.0  7/18/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Upscale of Rocket65
//  Rocket with 75mm Body and 54mm motor. 
//
//  Single deploy:
//   Mission Control V3 / RocketServo
//
//  ***** Parts *****
//
// BlueTube 2.0 3" Body Tube by 8.5 inches (for dual deploy)
// BlueTube 2.0 3" Body Tube by 18 to 24 inches (19.25" as built)
// Blue Tube 2.1" Body Tube by 16 inches
// 45" Parachute
// 1/8" Paracord (3 feet)
// 1/2" Braided Nylon Shock Cord (20 feet)
//
//  ***** Hardware *****
//    Note: Qty for Single Deploy/Qty for Dual Deploy
// 5/32" x 1/8" Plastic Rivets (3 req) Nosecone
// #8-32 x 3/4" Button Head Cap Screw (2 req) Rail Buttons
// #4-40 x 1/2" Socket Head Cap Screw (3/6 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (6/10 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (6/12 req) Petals
// #4-40 x 1/4" Button Head Cap Screw (6/9 req) Couplers
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #2-56 x 1/4" Socket Head Cap Screw (2/4 req) Servo
// MR84-2RS Bearing (5/10 req) Ball Lock
// 3/8" Delrin Ball (3/6 req) Ball Lock
// 4mm Dia. x 10mm Undersize Steel Dowel (3/6 req) Ball Lock
// 4mm Dia. x 16mm Undersize Steel Dowel (3/6 req) Ball Lock
// 3/16" Dia x 1/8" Disc Magnet N42 (2/4 req) Ball Lock
// SG90 or MG90S Micro Servo (1/2 req) Ball Lock
// C&K Rotary Switch (1/2 req) Battery Door
// Mission Control V3 Altimeter PCBA
// Rocket Servo PCBA (1/2 req)
// FeatherWeight GPS
// 1/4" Rail Button (2 req)
// CS4323 Spring (1/2 req)
// 5/16" Dia x 1-1/4" Spring (3/6 req) PetalHub
// 1/2" Dia x 0.035" Wall x 74mm Long Aluminum Tube (1/3 req)
//
//  ***** History *****
//
// 1.3.0  7/18/2024  Changed to 5 Lock Balls and Dual Deploy
// 1.2.3  4/21/2024  Added screw holes to R75_BallRetainerTop()
// 1.2.2  4/18/2024  Standardized some parts
// 1.2.1  3/31/2024  Now uses ElectronicsBayLib.scad
// 1.2.0  12/3/2023  Updated ebay and deployment parts, removed obsolete parts
// 1.1.1  10/22/2023  Now uses PetalDeploymentLib.scad
// 1.1.0  8/9/2023   Got Dual Deploy?
// 1.0.1  8/8/2023   Fin can improvments
// 1.0.0  8/6/2023   Copied from Rocket65 Rev 1.0.8
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);

// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=120, LowerPortion=false); // Upper half

// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=120, Transition_OD=BT75Body_OD-18, LowerPortion=true); // Lower half
//
// NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
//
// *** Electronics Bay ***
//
// EB_Electronics_Bay3(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=162, nBolts=3, BoltInset=NC_Base_L/2, DualDeploy=false, ShowDoors=false);
//
// *** Dual Deploy Electronics Bay ***
//
// EB_Electronics_Bay3(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=162, nBolts=3, BoltInset=NC_Base_L/2, DualDeploy=true, ShowDoors=false);
// 
// *** Doors ***
//
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=true);
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=true, DoubleBatt=true);
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls);
// rotate([180,0,0]) R75_BallRetainerTop();
// R75_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
// *** petal deployer ***
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=3, nRopes=3); // for dual deploy only
// PD_PetalHub(OD=Coupler_OD, nPetals=3, ShockCord_a=ShockCord_a);
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=150, nPetals=3, Wall_t=1.8, AntiClimber_h=3, HasLocks=false);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=110, nPetals=3, Wall_t=1.8, AntiClimber_h=3, HasLocks=false);
//
// SE_SpringEndTop(OD=Coupler_OD-IDXtra, Tube_ID=BT75Coupler_OD-IDXtra-3.6, nRopeHoles=3, CutOutCenter=true);
// SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3);
//
//  *** bottom of spring options
// SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);// optional may be required for 54/1706 (K185W)
// rotate([180,0,0]) SE_SpringEndTypeA(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=3); // preferred option
// SE_SpringEndTypeB(Coupler_OD=Coupler_OD, MotorCoupler_OD=MotorCoupler_OD, nRopes=3); // Sits on top of motor tube
// SE_SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_ID, Len=70); // optional
// SE_SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_ID, Len=55); // optional
//
// UpperRailBtnMount75();
//
// *** Fin Can ***
//
/*
	rotate([180,0,0]) FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=1, // Rail Button
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TailCone_Len, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
/**/
/*
  FC2_MotorRetainer(Body_OD=Body_OD,
						MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
						HasWrenchCuts=false, Cone_Len=35, ExtraLen=0);
/**/
// RocketFin(HasSpiralVaseRibs=true);
//
// RailButton(); // (4 req) print many
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket();
// translate([300,0,0]) ShowRocket(ShowInternals=true);
//
// ***********************************
include<TubesLib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<ElectronicsBayLib.scad>
use<FinCan2Lib.scad>
use<AltBay.scad>
use<BatteryHolderLib.scad>
use<SpringThingBooster.scad>
use<PetalDeploymentLib.scad>
use<ThreadLib.scad>
use<SpringEndsLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Scale=1.1808;
echo("Scale on Rocket65 = ",Scale);

nLockBalls=5;

nFins=5;
Fin_Post_h=10;
Fin_Root_L=160*Scale;
Fin_Root_W=6*Scale;
Fin_Tip_W=3.0;
Fin_Tip_L=70*Scale;
Fin_Span=70*Scale;
Fin_TipOffset=20*Scale;
Fin_Chamfer_L=18*Scale;

Body_OD=BT75Body_OD;
Body_ID=BT75Body_ID;
Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;

// *** 38mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorCoupler_OD=BT54Coupler_OD;

MotorTubeHole_d=MotorTube_OD+IDXtra*3;

NC_Len=180*Scale;
NC_Tip_r=5*Scale;
NC_Wall_t=1.8;
NC_Base_L=13;

MainBay_Len=8.5*25.4;
EBay_Len=152;
BodyTubeLen=16*25.4;
MotorTubeLen=16*25.4;

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

FinInset_Len=5*Scale;
Can_Len=Fin_Root_L+FinInset_Len*2;
TailCone_Len=35;
Bolt4Inset=4;
ShockCord_a=35;// offset between PD_PetalHub and R65_BallRetainerBottom
CouplerLenXtra=-5;

module ShowRocket(ShowInternals=false, DualDeploy=false, ShowDoors=false){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	BodyTube_Z=FinCan_Z+Can_Len+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen+33.5;
	UpperBallLock_Z=EBay_Z+EBay_Len+18.5;
	NoseCone_Z=DualDeploy? MainBay_Len+29+EBay_Z+EBay_Len+2+Overlap*2:EBay_Z+EBay_Len+2+Overlap*2;

	
	//*
	translate([0,0,NoseCone_Z]){
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
		rotate([0,0,-30]) color("LightGreen")
			NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);}
	
	if (DualDeploy){
	
		if (ShowInternals==false)
			translate([0,0,UpperBallLock_Z+10]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
				Len=MainBay_Len-Overlap*2, myfn=$preview? 90:360);
		//*
		if (ShowInternals==false)
			translate([0,0,UpperBallLock_Z]) rotate([180,0,0])
				STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, 
								Body_ID=Body_ID, Skirt_Len=20);
		/**/
		translate([0,0,UpperBallLock_Z]) rotate([180,0,0]) color("Tan") R75_BallRetainerTop();
	
	}
	translate([0,0,EBay_Z]) Electronics_Bay(DualDeploy=DualDeploy, ShowDoors=ShowDoors);
	
	translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2])
		color("Tan") R75_BallRetainerTop();
	/**/
	
	if (ShowInternals){
		translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2-0.2]) R75_BallRetainerBottom();
		translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2-9.2]) rotate([0,0,200]) rotate([180,0,0]) 
			PD_PetalHub(OD=BT75Coupler_OD, nPetals=3, ShockCord_a=ShockCord_a);
		translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2-15]) 
			rotate([0,0,200]) rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=150, nPetals=3);
	}
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z+BodyTubeLen+15])
		STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	if (ShowInternals)
	translate([0,0,FinCan_Z-23]) color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, 
			Len=MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			
	translate([0,0,FinCan_Z]) color("White") FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Yellow") RocketFin();
	/**/
	
	translate([0,0,FinCan_Z-0.2]) MotorRetainer(ShowCut=false);
} // ShowRocket

//ShowRocket(DualDeploy=true, ShowDoors=true);
//ShowRocket(ShowInternals=true);

module R75_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) PD_PetalHubBoltPattern(OD=Coupler_OD, nPetals=3) Bolt4Hole();

	} // difference
} // R75_BallRetainerBottom

// translate([0,0,-8]) rotate([180,0,0]) R75_BallRetainerBottom();

//rotate([0,0,170]) PD_PetalHub(OD=Coupler_OD, nPetals=3, ShockCord_a=ShockCord_a);

module R75_BallRetainerTop(){
	// combined with NC_ShockcordRingDual(){
	
	Tube_d=12.7;
	Tube_a=-40;
	Tube_Z=25;
	CR_z=8;
	Wall_t=3;
	nBolts=3;
	BoltInset=NC_Base_L/2;
	Engagement_Len=20;
	
	difference(){
		union(){
			STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, 
						nLockBalls=nLockBalls, 
						HasIntegratedCouplerTube=true, 
							IntegratedCouplerLenXtra=CouplerLenXtra, 
							Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=false, Engagement_Len=Engagement_Len);
			
			translate([0,0,Tube_Z]) 
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-IDXtra-Wall_t*2, 
						Len=Tube_d/2+Wall_t, myfn=$preview? 90:360);
				
			// Tube holder
			rotate([0,0,Tube_a]) difference(){
				hull(){
					translate([0,0,Tube_Z])
						rotate([0,90,0]) cylinder(d=Tube_d+Wall_t*2, h=Body_ID-3, center=true);
					translate([0,0,CR_z]) cube([Body_ID-4,Tube_d,Overlap],center=true);
				} // hull
				
				// center hole
				translate([0,0,Tube_Z]) cube([Body_ID-25,Tube_d+10,55],center=true);
			} // difference
		} // union
		
		// Center hole
		//translate([0,0,-6]) cylinder(d=ST_DSpring_OD-6, h=30);
		
		//Bolt holes for electronics bay
		if (nBolts>0)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+22.5])
			translate([0,-Body_OD/2-1,Engagement_Len/2+CouplerLenXtra+13+BoltInset]) rotate([90,0,0]) Bolt4Hole();
		
		// Tube hole
		translate([0,0,Tube_Z]) rotate([0,0,Tube_a]) 
			rotate([0,90,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		//cube([50,50,50]);
	} // difference
	
} // R75_BallRetainerTop

//R75_BallRetainerTop();

module UpperRailBtnMount(){
	Len=15;
	
	difference(){
		cylinder(d=Body_ID, h=Len);
		
		// remove extra
		translate([0,0,-Overlap]) {
		 translate([10,-Body_ID/2,0]) cube([Body_ID,Body_ID,Len+Overlap*2]);
		 mirror([1,0,0]) translate([10,-Body_ID/2,0]) cube([Body_ID,Body_ID,Len+Overlap*2]);
		}
		
		// Motor tube
		translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=Len+Overlap*2);
		
		// Rail button bolt hole
		translate([0,-Body_OD/2,Len/2]) rotate([90,0,0]) Bolt8Hole();
		
		// Shock cord
		translate([0,MotorTube_OD/2+5,-1]) rotate([20,0,0]) cylinder(d=5, h=Len+5);
	} // difference

	difference(){
		rotate([0,0,90/5]) CenteringRing(OD=Body_ID, ID=MotorTubeHole_d, Thickness=3, nHoles=5, Offset=0);
		
		// Shock cord
		translate([0,MotorTube_OD/2+5,-1]) rotate([20,0,0]) cylinder(d=5, h=Len+5);
	} // difference	
	
} // UpperRailBtnMount

//UpperRailBtnMount();

module UpperRailBtnMount75(){
	Len=20;
	AlTube_d=12.7;
	
	difference(){
		union(){
			$fn=$preview? 90:360;
			CenteringRing(OD=Body_ID, ID=MotorTubeHole_d, Thickness=Len, nHoles=0, Offset=0);
			
			// Tube stop
			translate([0,0,Len-2]) 
				CenteringRing(OD=Body_ID, ID=MotorTube_ID, Thickness=2, nHoles=0, Offset=0);
		} // union
		
		// Shock cord mount
		translate([0,0,AlTube_d/2+2]) rotate([0,90,0]) cylinder(d=AlTube_d+IDXtra, h=Body_OD, center=true);
		
		// Rail button bolt hole
		translate([0,-Body_OD/2,Len-6]) rotate([90,0,0]) Bolt8Hole();
		
	} // difference
} // UpperRailBtnMount75

//UpperRailBtnMount75();

				
module RocketFin(HasSpiralVaseRibs=true){
	
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, HasSpiralVaseRibs=HasSpiralVaseRibs);
	
} // RocketFin

//RocketFin();




































