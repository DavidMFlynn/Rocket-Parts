// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket98C.scad
// by David M. Flynn
// Created: 10/23/2023 
// Revision: 1.0.2  10/30/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Upscale of Rocket65
//  Rocket with 98mm Body and 54mm motor. 
//
//  Dual deploy:
//   Mission Control V3 / RocketServo
//
//  ***** Parts *****
//
// BlueTube 2.0 4" Body Tube by 10.5 inches Forward Bay
// BlueTube 2.0 4" Body Tube by 19 inches minimum Lower Body
// Blue Tube 2.1" Body Tube by 19.5 inches minimum Motor Tube (Fits 54/1706 case)
// Drogue parachute
// 63" Parachute
// 1/2" Braided Nylon Shock Cord (40 feet)
//
//  ***** Hardware *****
//
// #6-32 x 3/4" Button Head Cap Screw (4 req) Rail Guides
// #4-40 x 1/2" Socket Head Cap Screw (12 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (14 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #4-40 x 1/4" Button Head Cap Screw (12 req) Petals
// #4-40 x 3/8" Button Socket Head Cap Screw (8 req) Servos
// 1/2" x 0.035" wall Aluminum tubing 2ea 92mm, 2ea 80mm Shock cord mounts
// MR84-2RS Bearing (16 req) Ball Lock
// 3/8" Delrin Ball (12 req) Ball Lock
// 4mm Dia. x 10mm Undersize Steel Dowel (12 req) Ball Lock
// 4mm Dia. x 16mm Undersize Steel Dowel (6 req) Ball Lock
// 3/16" Dia x 1/8" Disc Magnet N42 (4 req) Ball Lock
// HX5010 or Eqiv. Standard Servo (2 req) Ball Lock
// C&K Rotary Switch (2 req) Battery Door
// Mission Control V3 Altimeter PCBA
// Rocket Servo PCBA (2 req)
// 1/4" Rail Guides (30mm long) (2 req)
// Spring 0.3" Dia x 1.25" PN:CS3715 (6 Req) Petals
// Spring 1.4" Dia x 8" PN:CS4323 (4 Req) Deployment
//
//  ***** History *****
//
// 1.0.2  10/30/2023 Ready for first printing.
// 1.0.1  10/29/2023 Added MotorTubeTopper(), removed obsolete routines
// 1.0.0  10/23/2023 Copied from Rocket75C Rev 1.1.1
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);

// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=120, LowerPortion=false);

// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=120, Transition_OD=BT75Body_OD-18, LowerPortion=true);
//
CouplerLenXtra=-10;
//
// *** Dual Deploy Electronics Bay ***
//
// NC_ShockcordRingDual();
// ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
// NC_PetalHub();
// rotate([-90,0,0]) PD_PetalSpringHolder(Coupler_OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(Coupler_OD=Coupler_OD, Len=ForwardPetalLen, nPetals=nPetals, AntiClimber_h=3);
//
// Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID,ShowDoors=false);
//
// *** Doors ***
//
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=true, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=true);
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=false);
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls);
// rotate([180,0,0]) R98C_BallRetainerTop();
// R98_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
// *** petal deployer ***
//
// PD_PetalHub(Coupler_OD=Coupler_OD, nPetals=nPetals, ShockCord_a=PD_ShockCordAngle());
// rotate([-90,0,0]) PD_PetalSpringHolder(Coupler_OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(Coupler_OD=Coupler_OD, Len=AftPetalLen, nPetals=nPetals, AntiClimber_h=3);
//
// rotate([180,0,0]) SpringTop();
// ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
// MotorTubeTopper();
//
// *** Fin Can ***
//
// rotate([180,0,0]) FinCan(Cone_Len=TailCone_Len, LowerHalfOnly=false, UpperHalfOnly=false); // one piece
// rotate([180,0,0]) FinCan(Cone_Len=TailCone_Len, LowerHalfOnly=true, UpperHalfOnly=false); // bottom only
// FinCan(Cone_Len=TailCone_Len, LowerHalfOnly=false, UpperHalfOnly=true); // top only
// RocketFin();
// MotorRetainer(Cone_Len=TailCone_Len);
//
// rotate([90,0,0]) BoltOnRailGuide(Length = 30, BoltSpace=12.7, RoundEnds=true);
// rotate([-90,0,0]) RailGuideSpacer(OD=Body_OD, H=RailGuide_h, Length = 30, BoltSpace=12.7);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// 
ShowRocket();
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
use<SpringThingBooster.scad> SpringThingBoosterRev();
use<PetalDeploymentLib.scad>
use<SpringThing2.scad>
use<ThreadLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Scale=1.46726; //BT98Coupler_OD/LOC65Body_OD
echo("Scale on Rocket65 = ",Scale);

nFins=5;
Fin_Post_h=12;
Fin_Root_L=160*Scale;
Fin_Root_W=6*Scale;
Fin_Tip_W=3.0;
Fin_Tip_L=70*Scale;
Fin_Span=70*Scale;
Fin_TipOffset=20*Scale;
Fin_Chamfer_L=18*Scale;

Body_OD=BT98Body_OD;
Body_ID=BT98Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorCoupler_OD=BT54Coupler_OD;

MotorTubeHole_d=MotorTube_OD+IDXtra*3;

NC_Len=180*Scale;
NC_Tip_r=5*Scale;
NC_Wall_t=1.8;
NC_Base_L=15;

ForwardPetalLen=180;
ForwardTubeLen=10.5*25.4;
EBay_Len=162;
AftPetalLen=150;
MotorTubeLen=19.5*25.4;
BodyTubeLen=19*25.4; // Range 19-22

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

FinInset_Len=5*Scale;
Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
nLockBalls=6;
nPetals=3;
ShockCord_a=17;// offset between PD_PetalHub and R65_BallRetainerBottom
TailCone_Len=50;
RailGuide_h=Body_OD/2+2;

module ShowRocket(ShowInternals=false){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	BodyTube_Z=FinCan_Z+Can_Len+Overlap*2;
	AftTubeEnd_Z=BodyTube_Z+BodyTubeLen+10;
	AftBallLock_Z=BodyTube_Z+BodyTubeLen+9;
	EBay_Z=AftBallLock_Z+24.5;
	FwdBallLock_Z=EBay_Z+EBay_Len+24.4;
	FwdTubeEnd_Z=FwdBallLock_Z+0.2;
	ForwardTube_Z=FwdTubeEnd_Z+10;
	NoseCone_Z=ForwardTube_Z+ForwardTubeLen+3.4;
	
	//*
	translate([0,0,NoseCone_Z]) color("Orange")
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
							
	translate([0,0,NoseCone_Z-0.2]) rotate([0,0,90]) NC_ShockcordRingDual();
	
	if (ShowInternals) translate([0,0,NoseCone_Z-20]) ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
	if (ShowInternals) translate([0,0,NoseCone_Z-54.2]) rotate([180,0,0]) NC_PetalHub();
	
	if (ShowInternals) translate([0,0,NoseCone_Z-60.2]) rotate([180,0,0])
		PD_Petals(Coupler_OD=Coupler_OD, Len=180, nPetals=nPetals, AntiClimber_h=3);
							
	/**/
	
	//*
	if (ShowInternals==false) translate([0,0,FwdTubeEnd_Z]) rotate([180,0,0]) color("Orange")
		STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	if (ShowInternals) translate([0,0,FwdBallLock_Z+0.2]) rotate([180,0,0]) 
		R98_BallRetainerBottom();
	translate([0,0,FwdBallLock_Z]) rotate([180,0,0]) color("White") 
		R98C_BallRetainerTop();
	translate([0,0,EBay_Z]) color("White") 
		Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoors=(ShowInternals==false));
	translate([0,0,AftBallLock_Z]) color("White") 
		R98C_BallRetainerTop();
	if (ShowInternals) translate([0,0,AftBallLock_Z-0.2]) 
		R98_BallRetainerBottom();
	/**/
	
	//*
	if (ShowInternals==false) translate([0,0,ForwardTube_Z]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, 
			Len=ForwardTubeLen-Overlap*2, myfn=$preview? 90:360);
	/**/
	
	//*
	if (ShowInternals) translate([0,0,AftBallLock_Z-8.8]) rotate([0,0,200]) rotate([180,0,0]) 
			PD_PetalHub(Coupler_OD=Body_ID, nPetals=3, ShockCord_a=PD_ShockCordAngle());
			
	if (ShowInternals) translate([0,0,AftBallLock_Z-17]) rotate([0,0,200]) rotate([180,0,0]) 
		PD_Petals(Coupler_OD=Coupler_OD, Len=150, nPetals=nPetals, AntiClimber_h=3);	
	
	if (ShowInternals) translate([0,0,MotorTubeLen+50]){
		translate([0,0,35]) SpringTop();
		ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
	}
	if (ShowInternals) translate([0,0,MotorTubeLen+12]) rotate([0,0,180]) color("Gray") MotorTubeTopper();
	/**/
	
	if (ShowInternals==false) translate([0,0,AftTubeEnd_Z]) color("Orange")
		STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,FinCan_Z]) color("White") FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Orange") RocketFin();
	/**/
	
	if (ShowInternals) translate([0,0,12]) color("Blue") 
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen, myfn=90);
	
	if (ShowInternals) translate([0,0,12]) ATRMS_54_1706_Motor(Extended=true, HasEyeBolt=true);
	
	translate([0,0,FinCan_Z-0.2]) color("Orange") MotorRetainer();
} // ShowRocket

//ShowRocket();
//ShowRocket(ShowInternals=true);

module R98_UpperSpringMiddle(){
// costom version of ST_SpringMiddle()

	ST_DSpring_OD=44.30;
	ST_DSpring_ID=40.50;
	Len=48;
	nRopes=6;
	OD=93;
	
	Tube(OD=ST_DSpring_OD+6, ID=ST_DSpring_OD+IDXtra*3, 
			Len=Len, myfn=$preview? 90:360);
			
	translate([0,0,Len*0.4]) Tube(OD=ST_DSpring_ID-0.5, ID=ST_DSpring_ID-6, 
			Len=Len*0.6, myfn=$preview? 90:360);
			
	translate([0,0,Len/2-1.5]) Tube(OD=ST_DSpring_OD+1, ID=ST_DSpring_ID-5, 
			Len=3, myfn=$preview? 90:360);
			
	Tube(OD=OD, ID=89, 
			Len=35, myfn=$preview? 90:360);
	difference(){
		cylinder(d1=92, d2=ST_DSpring_OD+1, h=35);
		
		translate([0,0,-3]) cylinder(d1=92, d2=ST_DSpring_OD+1, h=35);
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_OD+1, h=35+Overlap*2);
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-7,-Overlap])
			cylinder(d=10,h=Len);
	} // difference


} // R98_UpperSpringMiddle

//R98_UpperSpringMiddle();

module R98_LowerSpringMiddle(){
// costom version of ST_SpringMiddle()

	ST_DSpring_OD=44.30;
	ST_DSpring_ID=40.50;
	Len=40;
	nRopes=6;
	OD=Coupler_OD;
	
	Tube(OD=ST_DSpring_OD+IDXtra*3+4.4, ID=ST_DSpring_OD+IDXtra*3, 
			Len=Len, myfn=$preview? 90:360);
			
	Tube(OD=ST_DSpring_ID-0.5, ID=ST_DSpring_ID-0.5-4.4, 
			Len=Len, myfn=$preview? 90:360);
			
	translate([0,0,Len/2-1.5]) Tube(OD=ST_DSpring_OD+1, ID=ST_DSpring_ID-5, 
			Len=3, myfn=$preview? 90:360);
			
	Tube(OD=OD, ID=OD-4.4, 
			Len=35, myfn=$preview? 90:360);
	difference(){
		cylinder(d1=OD-1, d2=ST_DSpring_OD+1, h=35);
		
		translate([0,0,-3]) cylinder(d1=92, d2=ST_DSpring_OD+1, h=35);
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_OD+1, h=35+Overlap*2);
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-7,-Overlap])
			cylinder(d=10,h=Len);
	} // difference


} // R98_LowerSpringMiddle

//R98_LowerSpringMiddle();

module R98_LowerSpringBottom(){
// costom version of ST_SpringMiddle()

	ST_DSpring_OD=44.30;
	ST_DSpring_ID=40.50;
	Len=12;
	nRopes=6;
	OD=Coupler_OD;
	
	//Tube(OD=ST_DSpring_OD+IDXtra*3+4.4, ID=ST_DSpring_OD+IDXtra*3, 
	//		Len=Len, myfn=$preview? 90:360);
			
	//Tube(OD=ST_DSpring_ID-0.5, ID=ST_DSpring_ID-0.5-4.4, 
	//		Len=Len, myfn=$preview? 90:360);
			
	//translate([0,0,Len/2-1.5]) Tube(OD=ST_DSpring_OD+1, ID=ST_DSpring_ID-5, 
	//		Len=3, myfn=$preview? 90:360);
			
	Tube(OD=OD, ID=OD-4.4, 
			Len=Len, myfn=$preview? 90:360);
			
	difference(){
		translate([0,0,Len-5]) cylinder(d=OD-1, h=5);
		
		translate([0,0,Len-3]) cylinder(d=ST_DSpring_OD, h=5);
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_ID-1, h=35+Overlap*2);
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-7,-Overlap])
			cylinder(d=4,h=Len+Overlap*2);
	} // difference


} // R98_LowerSpringBottom

//rotate([180,0,0]) R98_LowerSpringBottom();


module R98_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, 
				nLockBalls=nLockBalls, HasSpringGroove=false);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) 
			PD_PetalHubBoltPattern(Coupler_OD=Coupler_OD, nPetals=nPetals) Bolt4Hole();

	} // difference
} // R98_BallRetainerBottom

// translate([0,0,-9]) rotate([180,0,0]) R98_BallRetainerBottom();
//rotate([0,0,152]) PD_PetalHub(Coupler_OD=Coupler_OD, nPetals=nPetals, ShockCord_a=PD_ShockCordAngle());


module NC_ShockcordRing(){
	Plate_t=4;
	Tube_d=12.7;
	EBayCouplerID=Body_ID-IDXtra-4.4;
	
	Tube(OD=EBayCouplerID-IDXtra*2, ID=EBayCouplerID-10, Len=5, myfn=$preview? 36:360);
	difference(){
		union(){
			translate([0,0,4])
				cylinder(d1=Body_OD-NC_Wall_t*2-IDXtra*2, d2=Body_OD-NC_Wall_t*2-IDXtra*4, h=Plate_t);
				
			hull(){
				translate([0,0,7+Tube_d/2]) 
					rotate([0,90,0]) cylinder(d=Tube_d+4.4, h=EBayCouplerID-2, center=true);
					
				translate([0,0,6]) cube([EBayCouplerID-2,Tube_d+8,Overlap],center=true);
			} // hull
		} // union
		
		cylinder(d=	Body_OD-30, h=30);
		
		translate([0,0,7+Tube_d/2]) rotate([0,90,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
	} // difference
	
} // NC_ShockcordRing

//NC_ShockcordRing();

module SpringTop(){
	ST_DSpring_OD=44.30;
	nRopes=6;
	Piston_Len=50;
	
	translate([0,0,-10]) Tube(OD=Coupler_OD, ID=Coupler_OD-4.4, Len=Piston_Len, myfn=$preview? 90:360);
	
	
	difference(){
		union(){
			cylinder(d=MotorCoupler_OD, h=10+Overlap);
			
			//translate([0,0,10]) cylinder(d=Coupler_OD, h=2+Overlap);
			translate([0,0,10]) cylinder(d=Coupler_OD, h=5+Overlap);
			//translate([0,0,10]) Tube(OD=Coupler_ID-1, ID=Coupler_ID-6, Len=10, myfn=$preview? 36:360);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d1= MotorCoupler_OD-4.4, d2=ST_DSpring_OD, h=10);
		cylinder(d= ST_DSpring_OD, h=13);
		cylinder(d= ST_DSpring_OD-6, h=20);
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,Coupler_OD/2-7,-Overlap])
			cylinder(d=4,h=Piston_Len+Overlap*2);
	} // difference
} // SpringTop

//rotate([180,0,0]) 
//translate([0,0,50]) 
//SpringTop();

module FW_GPS_SW_Hole(a=0){
	translate([-4,-1.6-1,-1]) 
		rotate([0,-90+a,0]) cylinder(d=1.7, h=100);
} // FW_GPS_SW_Hole

module FW_GPS_Mount(){
	Boss_d=12;
	
	module Boss(){
		difference(){
			rotate([-90,0,0]) cylinder(d1=7,d2=Boss_d,h=8);
				
			rotate([90,0,0]) Bolt4Hole();
		} // difference
	} // Boss
	
	// Backing plate
	translate([-4,6,-8]) 
	hull(){
		cube([20.4+8,3,42+12]);
		cube([20.4+8,10,1]);
	}
	
	translate([4,0,13.5]){
		Boss();
		translate([12.7,0,25.4]) Boss();
		}
		
	/*
	// Switch access
	translate([-4,-1.6-1,-1]) 
	rotate([0,90,0])
	difference(){
		hull(){
			cylinder(d=4, h=4);
			translate([4,10,0]) cylinder(d=4, h=4);
		} // hull
		
		translate([0,0,-Overlap]) cylinder(d=1.7, h=5);
	}
	/**/
} // FW_GPS_Mount
	
//FW_GPS_Mount();
	
module NC_ShockcordRingDual(){
	// Connects nosecone to deployment tube
	// Has aluminum tube shock cord mount
	// Has spring end and resess for spring into nosecone
	// Mount for Featherweight GPS tracker

	Plate_t=4;
	nHoles=6;
	nRivets=3;
	Rivet_d=4;
	Tube_d=12.7;
	Tube_Z=30;
	CR_z=-3;
	ST_DSpring_OD=44.30;
	BodyTube_L=15;
	SpringEnd_Z=Tube_Z-Tube_d/2-3;
	SpringSplice_OD=BT54Body_ID;
	
	difference(){
		union(){
			translate([-4,-34,4]) FW_GPS_Mount();
			
			// Stop ring
			translate([0,0,CR_z]) Tube(OD=Body_OD, ID=Body_ID-2, Len=3, myfn=$preview? 90:360);
	
			// Nosecone interface
			translate([0,0,-1]) Tube(OD=Body_ID-IDXtra*2, 
									ID=Body_ID-IDXtra*2-4.4, Len=NC_Base_L+1, myfn=$preview? 90:360);
			// Body tube interface
			translate([0,0,-BodyTube_L-3]) Tube(OD=Body_ID, 
									ID=Body_ID-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
				
			// Stiffener Plate
			translate([0,0,-5])
				cylinder(d=Body_ID-1, h=6);
				
			// Tube holder
			hull(){
				translate([0,0,Tube_Z]) 
					rotate([0,90,0]) cylinder(d=Tube_d+4.4, h=Body_ID-8, center=true);
				translate([0,0,CR_z+5]) cube([Body_ID-4, Tube_d+12, 10],center=true);
			} // hull
			
			// Spring Holder
			cylinder(d1=SpringSplice_OD+10, d2=ST_DSpring_OD+6, h=SpringEnd_Z+4);
		} // union
		
		//translate([-4,-34,4]) FW_GPS_SW_Hole(-9);
		
		// Nosecone rivets
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j]) translate([0,-Body_ID/2-1,NC_Base_L/2])
			rotate([-90,0,0]){ cylinder(d=Rivet_d, h=10); translate([0,0,3.2]) cylinder(d=Rivet_d*2, h=6);}
		
		// Center hole
		translate([0,0,-6]) cylinder(d=ST_DSpring_OD-6, h=Tube_Z+30);
		
		// Spring
		translate([0,0,SpringEnd_Z]) rotate([180,0,0]) {
			cylinder(d=ST_DSpring_OD, h=30);
			translate([0,0,4]) cylinder(d1=ST_DSpring_OD, d2=SpringSplice_OD, h=8);
			translate([0,0,12-Overlap]) cylinder(d=SpringSplice_OD, h=30);
			}
		
		// Tube hole
		translate([0,0,Tube_Z]) rotate([0,90,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		// Retention cord
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j]) translate([0,Coupler_ID/2-5,-10]) cylinder(d=4, h=30);
		
		//if ($preview) cube([50,50,50]);
	} // difference
	
} // NC_ShockcordRingDual

//translate([0,0,-15]) color("Green") NC_ShockcordRingDual();

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
			PD_PetalHub(Coupler_OD=Body_ID, nPetals=nPetals, HasBolts=false, ShockCord_a=-1);
			
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

//NC_PetalHub();

module R98C_BallRetainerTop(){
	Tube_d=12.7;
	Tube_Z=31;
	Tube_a=-6;
	TubeSlot_w=35;
	TubeOffset_X=22;
	
	difference(){
		union(){
			STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls,
								HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=CouplerLenXtra,
								Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=true);
				
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

module EBay_ShockcordRingDual(){
// obsolete part
	Plate_t=4;
	Tube_d=12.7;
	CR_z=-3;
	
	translate([0,0,-5]) Tube(OD=Body_OD, ID=Body_ID, Len=20, myfn=$preview? 36:360);
	translate([0,0,15])
	
	difference(){
		union(){
			 Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-4.4, Len=15, myfn=$preview? 36:360);
			translate([0,0,-3])
				cylinder(d1=Body_ID, d2=Body_OD-NC_Wall_t*2-IDXtra*4, h=Plate_t);
				
			translate([0,0,-5])
				cylinder(d=Body_OD-1, h=5);
				
			hull(){
				translate([0,0,CR_z+3+Tube_d/2]) 
					rotate([0,90,0]) cylinder(d=Tube_d+4.4, h=Body_ID-3, center=true);
				translate([0,0,CR_z+2]) cube([Body_ID-4,Tube_d+8,Overlap],center=true);
			} // hull
		} // union
		
		translate([0,0,-6]) cylinder(d=Body_OD-30, h=30);
		
		translate([0,0,CR_z+3+Tube_d/2]) rotate([0,90,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
	} // difference
	
} // EBay_ShockcordRingDual

//translate([0,0,-15]) color("Green") EBay_ShockcordRingDual();

module Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoors=false){
	// made NC coupler IDXtra smaller 6/22/23

	Len=EBay_Len;
	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;

	Alt_a=0;
	Batt1_a=90;
	Batt2_a=180;
	Batt3_a=270;
	
	difference(){
		Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	// Battery and Switch doors
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	
} // Electronics_BayDual

// Electronics_BayDual(ShowDoors=false);

module MotorTubeTopper(){
// Z zero is top of motor tube
// Sits on top of motor tube
// Has Rail Guide bolt holes
// Has centering ring
// Has shock cord attachment tube
// Has spring holder

	Al_Tube_d=12.7;
	Al_Tube_Z=-Al_Tube_d/2-5;
	
	ST_DSpring_OD=44.30;
	ST_DSpring_ID=40.5;

	difference(){
		union(){
			translate([0,0,-20]) Tube(OD=MotorTube_ID, ID=MotorTube_ID-8, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) Tube(OD=MotorTube_OD+8, ID=MotorTube_OD+IDXtra*3, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-16, Len=21, myfn=$preview? 36:360);
			CenteringRing(OD=Body_ID, ID=ST_DSpring_ID, Thickness=5, nHoles=0, Offset=0);
			translate([0,0,4]) Tube(OD=ST_DSpring_OD+8, ID=ST_DSpring_OD, Len=8, myfn=$preview? 36:360);
		} // union
	
		//translate([0,0,-20]) Tube(OD=MotorTube_ID, ID=MotorTube_ID-6, Len=21, myfn=$preview? 36:360);
		
		translate([0,0,3]) cylinder(d=ST_DSpring_OD, h=4+Overlap);
		translate([0,0,7]) cylinder(d1=ST_DSpring_OD, d2=ST_DSpring_OD+4, h=5+Overlap);
		
		translate([0,0,Al_Tube_Z]) rotate([90,0,0]) cylinder(d=Al_Tube_d+IDXtra, h=Body_OD, center=true);
		
		translate([Body_OD/2, 0, -9]) {
			translate([0,0,6.35]) rotate([0,90,0]) Bolt6Hole();
			translate([0,0,-6.35]) rotate([0,90,0]) Bolt6Hole();
		}
	} // difference

} // MotorTubeTopper

// MotorTubeTopper();

module FinCan(Cone_Len=35, LowerHalfOnly=false, UpperHalfOnly=false){
	Wall_t=1.2;
	FinBox_W=Fin_Root_W+Wall_t*2;
	RailGuide_Z=25;
	
	difference(){
		union(){
			// Body Tube
			Tube(OD=Body_OD, ID=Body_OD-Wall_t*2, Len=Can_Len, myfn=$preview? 36:360);
			// Motor Tube Sleeve
			Tube(OD=MotorTubeHole_d+Wall_t*2, ID=MotorTubeHole_d, Len=Can_Len, myfn=$preview? 36:360);
			
			// integrated coupler
			translate([0,0,Can_Len-Overlap])
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-4, Len=10, myfn=$preview? 36:360);
			difference(){
				translate([0,0,Can_Len-5])
					Tube(OD=Body_OD-1, ID=Body_ID-4, Len=5, myfn=$preview? 36:360);
				translate([0,0,Can_Len-5-Overlap]) cylinder(d1=Body_OD-Wall_t*2, d2=Body_ID-5, h=5);
			} // difference
			
			// Upper Centering Ring
			//translate([0,0,Can_Len-3])
			//	CenteringRing(OD=Body_OD-1, ID=Body_ID-10, Thickness=3, nHoles=0, Offset=0);
				
			// Middle Centering Rings
			translate([0,0,Can_Len/2-3])
				rotate([0,0,180/nFins])
					CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=6, nHoles=nFins, Offset=0);
			
			// Fin Boxes
			difference(){
				for (j=[0:nFins]) rotate([0,0,360/nFins*j]) 
					translate([0,-FinBox_W/2,0]) cube([Body_OD/2,FinBox_W,Can_Len]);
					
				difference(){
					translate([0,0,-Overlap]) cylinder(d=Body_OD+10, h=Can_Len+Overlap*2);
					translate([0,0,-Overlap*2]) cylinder(d=Body_OD-1, h=Can_Len+Overlap*4);
				} // difference
				
				translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=Can_Len+Overlap*2);
			} // difference
			
			TailCone(Threaded=true, Cone_Len=Cone_Len, Interface_OD=Body_OD-1);
			
			// Rail guide bolt boss
			translate([0,0,RailGuide_Z]) rotate([0,0,90]) 
				RailGuidePost(OD=Body_OD, MtrTube_OD=MotorTubeHole_d, H=RailGuide_h, 
					TubeLen=50, Length = 30, BoltSpace=12.7);
		} // union
	
		// Fin Sockets
		translate([0,0,Fin_Root_L/2+FinInset_Len])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Fin_Post_h, 
					Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		// Rail guide bolt holes
		translate([-RailGuide_h,0,RailGuide_Z]) rotate([0,0,90]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		if (LowerHalfOnly) translate([0,0,Can_Len/2]) cylinder(d=Body_OD+1, h=Can_Len/2+50);
		if (UpperHalfOnly) translate([0,0,Can_Len/2]) 
			rotate([180,0,0]) cylinder(d=Body_OD+10, h=Can_Len/2+50);
			
		if ($preview) cube([50,50,300]);
	} // difference
} // FinCan

//rotate([180,0,0]) FinCan(LowerHalfOnly=false, UpperHalfOnly=false);

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
NomonalThread_d=MotorTube_OD+8;

module TailCone(Threaded=true, Cone_Len=35, Interface_OD=Body_ID){
	FinInset_Len=5;
	FinAlignment_Len=0;
	AftClosure_h=10;
	Retainer_h=2;
	Nut_Len=Retainer_h+AftClosure_h+10;
	Tail_r=20;
	Base_d=MotorTube_OD+4.4;
	
	difference(){
		union(){
			hull(){
				translate([0,0,-Cone_Len]) cylinder(d=Base_d, h=2, $fn=$preview? 90:360);
				
				difference(){
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-Tail_r,0,0]) circle(r=Tail_r);
					translate([0,0,Overlap]) cylinder(d=Body_OD+1,h=50);
				}
			} // hull
			
			translate([0,0,-Overlap]) 
				cylinder(d=Interface_OD, h=FinInset_Len+FinAlignment_Len+Overlap, $fn=$preview? 90:360);
		} // union
		
		// Fin slots
		translate([0,0,Fin_Root_L/2+FinInset_Len])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Fin_Post_h, 
							Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+Tail_r+FinInset_Len+FinAlignment_Len+Overlap*2);
	
		// Rail button bolt hole
		translate([-Body_OD/2,0,10]) rotate([0,-90,0]) Bolt8Hole();
		
		if (Threaded) translate([0,0,-Cone_Len-Overlap]) cylinder(d=Body_OD, h=Nut_Len);
	} // difference
	
	if (Threaded) difference(){
		translate([0,0,-Cone_Len+Nut_Len-10]) 
			ExternalThread(Pitch=2.5, Dia_Nominal=NomonalThread_d, 
							Length=10+Overlap, Step_a=$preview? 10:2, TrimEnd=true, TrimRoot=false);
			
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+FinInset_Len+FinAlignment_Len+Overlap*2);
	}
} // TailCone

//rotate([180,0,0]) TailCone(Interface_OD=Body_OD-1);

module MotorRetainer(HasWrenchCuts=false, Cone_Len=35, ExtraLen=0){
	
	
	AftClosure_h=10;
	Retainer_h=2;
	Nut_Len=Retainer_h+AftClosure_h+10;
	Tail_r=20;
	Base_d=MotorTube_OD+4.4;
	
	difference(){
		hull(){
			difference(){
				hull(){
					// Bottom
					translate([0,0,-Cone_Len]) cylinder(d=Base_d, h=2, $fn=$preview? 90:360);
						
					// Top
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-Tail_r,0,0]) circle(r=Tail_r);
				} // hull
				
				// Trim Top	
				translate([0,0,-Cone_Len+Nut_Len-Overlap]) cylinder(d=Body_OD+1, h=Cone_Len);
			} // difference
		
			translate([0,0,-Cone_Len-ExtraLen]) 
				cylinder(d=MotorTube_OD+2.4+IDXtra*2, h=2, $fn=$preview? 90:360);
		} // hull
			
		// Exit
		translate([0,0,-Cone_Len-ExtraLen-Overlap]) 
			cylinder(d=MotorTube_ID+IDXtra*2, h=Cone_Len);
			
		// Motor tube
		translate([0,0,-Cone_Len-ExtraLen+Retainer_h]) 
			cylinder(d=MotorTube_OD+IDXtra*3, h=Cone_Len);
	
		translate([0,0,-Cone_Len+Nut_Len-12+Overlap])
			ExternalThread(Pitch=2.5, Dia_Nominal=NomonalThread_d+IDXtra*4, 
							Length=15, Step_a=$preview? 10:2, TrimEnd=true, TrimRoot=false);
		
		// Spanner Wrench
		if (HasWrenchCuts){
			SW_Z=16;
			SW_W=Body_OD-22;
			translate([SW_W/2,-Body_OD/2,-Cone_Len]) cube([Body_OD,Body_OD,SW_Z]);
			mirror([1,0,0])
			translate([SW_W/2,-Body_OD/2,-Cone_Len]) cube([Body_OD,Body_OD,SW_Z]);
		} // if
		
		if ($preview) translate([0,0,-Cone_Len-ExtraLen-1]) cube([50,50,100]);
	} // difference
} // MotorRetainer

//translate([0,0,-0.2]) MotorRetainer(ExtraLen=4);

/*
difference(){
	union(){
		TailCone(Cone_Len=35);
		translate([0,0,-Overlap]) rotate([0,0,-150]) MotorRetainer(Cone_Len=35,ExtraLen=4);
	} // union
	
	translate([0,0,-50]) cube([50,50,50]);
} // difference
/**/

/*

module SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3){
// obsolete part
	ST_DSpring_OD=44.30;
	Piston_h=15;
	Len=30;
	Plate_t=3;
	
	//echo(OD=OD);
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
		} // hull
	} // SCH
	
	difference(){
		union(){
			Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,Len-Piston_h]) cylinder(d=OD-1, h=Piston_h);
			
			// Spring
			translate([0,0,8]) Tube(OD=ST_DSpring_OD+10, ID=ST_DSpring_OD, Len=12, myfn=$preview? 36:360);
		} // union
		
		// Rope Holes
		Rope_d=4;
		for (j=[0:nRopeHoles-1]) rotate([0,0,360/nRopeHoles*j]) translate([0,ST_DSpring_OD/2+Rope_d/2+6,0])
			cylinder(d=Rope_d, h=Len);
		
		// Top dish
		translate([0,0,Len-Piston_h+3+Plate_t]) 
			cylinder(d1=Tube_ID-20, d2=Tube_ID-2, h=Piston_h-3-Plate_t+Overlap);
	
		// Spring
		cylinder(d=ST_DSpring_OD, h=Len-Piston_h+3);
		cylinder(d1=ST_DSpring_OD+5, d2=ST_DSpring_OD, h=Len-Piston_h);
		
		// Shock Cord
		translate([0,0,Len-Piston_h+3]) SCH();
		//translate([0,0,-Overlap]) cylinder(d=5, h=Len);
		
		// Air Vents
		nVents=8;
		Vent_d=9;
		for (j=[0:nVents-1]) rotate([0,0,360/nVents*j]) translate([0,ST_DSpring_OD/2-Vent_d/2-2,0])
			cylinder(d=Vent_d, h=Len);
	} // difference
	

} // SpringEndTop

//SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=5);

module SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3){
// obsolete part
	ST_DSpring_OD=44.30;
	Piston_h=15;
	Len=30;
	Plate_t=3;
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+4);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+4);
		} // hull
	} // SCH
	
	difference(){
		union(){
			Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			cylinder(d=OD-1, h=Piston_h);
		} // union
		
		// Rope Holes
		Rope_d=4;
		for (j=[0:nRopeHoles-1]) rotate([0,0,360/nRopeHoles*j]) translate([0,ST_DSpring_OD/2+Rope_d/2+2,-Overlap])
			cylinder(d=Rope_d, h=Len);
		
		// Top dish
		translate([0,0,3+Plate_t]) 
			cylinder(d1=Tube_ID-20, d2=Tube_ID, h=Piston_h-3-Plate_t+Overlap);
	
		// Spring
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_OD, h=3);
		
		// Shock Cord
		SCH();
		//translate([0,0,-Overlap]) cylinder(d=5, h=10);
		
		// Air Vents
		nVents=8;
		Vent_d=9;
		for (j=[0:nVents-1]) rotate([0,0,360/nVents*j]) translate([0,ST_DSpring_OD/2-Vent_d/2-2,0])
			cylinder(d=Vent_d, h=Len);
	} // difference
	
} // SpringEndBottom

//SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=5);

module UpperRailBtnMount(){
// obsolete part
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
/**/










































