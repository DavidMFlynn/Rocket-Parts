// ***********************************
// Project: 3D Printed Rocket
// Filename: CinerocU157.scad
// by David M. Flynn
// Created: 7/11/2025
// Revision: 0.9.0  7/11/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  This is a partial design, booster is just too long to look like an Omega
//  6" Upscale of Estes Cineroc camera nosecone for Omega rocket
//  Designed for GoPro Hero 11 Black.
//  Replaces paylode bay and nosecone on 6" Omega
//
//  ***** History *****
// 0.9.0  7/11/2025   Split out of RocketOmegaU157
//
// ***********************************
//  ***** Options *****
//
//
// ***********************************
//  ***** for STL output *****
//
// NC_ShockcordRingDual(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, NC_ID=0, NC_Base_L=NC_Base_L, nRivets=NC_nRivets, nBolts=NC_nRivets, Flat=true);
// 
//  *** Spring Management ***
//
// SE_SpringEndTypeC(Coupler_OD=Coupler_OD, Coupler_ID=CouplerThinWall_ID, Len=10, nRopes=6, UseSmallSpring=false);
// SE_SlidingBigSpringMiddle(OD=Coupler_OD, SliderLen=50, Extension=0);
// R157_PusherRing(OD=Coupler_OD, ID=CouplerThinWall_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=0);
// R157_PusherRing(OD=Coupler_OD, ID=CouplerThinWall_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=3, nBolts=6); // for pushing on petals
// R157_SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=CouplerThinWall_ID, HasPD_Ring=false, Engagemnet_Len=7);
//
// SE_SpringEndTypeC(Coupler_OD=Coupler_OD, Coupler_ID=CouplerThinWall_ID, nRopes=6, UseSmallSpring=false);
//
// rotate([180,0,0]) R157_MotorTubeTopper(OD=Body_ID*CF_Comp, MotorTube_OD=BT54Body_OD, MotorTube_ID=BT54Body_ID, Len=35);
// EbayAlignmentCR(OD=Body_ID*CF_Comp);
//
//  *** Ball Lock ***
//
STB_Xtra_r=0.3;
//
//
//  *** Petal Deployers ***
//
// R157_NC_PetalHub(OD=Coupler_OD, nPetals=3, nRopes=6, Coupler_ID=CouplerThinWall_ID);
//
// PD_Petals2(OD=Coupler_OD, Len=MainPetal_Len, nPetals=3, Wall_t=2.2, AntiClimber_h=5, HasLocks=false, Lock_Span_a=180);
//
// rotate([-90,0,0]) PD_PetalSpringHolder2();
// PD_HubSpringHolder();
//
// ================================
//  ***** Cineroc Only Parts *****
// ================================
//  Replaces main parachute bay and nosecone
//
// BluntConeNoseCone(ID=CNC_Body_ID, OD=CNC_Body_OD, L=CNC_NC_Len, Base_L=CBC_Base_L, nRivets=NC_nRivets, Tip_R=CNC_NC_Tip_r, Wall_T=CNC_NC_Wall_t);
// Cineroc_CameraMount();
// Cineroc_CameraTube();
// CinerocCoupler();
// CinerocTube(CNC_LowerTube_Len);
// Cineroc_Base();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowCineroc(ShowInternals=false);
// ShowCineroc(ShowInternals=true);
//
// ***********************************
include<TubesLib.scad>
use<PetalDeploymentLib.scad>	echo(PetalDeploymentLibRev());
use<NoseCone.scad>				echo(NoseConeRev());
use<SpringEndsLib.scad>			echo(SpringEndsLibRev());
use<SpringThingBooster.scad>	echo(SpringThingBoosterRev());
use<R157Lib.scad>  				echo(R157Lib_Rev());
use<GoProCamLib.scad>			echo(GoProCamLib_Rev());

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nLocks=5; // Stager locks
Stager_Collar_Len=16;
Stager_Skirt_Len=16;


// for Stager 157
Stager_LockRod_X=12;
Stager_LockRod_Y=6;
Stager_LockRod_Z=38;
Stager_LockRod_R=1;
LockBall_d=1/2 * 25.4; // 1/2" Delrin balls
Default_nLocks=5;
CupBoltsPerLock=3;
DefaultBody_OD=ULine157Body_OD;
DefaultBody_ID=ULine157Body_ID;

Scale=ULine157Body_OD/41.58; // Body tube diameters
echo(Scale=Scale);
CF_Comp=1.0031; // PETG-CF comp value
Vinyl_t=0.12;
Body_OD=ULine157Body_OD;
Body_ID=ULine157Body_ID;
Coupler_OD=ULine157Coupler_OD;
Coupler_ID=ULine157Coupler_ID;
CouplerThinWall_ID=ULine157ThinWallCoupler_ID;


nLockBalls=6; // Ball Lock (STB) units
nEBayBolts=6;

MainPetal_Len=180;

Engagement_Len=30;

EBayBoltInset=7.5;
EBayCR_t=5;


PBay_Len=5*25.4*Scale;
LowerTube_Len=670;

ScaleBody_Len=(14.5+5)*25.4*Scale;
echo(str("Scale Body Length = ",ScaleBody_Len));
echo(str(" Including scale payload bay len = ",PBay_Len));


NC_Base_L=15;
NC_Len=170*Scale-NC_Base_L;
NC_Tip_r=5*Scale;
NC_Wall_t=2.2;
NC_nRivets=5;

RailGuide_h=Body_OD/2+2;
RailGuide_Len=40;

// ******************************
//  ***** Cineroc Nosecone *****

CNC_NC_Tip_r=0.375*25.4*Scale;
CNC_NC_Len=3.3*25.4*Scale;
CBC_Base_L=15;
CNC_NC_Wall_t=2.2;

CNC_Body_Wall_t=1.8;
CNC_Body_OD=1.8*25.4*Scale;
CNC_Body_ID=CNC_Body_OD-4.4;
CNC_Body_Len=(4.375+0.125*2)*25.4*Scale-30;
CNC_ParachuteTube_Len=300;
CNC_LowerTube_Len=CNC_ParachuteTube_Len-100;
CNC_UpperTube_Len=CNC_Body_Len-CNC_LowerTube_Len-3;

CNC_BaseTaper_Len=(1.0-0.125)*25.4*Scale;
CNC_Base_Len=CNC_BaseTaper_Len+15; // tapered portion plus shoulder
CNC_TubeEnd_OD=162.3;


module ShowCineroc(ShowInternals=false){
	Base_Z=0;
	ParachuteTube_Z=Base_Z+Engagement_Len/2;
	Body_Z=Base_Z+CNC_Base_Len;
	UpperBody_Z=Body_Z+CNC_LowerTube_Len+3;
	Nosecone_Z=Body_Z+CNC_Body_Len;
	
	echo(CBC_Base_L=CBC_Base_L);
	echo(CNC_NC_Len=CNC_NC_Len);
	translate([0,0,Nosecone_Z]) 
		BluntConeNoseCone(ID=CNC_Body_ID, OD=CNC_Body_OD, L=CNC_NC_Len, Base_L=CBC_Base_L, nRivets=NC_nRivets, 
					Tip_R=CNC_NC_Tip_r, Wall_T=CNC_NC_Wall_t);
					
		
	// Parachute Tube
	if (ShowInternals)
		translate([0,0,ParachuteTube_Z+0.1]) color("Tan")
			Tube(OD=Body_OD, ID=Body_ID, Len=CNC_ParachuteTube_Len-0.2, myfn=$preview? 90:360);
	
	//if (ShowInternals)
		translate([0,0,ParachuteTube_Z+CNC_ParachuteTube_Len-10]){
			rotate([0,0,180])
				NC_ShockcordRingDual(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, 
					NC_ID=0, NC_Base_L=NC_Base_L, nRivets=NC_nRivets, nBolts=NC_nRivets, Flat=true);
					
			translate([0,0,13]) Cineroc_CameraMount();
		}
				
	// Upper tube
	if (!ShowInternals)
	translate([0,0,UpperBody_Z+0.1]) color("Gray") Cineroc_CameraTube();
	//echo(UpperBody_Z=UpperBody_Z);
	
	translate([0,0,Body_Z+CNC_LowerTube_Len]) CinerocCoupler();
	
	// Lower tube
	if (!ShowInternals)
	translate([0,0,Body_Z+0.1]) color("Gray") CinerocTube(CNC_LowerTube_Len);
	
	translate([0,0,Base_Z]) Cineroc_Base();
	
	translate([0,0,UpperBody_Z+30]) ShowCamera();
} // ShowCineroc

// ShowCineroc(ShowInternals=false);
// ShowCineroc(ShowInternals=true);
// ShowRocketOmega(ShowInternals=true, ShowCineroc=true);

CNC_CamCowl_W=0.375*25.4*Scale;
CNC_CamCowl_H=1.187*25.4*Scale; // height from center
CNC_CamCowl_Offset=(0.25+0.375/2)*25.4*Scale; // left of center
CNC_CanCowl_Z=3.075*25.4*Scale;

module Cineroc_CamCowl(){
	// too small for go-pro H11
	translate([-CNC_CamCowl_Offset, -CNC_CamCowl_H/2, 0]) RoundRect(X=CNC_CamCowl_W, Y=CNC_CamCowl_H, Z=0.2*25.4*Scale, R=1);
} // Cineroc_CamCowl

//translate([0,0,CNC_CanCowl_Z+50]) Cineroc_CamCowl();
	GPH11B_W=51;
	GPH11B_Y=26;
	GPH11B_H=40;
	GPH11B_r=7;
	Cowl_t=2.2;
	Camera_a=-10; // angle out
	Camera_Z=50; // from base of upper tube

module Cineroc_CameraTube(){
	difference(){
		CinerocTube(CNC_UpperTube_Len, HasCoupler=true);
		translate([0,0,Camera_Z-6]) GPH11B_Cowl_Hole();
	} // difference
	
	translate([0,0,Camera_Z-6]) GPH11B_Cowl();
} // Cineroc_CameraTube

//Cineroc_CameraTube();

module GPH11B_Cowl_Hole(){
	XtraSpace=2;
	
		hull(){
			translate([0, -CNC_Body_OD/2, -Overlap]) rotate([Camera_a,0,0])
				RoundRect(X=GPH11B_W+XtraSpace*2, Y=GPH11B_Y*2+XtraSpace*2, Z=GPH11B_H+Overlap*2, R=GPH11B_r);
			
			translate([0, -CNC_Body_OD/2+2,70])
				RoundRect(X=10, Y=1, Z=GPH11B_H, R=1);
		} // hull
} // GPH11B_Cowl_Hole

module GPH11B_Cowl(){
	XtraSpace=2;
	
	difference(){
		hull(){
			translate([0, -CNC_Body_OD/2, 0]) rotate([Camera_a,0,0])
				RoundRect(X=GPH11B_W+XtraSpace*2+Cowl_t*2, Y=GPH11B_Y*2+XtraSpace*2+Cowl_t*2, Z=GPH11B_H, R=GPH11B_r+Cowl_t);
				
			translate([0, -CNC_Body_OD/2+2, 80])
				RoundRect(X=10, Y=1, Z=GPH11B_H, R=1);
		} // hull
			
		GPH11B_Cowl_Hole();
		
		translate([0,0,-10]) cylinder(d=CNC_Body_ID+1, h=150);
		
	} // difference

} // GPH11B_Cowl

//translate([0,0,302.3+Camera_Z-6]) GPH11B_Cowl();

module Cineroc_CameraMount(){
	CameraPlate_t=5;
	Felt_t=3;
	CameraPlate_Z=34-CameraPlate_t-Felt_t; // place top of plate at bottom of cowl
	CameraPlate_W=GPH11B_W+10;
	CameraPlate_Len=110;
	Tube_Len=17;
	C_Block_H=10;
	C_Block_W=10;

	// Mount to NC_ShockcordRingDual like a nosecone
	difference(){
		Tube(OD=Body_OD*CF_Comp, ID=Body_ID+IDXtra*2, Len=Tube_Len, myfn=$preview? 90:360);
	
		// Rivets
		for (j=[0:NC_nRivets-1]) rotate([0,0,360/NC_nRivets*j]) translate([0,Body_OD/2+1,7.5])
			rotate([90,0,0]) cylinder(d=4, h=6);
	} // difference
	
	
	module CameraMountingHoles(){
		translate([0, -CNC_Body_OD/2, CameraPlate_Z+CameraPlate_t]) rotate([Camera_a,0,0]){
				translate([-GPH11B_W/2-C_Block_W/2,30,C_Block_H]) Bolt8Hole(depth=20);
				translate([GPH11B_W/2+C_Block_W/2,30,C_Block_H]) Bolt8Hole(depth=20);
				translate([0,46+C_Block_W/2,C_Block_H]) Bolt8Hole(depth=20);
			}
	}
	
	difference(){
		hull(){
			difference(){
				translate([0,0,Tube_Len-Overlap]) Tube(OD=Body_OD*CF_Comp, ID=Body_ID+IDXtra*2, Len=1, myfn=$preview? 90:360);
				translate([-Body_OD/2-5, -25, Tube_Len-Overlap*2]) cube([Body_OD+10,Body_OD,3]);
			} // difference
			
			difference(){
				intersection(){
					translate([0, -CNC_Body_OD/2, CameraPlate_Z]) rotate([Camera_a,0,0])
							RoundRect(X=CameraPlate_W, Y=CameraPlate_Len, Z=CameraPlate_t, R=3);
					cylinder(d=	CNC_Body_ID-1, h=100, $fn=$preview? 90:360);
				} // intersection
				
				translate([0, -CNC_Body_OD/2, CameraPlate_Z]) rotate([Camera_a,0,0])
					translate([0,0,5]) cube([GPH11B_W, 10, CameraPlate_t*2+Overlap*2], center=true);
				
			} // difference
		} // hull
		
		// Bolt Holes
		CameraMountingHoles();
	} // difference
	
	// Camera locating bolcks
	difference(){
		translate([0, -CNC_Body_OD/2, CameraPlate_Z+CameraPlate_t]) rotate([Camera_a,0,0]){
			translate([-GPH11B_W/2-C_Block_W/2,30,-1]) 
				RoundRect(X=C_Block_W, Y=20, Z=C_Block_H, R=2);
			
			translate([GPH11B_W/2+C_Block_W/2,30,-1])
				RoundRect(X=C_Block_W, Y=20, Z=C_Block_H, R=2);
			
			translate([0,46+C_Block_W/2,-1])
				RoundRect(X=20, Y=C_Block_W, Z=C_Block_H, R=2);
			
		}
		CameraMountingHoles();
	} // difference
} // Cineroc_CameraMount

//translate([0,0,302.3+16]) Cineroc_CameraMount();

module ShowCamera(){
	translate([0,-CNC_Body_OD/2,Camera_Z])
		rotate([Camera_a,0,0]) translate([0,15,0]) rotate([180,0,-90]) 
			color("LightGray") GPC_GoProHero11Black(Xtra=0, Xtra_Z=0, IncludeVP=false, BackAccess=false, HasMountingEars=false);
} // ShowCamera

//translate([0,0,302.3+29]) ShowCamera();

module Cineroc_Base(){

	difference(){
		union(){
			cylinder(d1=Body_OD*CF_Comp+Vinyl_t*2, d2=CNC_Body_OD*CF_Comp, h=CNC_BaseTaper_Len, $fn=$preview? 90:360);
			
			translate([0,0,CNC_BaseTaper_Len-Overlap])
				Tube(OD=CNC_Body_OD*CF_Comp, ID=CNC_Body_ID, Len=15+Overlap, myfn=$preview? 90:360);
				
			translate([0,0,CNC_BaseTaper_Len+15])
				Tube(OD=CNC_Body_ID, ID=CNC_Body_ID-CNC_Body_Wall_t*2, Len=15, myfn=$preview? 90:360);
				
			// connector
			translate([0,0,CNC_BaseTaper_Len+10])
			difference(){
				Tube(OD=CNC_Body_ID+1, ID=CNC_Body_ID-CNC_Body_Wall_t*2, Len=5, myfn=$preview? 90:360);
					
				translate([0,0,-Overlap]) cylinder(d1=CNC_Body_ID-Overlap, d2=CNC_Body_ID-CNC_Body_Wall_t*2-Overlap, h=5, $fn=$preview? 90:360);
			} // difference
		} // union
		
		translate([0,0,-Overlap])
			cylinder(d1=Body_ID, d2=CNC_Body_ID, h=CNC_BaseTaper_Len+Overlap*2, $fn=$preview? 90:360);
			
		translate([0,0,-Overlap]) cylinder(d=Body_OD+1, h=40, $fn=$preview? 90:360);
			
		// Bolts
		for (j=[0:NC_nRivets-1]) rotate([0,0,360/NC_nRivets*j]) translate([0,CNC_Body_OD/2+1,CNC_BaseTaper_Len+15+7.5])
			rotate([-90,0,0]) Bolt4Hole();
		
	} // difference
	
	//translate([0,0,-Engagement_Len/2]) 
	rotate([180,0,0]) 
		STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD*CF_Comp, Engagement_Len=Engagement_Len);
} // Cineroc_Base

// Cineroc_Base();

module CinerocTube(Len=CNC_Body_Len/2, HasCoupler=false){
	UpperBolt_Z=HasCoupler? Len+7.5:Len-7.5;
	difference(){
		union(){
			Tube(OD=CNC_Body_OD*CF_Comp, ID=CNC_Body_ID, Len=Len, myfn=$preview? 90:360);
			
			if (HasCoupler){
				translate([0,0,Len-Overlap]) Tube(OD=CNC_Body_ID, ID=CNC_Body_ID-4.4, Len=15, myfn=$preview? 90:360);
				translate([0,0,Len-5]) Tube(OD=CNC_Body_ID+1, ID=CNC_Body_ID-4.4, Len=5, myfn=$preview? 90:360);
			}
		} // union
		
		if (HasCoupler){
			translate([0,0,Len-5-Overlap]) cylinder(d1=CNC_Body_ID, d2=CNC_Body_ID-4.4, h=5, $fn=$preview? 90:360);
		}
		
		for (j=[0:NC_nRivets]) rotate([0, 0, 360/NC_nRivets*j]){
			translate([0, CNC_Body_OD/2+1, UpperBolt_Z]) rotate([-90,0,0]) Bolt4Hole();
			translate([0, CNC_Body_OD/2+1, 7.5]) rotate([-90,0,0]) Bolt4Hole();
		}
	} // difference
} // CinerocTube

// CinerocTube();
// CinerocTube(CNC_UpperTube_Len,HasCoupler=true);

module CinerocCoupler(){
	Coulper_ID=CNC_Body_ID-4.4;
	Len=33;
	
	difference(){
		union(){
			translate([0,0,-15]) Tube(OD=CNC_Body_ID, ID=Coulper_ID, Len=33, myfn=$preview? 90:360);
			// outer flange
			Tube(OD=CNC_Body_OD*CF_Comp, ID=Coulper_ID, Len=3, myfn=$preview? 90:360);
			// centering ring
			translate([0,0,-15]) Tube(OD=CNC_Body_ID-1, ID=Body_OD*CF_Comp+IDXtra*2, Len=3, myfn=$preview? 90:360);
		} // union
		
		for (j=[0:NC_nRivets]) rotate([0, 0, 360/NC_nRivets*j]){
			translate([0, CNC_Body_OD/2+1, 3+7.5]) rotate([-90,0,0]) Bolt4Hole();
			translate([0, CNC_Body_OD/2+1, -7.5]) rotate([-90,0,0]) Bolt4Hole();
			// must slide past bolts in parachute tube
			rotate([0,0,180/NC_nRivets]) translate([0, Body_OD/2, -15-Overlap]) scale([1.5,1,1]) cylinder(d=6, h=4);
		}
	} // difference
} // CinerocCoupler

// CinerocCoupler();


































