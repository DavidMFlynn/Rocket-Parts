// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket9Ball.scad
// by David M. Flynn
// Created: 11/12/2023 
// Revision: 0.9.1  11/19/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A strange rocket w/ rear ejection
//
//  ***** History *****
//
// 0.9.1  11/19/2023 Fixed transition added rail guide
// 0.9.0  11/12/2023 First Code
//
// ***********************************
//  ***** for STL output *****
//
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD+Vinyl_t, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
// NC_ShockcordRingDual(Tube_OD=Body_OD+Vinyl_t, Tube_ID=Body_ID, NC_Base_L=NC_Base_L);
// ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
// NC_PetalHub();
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=BT75Coupler_OD);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=180, nPetals=3, Wall_t=1.8, AntiClimber_h=3, HasLocks=false);
// 
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
// R98_BallRetainerBottom();
// rotate([180,0,0]) R98C_BallRetainerTop();
// Electronics_BayDual(ShowDoors=false);
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=true, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=true);

// R_9Ball_Trans();
//
// oops, not needed for next printing of R_9Ball_Trans
// rotate([-90,0,0]) RailGuideSpacer(OD=LowerBody_OD, H=RailGuide_h, Length = 30, BoltSpace=12.7);
//
// LowerElectronicsBay(ShowDoors=false);
// rotate([-90,0,0]) Batt_Door(Tube_OD=LowerBody_OD, InnerTube_OD=0, HasSwitch=true);
//
//  *** Cable Puller (2 Req) ***
// rotate([-90,0,0]) CP_Door(Tube_OD=LowerBody_OD, BoltBossInset=2, HasArmingSlot=true);
// BoltInServoMount();
// ThroughOut();
// rotate([0,90,0]) SpringBody();
// CableRetainer();
// StopAdjuster();
// CageBottom();
/*
   rotate([180,0,0]){ 
		CageTop();
		BellCrankTriggerBearingHolder();}
/**/
// rotate([180,0,0]) TriggerBellCrank();
// -----------------------------
//
// CenteringRing(OD=LowerDeploymentBayTube_ID, ID=LowerEBayTube_OD+IDXtra*2, Thickness=12, nHoles=10, Offset=0);
//
// rotate([180,0,0]) Aft_SpringEnd();
// Aft_PetalHub();
//
// MPL_OuterRace(); // includes body tube section
// MPL_InnerRace(ShowLocked=false); // the moving part
// MPL_LockBallRetainer(); // holds lock balls in place
// rotate([180,0,0]) MPL_LockRing(); // held/released by lock balls
//
// RocketFin();
// FinCan(LowerHalfOnly=false, UpperHalfOnly=false);

// rotate([180,0,0]) MPL_LockRing(OD=BT98Coupler_OD, ID=BT98Coupler_ID);
// CenteringRing(OD=BT98Coupler_ID, ID=BT54Body_OD+IDXtra*2, Thickness=3, nHoles=0);
// rotate([180,0,0]) LowerTailCone();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket();
// ShowRocket(ShowInternals=true);
//
// ***********************************
include<TubesLib.scad>
use<AT-RMS-Lib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<AltBay.scad>
use<BatteryHolderLib.scad>
use<CablePuller.scad>
use<SpringThingBooster.scad> SpringThingBoosterRev();
use<PetalDeploymentLib.scad>
use<SpringThing2.scad>
use<ThreadLib.scad>
use<TransitionLib.scad>
use<MotorPodLockLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=7;
Fin_Post_h=14;
Fin_Root_L=160;
Fin_Root_W=16;
Fin_Tip_W=6.0;
Fin_Tip_L=90;
Fin_Span=120;
Fin_TipOffset=0;
Fin_Chamfer_L=40;

Body_OD=BT98Body_OD;
Body_ID=BT98Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;
LowerBody_OD=BT137Body_OD;
LowerBody_ID=BT137Body_ID;
LowerCoupler_OD=BT137Coupler_OD;
LowerCoupler_ID=BT137Coupler_ID;
// Internal tubes
LowerEBayTube_OD=BT75Body_OD;
LowerEBayTube_ID=BT75Body_ID;
LowerDeploymentBayTube_OD=BT98Body_OD;
LowerDeploymentBayTube_ID=BT98Body_ID;

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorCoupler_OD=BT54Coupler_OD;

MotorTubeHole_d=MotorTube_OD+IDXtra*3;
/*
// Stubby
NC_Len=180;
NC_Tip_r=5;
NC_Wall_t=1.8;
NC_Base_L=15;
/**/
NC_Len=300;
NC_Tip_r=5;
NC_Wall_t=1.8;
NC_Base_L=15;

ForwardPetalLen=180;
ForwardTubeLen=10.5*25.4;
EBay_Len=162;
MotorTubeLen=10*25.4;
BodyTubeLen=16*25.4; 
LowerEBay_Len=170;
LowerTubeLen=264;
MotorModuleTube_Len=200;

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

FinInset_Len=5;
Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
nLockBalls=6;
nPetals=3;
ShockCord_a=17;// offset between PD_PetalHub and R65_BallRetainerBottom
TailCone_Len=50;
RailGuide_h=LowerBody_OD/2+2;
CouplerLenXtra=-10;
Vinyl_t=0.5; // added to diameter

// Big Spring
Spring_CS4009_OD=2.328*25.4;
Spring_CS4009_ID=2.094*25.4;
Spring_CS4009_FL=18.5*25.4;
Spring_CS4009_CL=1.64*25.4;

module ShowRocket(ShowInternals=false){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	MPL_Len=25;
	MPL_Z=FinCan_Z+Can_Len+Overlap*2;
	BodyTube_Z=MPL_Z+MPL_Len+Overlap*2;
	LowerEBay_Z=BodyTube_Z+LowerTubeLen;
	Trans_Z=LowerEBay_Z+LowerEBay_Len+10.2;
	
	AftTubeEnd_Z=BodyTube_Z+BodyTubeLen+10;
	AftBallLock_Z=BodyTube_Z+BodyTubeLen+9;
	
	EBay_Z=Trans_Z+60;
	FwdBallLock_Z=EBay_Z+EBay_Len+24.4;
	FwdTubeEnd_Z=FwdBallLock_Z+0.2;
	ForwardTube_Z=FwdTubeEnd_Z+10;
	NoseCone_Z=ForwardTube_Z+ForwardTubeLen+3.4;
	
	/*
	translate([0,0,NoseCone_Z]) color("Orange")
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
							
	translate([0,0,NoseCone_Z-0.2]) rotate([0,0,90]) NC_ShockcordRingDual();
	
	//if (ShowInternals) translate([0,0,NoseCone_Z-20]) ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
	if (ShowInternals) translate([0,0,NoseCone_Z-54.2]) rotate([180,0,0]) NC_PetalHub();
	
	if (ShowInternals) translate([0,0,NoseCone_Z-60.2]) rotate([180,0,0])
		PD_Petals(OD=Coupler_OD, Len=180, nPetals=nPetals, AntiClimber_h=3);
							
	/**/
	
	/*
	if (ShowInternals==false) translate([0,0,FwdTubeEnd_Z]) rotate([180,0,0]) color("Orange")
		STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	if (ShowInternals) translate([0,0,FwdBallLock_Z+0.2]) rotate([180,0,0]) 
		R98_BallRetainerBottom();
	translate([0,0,FwdBallLock_Z]) rotate([180,0,0]) color("White") 
		R98C_BallRetainerTop();
	translate([0,0,EBay_Z]) color("White") 
		Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoors=(ShowInternals==false));
	//translate([0,0,AftBallLock_Z]) color("White") R98C_BallRetainerTop();
	if (ShowInternals) translate([0,0,AftBallLock_Z-0.2]) 
		R98_BallRetainerBottom();
	/**/
	
	/*
	if (ShowInternals==false) translate([0,0,ForwardTube_Z]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, 
			Len=ForwardTubeLen-Overlap*2, myfn=$preview? 90:360);
	/**/
	
	/*
	if (ShowInternals) translate([0,0,AftBallLock_Z-8.8]) rotate([0,0,200]) rotate([180,0,0]) 
			PD_PetalHub(OD=Body_ID, nPetals=3, ShockCord_a=PD_ShockCordAngle());
			
	if (ShowInternals) translate([0,0,AftBallLock_Z-17]) rotate([0,0,200]) rotate([180,0,0]) 
		PD_Petals(OD=Coupler_OD, Len=150, nPetals=nPetals, AntiClimber_h=3);	
	
	if (ShowInternals) translate([0,0,MotorTubeLen+50]){
		translate([0,0,35]) SpringTop();
		ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
	}
	if (ShowInternals) translate([0,0,MotorTubeLen+12]) rotate([0,0,180]) color("Gray") MotorTubeTopper();
	/**/
	
	/*
	if (ShowInternals==false) translate([0,0,AftTubeEnd_Z]) color("Orange")
		STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	/**/
	
	//*
	translate([0,0,Trans_Z]) R_9Ball_Trans();
	
	translate([0,0,LowerEBay_Z]) LowerElectronicsBay(ShowDoors=true);
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=LowerBody_OD, ID=LowerBody_ID, 
			Len=LowerTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	if (ShowInternals==false)
		translate([0,0,MPL_Z+MPL_Z_Offset]) color("Pink") MPL_OuterRace();
	
	translate([0,0,FinCan_Z]) color("White") FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
	/**/
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([LowerBody_OD/2-Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Orange") RocketFin();
	/**/
	

	//ShowMotorModule(ShowInternals=ShowInternals);
	
	
} // ShowRocket

//ShowRocket();
//ShowRocket(ShowInternals=true);

module ShowMotorModule(ShowInternals=true){
	FinCan_Z=35;
	
	difference(){
		union(){
			translate([0,0,MotorModuleTube_Len+5]) MPL_LockRing();
			
			translate([0,0,MotorModuleTube_Len-23]) 
			 CenteringRing(OD=BT98Coupler_ID, ID=BT54Body_OD+IDXtra*2, Thickness=3, nHoles=0);
		
			CenteringRing(OD=BT98Coupler_ID, ID=BT54Body_OD+IDXtra*2, Thickness=3, nHoles=0);
			 
			color("LightBlue") translate([0,0,FinCan_Z-40]) 
				Tube(OD=Body_OD, ID=Body_ID, Len=15, myfn= 90);
			color("LightBlue") translate([0,0,FinCan_Z-40]) 
				Tube(OD=Coupler_OD, ID=Coupler_ID, Len=MotorModuleTube_Len, myfn= 90);

			if (ShowInternals) translate([0,0,FinCan_Z-75]) color("Blue") 
				Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen, myfn=90);
		
			if (ShowInternals) 
				translate([0,0,FinCan_Z-75-2]) ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true);
		
			translate([0,0,FinCan_Z-75-0.2]) LowerTailCone();
			
		} // union
		
		if (ShowInternals) translate([-10,-10,-100]) rotate([0,0,180]) cube([LowerBody_OD/2,LowerBody_OD/2,400]);
	} // difference
} // ShowMotorModule

//ShowMotorModule();

module R98_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, 
				nLockBalls=nLockBalls, HasSpringGroove=false);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) 
			PD_PetalHubBoltPattern(OD=Coupler_OD, nPetals=nPetals) Bolt4Hole();

	} // difference
} // R98_BallRetainerBottom

// translate([0,0,-9]) rotate([180,0,0]) R98_BallRetainerBottom();
//rotate([0,0,152]) PD_PetalHub(Coupler_OD=Coupler_OD, nPetals=nPetals, ShockCord_a=PD_ShockCordAngle());

module NC_PetalHub(){
	ST_DSpring_OD=44.30;
	ST_DSpring_ID=40.50;
	BodyTube_L=20;
	nHoles=6;
	
	// Body tube interface
	translate([0,0,-BodyTube_L]) Tube(OD=Body_ID-IDXtra*2, 
									ID=Body_ID-IDXtra*2-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
	difference(){
		union(){
			PD_PetalHub(OD=Body_ID-IDXtra*2, nPetals=nPetals, HasBolts=false, ShockCord_a=-1);
			
			translate([0,0,-BodyTube_L]) Tube(OD=ST_DSpring_ID-IDXtra*2, 
									ID=ST_DSpring_ID-IDXtra*2-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
		} // union
			
		// Center Hole
		translate([0,0,-BodyTube_L-Overlap]) cylinder(d=ST_DSpring_ID-IDXtra*2-4.4, h=50, $fn=$preview? 90:360);
		
		// Retention cord
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*(j+0.5)]) {
				translate([0,Coupler_ID/2-5,-10]) cylinder(d=4, h=30);
				translate([0,Coupler_ID/2-5,5]) cylinder(d=8, h=30);
			}
	} // difference
} // NC_PetalHub

// NC_PetalHub();

module Aft_PetalHub(){
	Spring_OD=Spring_CS4009_OD;
	Spring_ID=Spring_CS4009_ID;
	BodyTube_L=20;
	nHoles=6;
	CenterHole_d=44;
	
	// Body tube interface
	translate([0,0,-BodyTube_L]) Tube(OD=Body_ID-IDXtra*2, 
									ID=Body_ID-IDXtra*2-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
	difference(){
		union(){
			PD_PetalHub(OD=Body_ID-IDXtra*2, nPetals=nPetals, HasBolts=false, ShockCord_a=-1);
			
			translate([0,0,-BodyTube_L]) Tube(OD=Spring_ID-IDXtra*2, 
									ID=Spring_ID-IDXtra*2-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
		} // union
			
		// Center Hole
		hull(){
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=7, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) cylinder(d=Spring_ID-IDXtra*2-4.4, h=1, $fn=$preview? 90:360);
		}
		
		// Retention cord
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*(j+0.5)]) {
				translate([0,Coupler_ID/2-5,-10]) cylinder(d=4, h=30);
				translate([0,Coupler_ID/2-5,5]) cylinder(d=8, h=30);
			}
	} // difference
} // Aft_PetalHub

// Aft_PetalHub();

module Aft_SpringEnd(){
	Spring_OD=Spring_CS4009_OD;
	Spring_ID=Spring_CS4009_ID;
	BodyTube_L=Spring_CS4009_CL-5;
	Tube_ID=LowerEBayTube_ID;
	nHoles=6;
	CenterHole_d=Spring_ID-IDXtra*2-4.4;
	Al_Tube_d=12.7;
	Al_Tube_Z=Al_Tube_d/2+2.5;
	
					
	difference(){
		union(){
			// Body tube interface
			translate([0,0,-BodyTube_L]) 
				Tube(OD=Tube_ID-IDXtra*2, 
					ID=Tube_ID-IDXtra*2-4.4, Len=BodyTube_L+Al_Tube_d+5, myfn=$preview? 90:360);
					
			CenteringRing(OD=Tube_ID-IDXtra*2, ID=CenterHole_d, Thickness=5, nHoles=0, Offset=0);
			
			translate([0,0,-BodyTube_L]) Tube(OD=Spring_ID-IDXtra*2, 
									ID=Spring_ID-IDXtra*2-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
			translate([0,0,Al_Tube_Z]) 
				rotate([0,90,0]) cylinder(d=Al_Tube_d+5, h=Tube_ID-2.6, center=true);
		} // union
			
		// Center Hole
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=20, $fn=$preview? 90:360);
		
		translate([0,0,Al_Tube_Z]) 
			rotate([0,90,0]) cylinder(d=Al_Tube_d, h=Tube_ID+1, center=true);
		
		// Retention cord
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j]) 
				translate([0,Tube_ID/2-5,-10]) cylinder(d=4, h=50);
			
	} // difference
} // Aft_SpringEnd

// Aft_SpringEnd();



module R_9Ball_Trans(){
	Coupler_Len=25;
	// Adjusted OD of lower coupler 11/19/23 after first printing
	Al_Tube_d=12.7;
	Al_Tube_Z=65;
	TopShoulder_h=4+Al_Tube_d;
	RG_Z=6;
	
	difference(){
		union(){
			Transition(
				Ratio=2.5, 							// Angle of transition
				OD1=LowerBody_OD+Vinyl_t, 			// Lower Body OD, Must be large end
				OD2=Body_OD+Vinyl_t, 				// Upper Body OD
				C1_OD=LowerBody_ID-IDXtra, 			// Lower Coupler OD
				C1_ID=LowerBody_ID-4.4-IDXtra*2, 	// Lower Coupler ID and Center Hole
				C1_Len=15, 							// Lower Coupler Length
				C2_OD=Body_ID-IDXtra*2,				// Upper Coupler OD
				C2_ID=LowerEBayTube_OD+IDXtra*2,	// Upper Coupler ID and Center Hole
				C2_Len=TopShoulder_h				// Upper Coupler Length
					);
					
			// Centering ring				
			translate([0,0,-Coupler_Len])
				CenteringRing(OD=LowerBody_ID-1, ID=LowerEBayTube_OD+IDXtra*2, 
								Thickness=5, nHoles=0, Offset=0);
					
			// Upper Rail Guide
			translate([0,0,RG_Z]) rotate([0,0,90])
				RailGuideSpacer(OD=LowerBody_OD-20, H=RailGuide_h, Length = 30, BoltSpace=12.7);
		} // union
		
		// Rail guide bolt holes
		translate([-RailGuide_h,0,RG_Z]) rotate([0,0,90])
			RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Aluminum tube, shock cord mount
		translate([0,0,Al_Tube_Z]) rotate([0,90,0]) cylinder(d=Al_Tube_d, h=Body_OD, center=true);
		
		// wire path
		translate([0,LowerEBayTube_OD/2+10,-Coupler_Len-Overlap]) cylinder(d=10, h=10);
		
		for (j=[0:4]) hull(){
			rotate([0,0,j-3]) translate([0,LowerEBayTube_OD/2+5,0]) cylinder(d=5, h=100);
			rotate([0,0,j-2]) translate([0,LowerEBayTube_OD/2+5,0]) cylinder(d=5, h=100);
		} // for hull
		
	} // difference
} // R_9Ball_Trans

//translate([0,0,400]) R_9Ball_Trans();

module Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoors=false){
	// made NC coupler IDXtra smaller 6/22/23

	Len=EBay_Len;
	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2-5;

	Alt1_a=0;
	Alt2_a=180;
	Batt1_a=Alt1_a+75;
	Batt2_a=Alt2_a+75;
	
	
	difference(){
		Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	// Battery and Switch doors
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	
	
} // Electronics_BayDual

// translate([0,0,LowerEBay_Len+10.2+59]) Electronics_BayDual(ShowDoors=false);
// translate([0,0,LowerEBay_Len+10.2]) R_9Ball_Trans();

module LowerElectronicsBay(Tube_OD=LowerBody_OD+Vinyl_t, Tube_ID=LowerBody_ID, ShowDoors=false){

	Wall_t=(Tube_OD-Tube_ID)/2;
	Coupler_Len=15;
	Len=LowerEBay_Len;
	BattSwDoor_Z=Len/2;
	CP_Door_Z=Len/2;

	//Alt_a=0;
	Batt1_a=0;
	Batt2_a=180;
	CP1_a=60;
	CP2_a=180+60;
	
	// Centering rings
	difference(){
		union(){
			translate([0,0,-Coupler_Len])
				CenteringRing(OD=LowerBody_ID-1, ID=Body_OD+IDXtra*2, 
								Thickness=8+Overlap, nHoles=0, Offset=0);
			translate([0,0,-Coupler_Len+8])
				CenteringRing(OD=LowerBody_ID-1, ID=LowerEBayTube_OD+IDXtra*2, 
								Thickness=5, nHoles=0, Offset=0);
		} // union
		
		// cable paths
		translate([0,0,-Coupler_Len-Overlap]) rotate([0,0,CP1_a]) 
			translate([0,LowerBody_OD/2-10,0]) cylinder(d=10, h=30);
		translate([0,0,-Coupler_Len-Overlap]) rotate([0,0,CP2_a]) 
			translate([0,LowerBody_OD/2-10,0]) cylinder(d=10, h=30);
	} // difference
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 90:360);
		
			// integrated coupler
			translate([0,0,-Coupler_Len])
				Tube(OD=Tube_ID-IDXtra, ID=Tube_ID-4, Len=Coupler_Len+Overlap, myfn=$preview? 36:360);
			difference(){
				Tube(OD=Tube_OD-1, ID=Tube_ID-4, Len=5, myfn=$preview? 36:360);
				translate([0,0,-Overlap]) cylinder(d2=Tube_ID+Overlap, d1=Tube_ID-4-Overlap, h=5+Overlap*2);
			} // difference
		} // union
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,CP_Door_Z]) rotate([0,0,CP1_a]) 
			CP_BayFrameHole(Tube_OD=Tube_OD);
		translate([0,0,CP_Door_Z]) rotate([0,0,CP2_a]) 
			CP_BayFrameHole(Tube_OD=Tube_OD);
	} // difference
	
	// Battery and Switch doors
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
		
	// Cable Puller doors
	translate([0,0,CP_Door_Z]) rotate([0,0,CP1_a]) 
		CP_BayDoorFrame(Tube_OD=Tube_OD, ShowDoor=ShowDoors);
	translate([0,0,CP_Door_Z]) rotate([0,0,CP2_a]) 
		CP_BayDoorFrame(Tube_OD=Tube_OD, ShowDoor=ShowDoors);
	
} // LowerElectronicsBay

// LowerElectronicsBay(ShowDoors=false);
// LowerElectronicsBay(ShowDoors=true);
// translate([0,0,LowerEBay_Len+10.2]) R_9Ball_Trans();

module BigSpringMiddle(){
	Len=300;
	nRopes=6;

	Tube(OD=Spring_CS4009_OD+5.4, ID=Spring_CS4009_OD+1, Len=Len, myfn=$preview? 90:360);
	Tube(OD=BT75Coupler_OD, ID=BT75Coupler_ID, Len=Len-37, myfn=$preview? 90:360);
	
	difference(){
		translate([0,0,Len/2-4]) 
			Tube(OD=BT75Coupler_OD-1, ID=Spring_CS4009_ID-1, Len=8, myfn=$preview? 90:360);
			
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j])
			translate([0,(Spring_CS4009_OD+5.4)/2+2,Len/2-5]) cylinder(d=4, h=10);
	} // difference
} // BigSpringMiddle

//BigSpringMiddle();

module R98C_BallRetainerTop(){
	Tube_d=12.7;
	Tube_Z=31;
	Tube_a=-6;
	TubeSlot_w=Body_ID-35; //35;
	TubeOffset_X=0; //22;
	
	difference(){
		union(){
			STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls,
								HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=CouplerLenXtra,
								Body_ID=Body_ID-IDXtra, HasSecondServo=true, UsesBigServo=true);
				
			translate([0,0,35.5]) Tube(OD=Body_ID-IDXtra, ID=Body_ID-IDXtra-6, Len=5, myfn=$preview? 90:360);
			
			// Shock cord retention
			difference(){
				union(){
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
						rotate([90,0,0]) cylinder(d=Tube_d+6, h=Body_ID-2, center=true);
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z-12.2])
						cube([Tube_d-3, Body_ID-2, 21], center=true);
				} // union
				
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
					rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z-12.2])
					cube([Tube_d-1, TubeSlot_w,21.1], center=true);
					
				Tube(OD=Body_OD+20, ID=Body_ID-1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
	
		translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,Tube_a]) cylinder(d=Tube_d, h=Body_OD, center=true);
	} // difference
} // R98C_BallRetainerTop

// rotate([180,0,0]) R98C_BallRetainerTop();

FCCoupler_Len=10; // fincan's integrated coupler

module FinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	Wall_t=1.2;
	FinBox_W=Fin_Root_W+Wall_t*2;
	RailGuide_Z=25;
	OD=LowerBody_OD+Vinyl_t;
	Body_ID=LowerBody_ID;
	InnerTubeHole_d=Body_OD+IDXtra*3;
	
	
	difference(){
		union(){
			// Body Tube
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Can_Len, myfn=$preview? 90:360);
			// Motor Tube Sleeve
			Tube(OD=InnerTubeHole_d+Wall_t*2, ID=InnerTubeHole_d, Len=Can_Len, myfn=$preview? 90:360);
			
			// integrated coupler
			translate([0,0,Can_Len-Overlap])
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-4, Len=FCCoupler_Len, myfn=$preview? 36:360);
			difference(){
				translate([0,0,Can_Len-5])
					Tube(OD=OD-1, ID=Body_ID-4, Len=5, myfn=$preview? 36:360);
				translate([0,0,Can_Len-5-Overlap]) cylinder(d1=OD-Wall_t*2, d2=Body_ID-5, h=5);
			} // difference
			
			// Upper Centering Ring
			//translate([0,0,Can_Len-3])
			//	CenteringRing(OD=OD-1, ID=Body_ID-10, Thickness=3, nHoles=0, Offset=0);
				
			// Middle Centering Rings
			translate([0,0,Can_Len/2-3])
				rotate([0,0,180/nFins])
					CenteringRing(OD=OD-1, ID=InnerTubeHole_d, Thickness=6, nHoles=nFins, Offset=0);
			
			// Fin Boxes
			difference(){
				for (j=[0:nFins]) rotate([0,0,360/nFins*j]) 
					translate([0,-FinBox_W/2,0]) cube([OD/2,FinBox_W,Can_Len]);
					
				difference(){
					translate([0,0,-Overlap]) cylinder(d=OD+10, h=Can_Len+Overlap*2);
					translate([0,0,-Overlap*2]) cylinder(d=OD-1, h=Can_Len+Overlap*4);
				} // difference
				
				translate([0,0,-Overlap]) cylinder(d=InnerTubeHole_d, h=Can_Len+Overlap*2);
			} // difference
			
			translate([0,0,-75]) UpperTailCone();
			
			// Rail guide bolt boss
			translate([0,0,RailGuide_Z]) rotate([0,0,90]) 
				RailGuidePost(OD=OD, MtrTube_OD=InnerTubeHole_d, H=RailGuide_h, 
					TubeLen=50, Length = 30, BoltSpace=12.7);
		} // union
	
		// Fin Sockets
		translate([0,0,Fin_Root_L/2+FinInset_Len])
			TrapFin2Slots(Tube_OD=OD, nFins=nFins, Post_h=Fin_Post_h, 
					Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		// Rail guide bolt holes
		translate([-RailGuide_h,0,RailGuide_Z]) rotate([0,0,90]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		if (LowerHalfOnly) translate([0,0,Can_Len/2]) cylinder(d=OD+1, h=Can_Len/2+50);
		if (UpperHalfOnly) translate([0,0,Can_Len/2]) 
			rotate([180,0,0]) cylinder(d=OD+10, h=Can_Len/2+50);
			
		if ($preview) cube([OD/2+5,OD/2+5,Can_Len+50]);
	} // difference
} // FinCan

//rotate([180,0,0]) FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
/*
color("LightBlue") translate([0,0,-25]) Tube(OD=Body_OD, ID=Body_ID, Len=Can_Len+200, myfn= 90);

color("LightBlue") translate([0,0,-40]) Tube(OD=Body_OD, ID=Body_ID, Len=15, myfn= 90);
color("LightBlue") translate([0,0,-40]) Tube(OD=Coupler_OD, ID=Coupler_ID, Len=300, myfn= 90);

color("Green") translate([0,0,-75]) Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=300, myfn= 90);

translate([0,0,-75-2]) ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true);
/**/

module UpperTailCone(){ // part of fincan
	Tail_r=20;
	
	difference(){
		
		hull(){
			cylinder(d=MotorTube_OD+12, h=Overlap, $fn=$preview? 90:360);
			
			translate([0,0,75])
			difference(){
				rotate_extrude($fn=$preview? 90:360) translate([LowerBody_OD/2-Tail_r,0,0]) circle(r=Tail_r);
				translate([0,0,Overlap]) cylinder(d=LowerBody_OD+1,h=50);
			}
		} // hull
		
		translate([0,0,35]) cylinder(d=Body_OD+IDXtra*2, h=50, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) cylinder(d=LowerBody_OD+2, h=50);
		//cylinder(d1=MotorTube_OD+12, d2=Body_OD+12, h=50);
		
		// Motor tube
		//cylinder(d=MotorTubeHole_d, h=100);
		// Aluminum motor retainer
		//translate([0,0,-Overlap]) cylinder(d=63, h=15);
		
	} // difference
	
} // UpperTailCone

//translate([0,0,-75]) UpperTailCone();

module LowerTailCone(){
	Tail_r=20;
	
	difference(){
		
		hull(){
			cylinder(d=MotorTube_OD+12, h=Overlap, $fn=$preview? 90:360);
			
			translate([0,0,75])
			difference(){
				rotate_extrude($fn=$preview? 90:360) translate([LowerBody_OD/2-Tail_r,0,0]) circle(r=Tail_r);
				translate([0,0,Overlap]) cylinder(d=LowerBody_OD+1,h=50);
			}
		} // hull
		
		translate([0,0,35]) cylinder(d=Body_OD+IDXtra*2, h=16, $fn=$preview? 90:360);
		translate([0,0,50-Overlap]) cylinder(d=LowerBody_OD+2, h=50);
		//cylinder(d1=MotorTube_OD+12, d2=Body_OD+12, h=50);
		
		// Motor tube
		cylinder(d=MotorTubeHole_d, h=100);
		// Aluminum motor retainer
		translate([0,0,-Overlap]) cylinder(d=63, h=15);
		
	} // difference
} // LowerTailCone

//translate([0,0,-75-0.2]) LowerTailCone();
	
module RocketFin(){
	
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100);
				
	if ($preview==false){
		translate([-Fin_Root_L/2+4,0,0]) 
			cylinder(d=12, h=0.9); // Neg
		translate([Fin_Root_L/2-4,0,0]) 
			cylinder(d=12, h=0.9); // Pos
	}
	
} // RocketFin

//RocketFin();










