// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringThing2.scad
// by David M. Flynn
// Created: 10/17/2022 
// Revision: 1.1.1   2/2/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Built to deploy a parachute from a booster with a spring.
// 80mm of 54mm Body tube is required to fit the spring from end to lock balls. 
//
// I have built one in 98mm (PML 3.9 inch) 1/29/2023 and everything looks good.
// Also, in 137mm (Blue Tube 5.5 inch) 12/19/2022
//
//  ***** History *****
// 1.1.1   2/2/2023   Fixes cable bearing shaft hole.
// 1.1.0   1/29/2023  Added ST_CableBearing(). fixed: ST_LockBallRetainer(), ST_DetentOnly(), ST_CableRedirectTop(). Default to raceways=true in ST_Frame().
// 1.0.0   12/19/2022 Works as printed in 98mm and 137mm.
// 0.9.23  12/18/2022 Adjuster angle of ball detent bolts 12° to clear wire path of 5.5 inch version. 
// 0.9.22  12/17/2022 Fixed cable raceways at 180° and 90°. Printing a 98mm one today. 
// 0.9.21  12/16/2022 Added wire chanel to CableRedirect so wire don't get lost between centering rings.
// 0.9.20  12/5/2022  ST_UpperCenteringRing ID + IDXtra*2
// 0.9.19  12/4/2022  Works for BT137Body, needs testing w/ PML98Body, added notches for stager & wires
// 0.9.18  12/3/2022  sync'd w/ Stager ST_CableEndAndStop
// 0.9.17  12/2/2022  Added Calc_a(Dist,R)
// 0.9.16  11/24/2022 Reworked angles and split ST_CableRedirect
// 0.9.15  11/23/2022 Math in ST_LockRing()
// 0.9.14  11/12/2022 Working to a 5.5" version
// 0.9.13  11/11/2022 Code cleanup, prep for making a 6 inch version. 
// 0.9.12  11/8/2022 More parametric
// 0.9.11  11/5/2022 Aligned all so cable is at 0°
// 0.9.10 10/30/2022 Moved the collar tube stop, FC3
// 0.9.9  10/29/2022 Deeper ball entry on ST_LockRing, reworked drilling jig again
// 0.9.8  10/25/2022 Added ST_SpringMiddle
// 0.9.7  10/25/2022 Added StageCable_a to ST_CableRedirect
// 0.9.6  10/24/2022 Added ST_UpperCenteringRing, small fixes, FC2
// 0.9.5  10/23/2022 Added alignment key, FC1
// 0.9.4  10/22/2022 Added ST_LockBallRetainer, Fixed ST_CableRedirect
// 0.9.3  10/21/2022 Added ST_CableEndAndStop and ST_CableRedirect
// 0.9.2  10/21/2022 Worked on ST_LockRing added ST_BallKeeper()
// 0.9.1  10/18/2022 Added ST_MT_DrillingJig(TubeOD=BT54Body_OD)
// 0.9.0  10/17/2022 Moved to here from Stager.scad.
//
// ***********************************
//  ***** for STL output *****
//
// ST_TubeEnd(Tube_OD=BT54Coupler_OD, Tube_ID=BT54Coupler_ID); // print 2, glued to half section of coupler tube
// ST_TubeLockLanyard(Skirt_ID=BT54Coupler_ID-2);
// ST_TubeLock(Tube_OD=BT54Coupler_OD, Skirt_ID=BT54Coupler_ID-2, SkirtLen=15); // Glued to top of spring.
// ST_SpringMiddle(Tube_ID=BT54Coupler_OD); // optional double spring slider
// ST_SpringGuide(InnerTube_ID=BT54Body_ID); // Sits on top of motor, glued to bottom of spring. 
//
// ST_BallSpacer(Tube_OD=PML98Body_OD); // print 2, spaces balls in bearing
// ST_BallKeeper(InnerTube_OD=BT54Body_OD); // ball alignment, glue to tube
// 
// ST_LockRing(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD); 
// ST_DetentOnly(Tube_OD=PML98Body_OD);
// ST_CableEndAndStop(Tube_OD=PML98Body_OD);
// rotate([180,0,0]) ST_LockBallRetainer(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD);
//
// ST_UpperCenteringRing(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Body_OD);
// ST_Frame(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Collar_Len=26, Skirt_Len=34, HasStagerCableRaceway=true, HasWireRaceway=true); // 70mm long
//
// ST_CableRedirectTop(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD);
// ST_CableBearing();

// ST_CableRedirect(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD, InnerTube2_OD=BT54Mtr_OD); // in from ebay, out to stager
//
// ST_MT_DrillingJig(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Body_OD, Skirt_Len=30);
//
// ***********************************
//  ***** Routines *****
//
// ST_BallDetentStopper();
// ST_OuterRace(Tube_OD=PML98Body_OD); // Make this a part of the body tube.
//
// ***********************************
//  ***** for Viewing *****
//
// ShowSpringThing(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD, InnerTube_ID=BT54Body_ID, InnerCouplerTube_OD=BT54Coupler_OD, InnerCouplerTube_ID=BT54Coupler_ID);
//
//ShowST_Assy(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD, InnerTube2_OD=BT54Mtr_OD, InnerTube_ID=PML98Coupler_ID, Triggered=false);
//
//ShowST_Assy(Tube_OD=BT137Body_OD, Skirt_ID=BT137Body_ID, InnerTube_OD=BT98Body_OD, InnerTube2_OD=BT98Body_OD, InnerTube_ID=BT98Coupler_ID, Triggered=false);
//
// ***********************************

include<TubesLib.scad>
include<BearingLib.scad>
use<RacewayLib.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;


// Deployment Spring big and light
ST_DSpring_OD=44.30;
ST_DSpring_ID=40.50;
ST_DSpring_CBL=22; // coil bound length
ST_DSpring_FL=200; // free length

ST_PreLoadAdj=-0.35;
LooseFit=0.8;

LockBall_d=3/8*25.4;
function LockBallCircle_d(InnerTube_OD=BT54Body_OD)=InnerTube_OD+2; // Ball circle of lock balls

BearingBall_d=5/16*25.4;
OuterRace_w=10;
InnerRace_w=13;
function BearingBallCircle_d(Tube_OD=PML98Body_OD)=Tube_OD-6-BearingBall_d;

function Race_ID(InnerTube_OD=BT54Body_OD)=InnerTube_OD+5;

Bolt4Inset=4;

function ST_Spring_OD()=ST_DSpring_OD;
function ST_Spring_ID()=ST_DSpring_ID;
function BoltCircle_d(Tube_OD=PML98Body_OD)=BearingBallCircle_d(Tube_OD=Tube_OD)-BearingBall_d-Bolt4Inset*2;

function nBearingBalls(Tube_OD=PML98Body_OD)=floor(BearingBallCircle_d(Tube_OD=Tube_OD)*PI/BearingBall_d/3)+
					(floor(BearingBallCircle_d(Tube_OD=Tube_OD)*PI/BearingBall_d/3)%2);
	
function Calc_a(Dist,R)=Dist/(R*2*PI)*360;
function Stop_a(R=50)=-30-Calc_a(16,R);
function BackStop_a(R=50)=Stop_a(R)+Calc_a(16+15,R);
function Cable_a(R=50)=BackStop_a(R)+Calc_a(23,R);
	
nLockBalls=3;
nInnerRaceBolts=6;
ST_DetentBall_d=3/8 * 25.4;
	
module ShowSpringThing(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, 
						CouplerTube_OD=PML98Coupler_OD, CouplerTube_ID=PML98Coupler_ID,
						InnerTube_OD=BT54Mtr_OD, InnerTube_ID=BT54Body_ID, 
						InnerCouplerTube_OD=BT54Coupler_OD, InnerCouplerTube_ID=BT54Coupler_ID){
	
	translate([0,0,-110]) color("Tan") ST_SpringGuide(InnerTube_ID=InnerTube_ID);
	
	color("Silver") translate([0,0,-60]) {
		ST_CableRedirectTop(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD);
		translate([0,0,-10]) ST_CableRedirect(Tube_OD=Tube_OD, Skirt_ID=Tube_ID, Tube_ID=CouplerTube_ID, InnerTube_OD=InnerTube_OD);
		//translate([-40,10,-40]) ST_BallDetentStopper();
	}
	
	translate([0,0,90]) ST_BallKeeper(InnerTube_OD=InnerTube_OD);
	
	translate([0,0,-30])
		rotate([0,180,-60]) {
			ST_CableEndAndStop(Tube_OD=Tube_OD);
			rotate([0,0,-120]) ST_DetentOnly(Tube_OD=PML98Body_OD);
		}
		translate([0,0,80]) color("Green") ST_LockBallRetainer(Tube_OD=Tube_OD, InnerTube_OD=InnerTube_OD);

	
	color("Orange") translate([0,0,50]){
		ST_LockRing(Tube_OD=Tube_OD, InnerTube_OD=InnerTube_OD);
		translate([0,0,-40]) ST_Frame(Tube_OD=Tube_OD, Skirt_ID=Tube_ID, Collar_Len=20, Skirt_Len=30);
		}
	
	color("Green") translate([0,0,45]) {
		ST_BallSpacer(Tube_OD=Tube_OD);
		translate([0,0,25]) rotate([180,0,0]) ST_BallSpacer(Tube_OD=Tube_OD);
	}
	translate([0,0,110]) color("Tan") ST_TubeLock(Tube_OD=InnerCouplerTube_OD, Skirt_ID=InnerCouplerTube_ID-2);
	
	color("LightBlue") translate([0,0,140]) {
		translate([0,-10,0]) ST_TubeEnd(Tube_OD=InnerCouplerTube_OD, Tube_ID=InnerCouplerTube_ID);
		translate([0,10,0]) rotate([0,0,180]) ST_TubeEnd(Tube_OD=InnerCouplerTube_OD, Tube_ID=InnerCouplerTube_ID);
	}
} // ShowSpringThing

//ShowSpringThing();


module ShowST_Assy(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD,
	InnerTube2_OD=BT54Mtr_OD, InnerTube_ID=PML98Coupler_ID, Triggered=false){
	
	Sep_Z=29; // 23 down from bearing
	BC_r=BoltCircle_d(Tube_OD)/2;

	T_a=Triggered? Calc_a(11,BoltCircle_d(Tube_OD)/2):0;

	/*
	difference(){
		translate([0,0,-10-1.5]) 
			ST_Frame(Tube_OD=Tube_OD, Skirt_ID=Skirt_ID, Collar_Len=26, Skirt_Len=34, HasStagerCableRaceway=true, HasWireRaceway=true);
		rotate([0,0,-15]) translate([0,0,-50]) cube([100,100,100]);
	} // difference
	/**/
		
	translate([0,0,5.5])  rotate([0,0,-Cable_a(BC_r)]) ST_UpperCenteringRing(Tube_OD=Tube_OD, Skirt_ID=Skirt_ID, InnerTube_OD=InnerTube_OD);

	rotate([0,0,-Cable_a(BC_r)]) 
	translate([0,0,-Sep_Z]){
		ST_CableRedirectTop(Tube_OD=Tube_OD, Skirt_ID=Skirt_ID, InnerTube_OD=InnerTube_OD);
		ST_CableRedirect(Tube_OD=Tube_OD, Skirt_ID=Skirt_ID, 
							Tube_ID=InnerTube_ID, 
							InnerTube2_OD=InnerTube_OD, // in from ebay
							InnerTube_OD=InnerTube2_OD);
		//ST_CableRedirect(Tube_OD=Tube_OD, Skirt_ID=Skirt_ID, Tube_ID=InnerTube_ID, InnerTube_OD=InnerTube_OD);
	}
	
	rotate([0,0,-Cable_a(BC_r)+T_a]){
		ST_LockBallRetainer(Tube_OD=Tube_OD, InnerTube_OD=InnerTube_OD);
		rotate([0,0,-30]) translate([0,0,-13]) rotate([0,180,0]) ST_CableEndAndStop(Tube_OD=Tube_OD);
		translate([0,0,-13]) ST_LockRing(Tube_OD=Tube_OD, InnerTube_OD=InnerTube_OD);
		translate([0,0,-13]) rotate([0,180,90]) ST_DetentOnly(Tube_OD=Tube_OD);
	} // rotate
	

} // ShowST_Assy

//ShowST_Assy(Tube_OD=BT137Body_OD, Skirt_ID=BT137Body_ID, InnerTube_OD=BT75Body_OD, InnerTube2_OD=BT54Body_OD, InnerTube_ID=BT137Coupler_ID, Triggered=false);
//ShowST_Assy();

module ST_SpringMiddle(Tube_ID=BT54Coupler_OD){
		
	difference(){
		translate([0,0,-ST_DSpring_CBL-2]) cylinder(d=Tube_ID-LooseFit, h=ST_DSpring_CBL*2+4);
		
		// center hole
		translate([0,0,-ST_DSpring_CBL-2-Overlap]) cylinder(d=Tube_ID-4.4, h=ST_DSpring_CBL*2+4+Overlap*2);
	} // difference
	
	difference(){
		union(){
			translate([0,0,-6]) cylinder(d=ST_DSpring_ID-1, h=ST_DSpring_CBL+6);
			translate([0,0,-2]) cylinder(d=Tube_ID-LooseFit, h=2);
		} // union
		
		// center hole
		translate([0,0,-ST_DSpring_CBL-Overlap]) cylinder(d=35, h=ST_DSpring_CBL*2+Overlap*2);
		
	} // difference
} // ST_SpringMiddle

//ST_SpringMiddle();

module ST_SpringGuide(InnerTube_ID=BT54Body_ID){
	Tail_Len=22;
	MotorTopDepth=Tail_Len-7;
	
	difference(){
		union(){
			cylinder(d=ST_DSpring_ID-1, h=ST_DSpring_CBL-6); // -6 to mate with ST_SpringMiddle
			translate([0,0,-Tail_Len+Overlap]) cylinder(d=InnerTube_ID-IDXtra*2, h=Tail_Len);
		} // union
		
		translate([0,0,-Tail_Len]) cylinder(d=39, h=MotorTopDepth);
		translate([0,0,-Tail_Len]) cylinder(d=35, h=Tail_Len+ST_DSpring_CBL+Overlap*2);
	} // difference
} // ST_SpringGuide

// ST_SpringGuide();

module ST_BallKeeper(InnerTube_OD=BT54Body_OD){
	nBalls=nLockBalls;
	H=16;
	Wall_t=2;
	BallCircle_r=LockBallCircle_d(InnerTube_OD=InnerTube_OD)/2;
	Offset_a=-Calc_a(10,BallCircle_r);
	
	difference(){
		cylinder(d=InnerTube_OD+Wall_t*2, h=H);
		
		translate([0,0,-Overlap]) cylinder(d=InnerTube_OD+IDXtra*2, h=H+Overlap*2);
		
		for (j=[0:nBalls-1]) rotate([0,0,Offset_a+360/nBalls*j]) translate([0,0,H/2])
			rotate([-90,0,0]) cylinder(d=LockBall_d+IDXtra*2, h=InnerTube_OD);
	} // difference
	
} // ST_BallKeeper

//ST_BallKeeper();

module ST_BallDetentBody(){
	DetentBall_d=ST_DetentBall_d;
	DetentSpring_d=7.7;
	DetentSpring_Len=14; // Lightly compressed
	Body_d=14;
	Body_Len=27;
	Nose_h=2;
	Protusion=1.5;
	
	difference(){
		union(){
			translate([0,0,Body_Len-Nose_h-Overlap]) 
				cylinder(d1=Body_d, d2=DetentBall_d, h=Nose_h);
			cylinder(d=Body_d, h=Body_Len-Nose_h);
		} // union
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=DetentBall_d+LooseFit, h=Overlap);
			translate([0,0,Body_Len-DetentBall_d/2+Protusion]) 
				sphere(d=DetentBall_d+LooseFit);
		} // hull
		
		if ($preview){
			translate([0,0,-Overlap]) cube([40,40,40]);}
	} // difference
	
	if ($preview) translate([0,0,Body_Len-DetentBall_d/2+Protusion]) 
		color("Red") sphere(d=DetentBall_d);
} // ST_BallDetentBody

//ST_BallDetentBody();

module ST_BallDetentStopper(){
	DetentBall_d=ST_DetentBall_d;
	DetentSpring_d=7.7;
	DetentSpring_Len=14; // Lightly compressed
	Body_d=14;
	Body_Len=27;
	Protusion=1.5;
	BottomOfSpring_h=3+Body_Len-DetentBall_d/2+Protusion-DetentSpring_Len;
	
	cylinder(d=Body_d-IDXtra*2, h=3);
	
	difference(){
		cylinder(d=DetentBall_d, h=BottomOfSpring_h+2);
		translate([0,0,BottomOfSpring_h]) cylinder(d=DetentSpring_d+IDXtra, h=3);
	} // difference
	
} // ST_BallDetentStopper

//translate([0,0,-3]) ST_BallDetentStopper();

module ST_UpperCenteringRing(Tube_OD=PML98Body_OD,
			Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD){
				
	CablePath_Y=BoltCircle_d(Tube_OD)/2; 
	CablePath_ID=7;
				
	difference(){
		rotate([0,0,22.5+Cable_a(CablePath_Y)]) CenteringRing(OD=Skirt_ID-IDXtra, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=8);
		
		// Alignment Key
		translate([0,Skirt_ID/2,-Overlap]) cylinder(d=5, h=5+Overlap*2);
		
		//Stager cable
		rotate([0,0,Cable_a(CablePath_Y)+180]) hull(){
			translate([0,Tube_OD/2,-20-Overlap]) cylinder(d=6, h=25+Overlap*2);
			translate([0,Skirt_ID/2-4,-20-Overlap]) cylinder(d=6, h=25+Overlap*2);
		} // hull
		
		//wires
		rotate([0,0,Cable_a(CablePath_Y)+90]) hull(){
			translate([0,Tube_OD/2,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
			translate([0,Skirt_ID/2-4,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
		} // hull
	} // difference
		
} // ST_UpperCenteringRing

//ST_UpperCenteringRing();
//ST_UpperCenteringRing(Tube_OD=BT137Body_OD, Skirt_ID=BT137Body_ID, InnerTube_OD=BT75Body_OD);

module ST_CableBearing(){
	BB_OD=8;
	BB_ID=4;
	BB_W=3;
	RimXtra_d=6;
	
	difference(){
		cylinder(d=BB_OD+RimXtra_d, h=BB_W+2);
		
		translate([0,0,-Overlap]) cylinder(d=BB_OD-2, h=2);
		translate([0,0,1]) cylinder(d=BB_OD+IDXtra*2, h=BB_W+2);
		
		 
		difference(){
			translate([0,0,0.8]) cylinder(d=BB_OD+RimXtra_d+Overlap, h=BB_W+0.4);
			
			translate([0,0,1+BB_W/2-0.3]) cylinder(d=BB_OD+2+IDXtra*2, h=0.6);
			
			translate([0,0,1-0.2]) 
				cylinder(d1=BB_OD+RimXtra_d, d2=BB_OD+2+IDXtra*2, h=BB_W/2);
			translate([0,0,1+BB_W/2+0.2]) 
				cylinder(d2=BB_OD+RimXtra_d, d1=BB_OD+2+IDXtra*2, h=BB_W/2);
				
		} // difference
	} // difference
} // ST_CableBearing

//ST_CableBearing();

module ST_CableRedirectTop(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD){
								
	CablePath_Y=BoltCircle_d(Tube_OD)/2; 
	Exit_a=75;
	nBolts=8;
	BallDetent_a=90;
	CablePath_ID=7;
	CableB_a=Calc_a(5.2,CablePath_Y);
			
	module CablePath(){
		R=7;
		translate([0,-R,0]) rotate([0,-90,0])			
			rotate([0,0,-0.5]) rotate_extrude(angle=91) translate([R,0,0]) circle(d=6);
			
	} // CablePath
	
	rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,-16.5]) 
		difference(){
			rotate([0,0,100]) ST_BallDetentBody();
			
			translate([0,0,-Overlap]) cylinder(d=25, h=16.5);
		} // difference
	
	difference(){
		union(){
			CenteringRing(OD=Skirt_ID, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=0);
			
			// Locked position stop
			rotate([0,0,Stop_a(CablePath_Y)]) translate([0,CablePath_Y,0]) cylinder(d=8, h=10);
			
			// Unlocked position stop, allow 10mm of movement
			rotate([0,0,BackStop_a(CablePath_Y)]) 
				translate([0,CablePath_Y,0]) cylinder(d=8, h=8.5);
				
			//Cable Bearing
			difference(){
				rotate([0,0,Cable_a(CablePath_Y)-CableB_a])
				translate([0,CablePath_Y-1,3]) rotate([0,0,-CableB_a]){
					rotate([-90,0,0]) cylinder(d=9, h=20, center=true);
					difference(){
						rotate([-90,0,0]) cylinder(d=17, h=8, center=true);
						translate([0,-10,0]) cube([20,20,20]);
					} // difference
					}
					
				// Trim ID
				translate([0,0,-8]) cylinder(d=InnerTube_OD+IDXtra*2, h=18);
				// Trim bottom
				translate([0,0,-8]) cylinder(d=Skirt_ID, h=8);
			} // difference
				
		} // union
		
		//Cable Bearing
		rotate([0,0,Cable_a(CablePath_Y)-CableB_a])
			translate([0,CablePath_Y-1,3]) rotate([0,0,-CableB_a]){
				rotate([-90,0,0]) cylinder(d=15, h=6, center=true);
				rotate([-90,0,0]) cylinder(d=4+IDXtra*2, h=50, center=true);
				}
		
		// Bolt holes
		for (j=[2:nBolts]) rotate([0,0,360/nBolts*(j+1)]) translate([0,InnerTube_OD/2+Bolt4Inset,5])
			Bolt4HeadHole();
		rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,5])
			rotate([0,0,12]){
				translate([10,0,0]) Bolt4HeadHole();
				translate([-10,0,0]) Bolt4HeadHole();
			}
		
		// Ball Detent
		rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,-Overlap]) 
			cylinder(d=14-Overlap, h=6);
		
		// Alignment Key
		translate([0,Skirt_ID/2,-Overlap]) cylinder(d=5, h=5+Overlap*2);
		
		// Cable exit
		rotate([0,0,Cable_a(CablePath_Y)]) translate([0,CablePath_Y,1]) rotate([0,0,Exit_a]) CablePath();
		
		// vertical tube for cable
		rotate([0,0,Cable_a(CablePath_Y)]) translate([0,CablePath_Y,-20-Overlap])
			cylinder(d=6, h=25+Overlap*2);
		
		//Stager cable
		rotate([0,0,Cable_a(CablePath_Y)+180]) hull(){
			translate([0,Tube_OD/2,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
			translate([0,Skirt_ID/2-4,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
		} // hull
		
		//wires
		rotate([0,0,Cable_a(CablePath_Y)+90]) hull(){
			translate([0,Tube_OD/2,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
			translate([0,Skirt_ID/2-4,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
		} // hull
	} // difference
	
} // ST_CableRedirectTop

// ST_CableRedirectTop(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD);

// ST_CableRedirectTop(Tube_OD=BT137Body_OD, Skirt_ID=BT137Body_ID, InnerTube_OD=BT75Body_OD);

module ST_CableRedirect(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, 
							Tube_ID=PML98Coupler_ID, 
							InnerTube_OD=BT54Mtr_OD, // in from ebay
							InnerTube2_OD=BT54Mtr_OD){ // out to stager
								
	CablePath_Y=BoltCircle_d(Tube_OD=Tube_OD)/2; 
	Exit_a=75;
	BallDetent_a=90;
	nBolts=8;
	DetentBall_d=ST_DetentBall_d;
	CableB_a=Calc_a(5.2,CablePath_Y);
				
	CablePath_ID=7;
								
	//echo(Tube_OD=Tube_OD);
	//echo(Skirt_ID=Skirt_ID);
								
	module CablePath(){
		R=7;
		translate([0,-R,0]) rotate([0,-90,0])			
			rotate([0,0,-0.5]) rotate_extrude(angle=91) translate([R,0,0]) circle(d=6);
			
	} // CablePath
	
	difference(){
		union(){
			// Ball Detent
			rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,-16.5])
				rotate([0,0,12]){
				translate([0,0,-3.5]) ST_BallDetentStopper();
				difference(){
					union(){
						hull(){
							rotate([0,0,100]) ST_BallDetentBody();
							translate([10,0,0]) cylinder(d=8, h=16.5);
							translate([-10,0,0]) cylinder(d=8, h=16.5);
						} // hull
					} // union
					translate([0,0,5]) cylinder(d=DetentBall_d+IDXtra*2, h=17);
					translate([0,0,16.5]) cylinder(d=30, h=20);
					translate([10,0,16.5]) Bolt4Hole();
					translate([-10,0,16.5]) Bolt4Hole();
				} // difference
				}
			
			difference(){
				translate([0,0,-20]) {
					CenteringRing(OD=Tube_ID-IDXtra, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=0);
					Tube(OD=InnerTube_OD+Bolt4Inset*4, ID=InnerTube_OD+IDXtra*2, Len=10, myfn=$preview? 36:360);
					Tube(OD=InnerTube2_OD+Bolt4Inset*4, ID=InnerTube2_OD+IDXtra*2, Len=20, myfn=$preview? 36:360);
				}
				// Ball Detent clearance
				rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,-16]) 
					cylinder(d=14-Overlap, h=30);
			} // difference
			
			// vertical tube for cable
			rotate([0,0,Cable_a(CablePath_Y)]) translate([0,CablePath_Y,-20]) cylinder(d=10, h=20);
			
			intersection(){
				union(){
					//Stager cable
						rotate([0,0,Cable_a(CablePath_Y)+180]) hull(){
						translate([0,Tube_OD/2,-20-Overlap]) cylinder(d=CablePath_ID+3, h=25+Overlap*2);
						translate([0,Skirt_ID/2-4,-20-Overlap]) cylinder(d=CablePath_ID+3, h=25+Overlap*2);
					} // hull
					
					//wires
					rotate([0,0,Cable_a(CablePath_Y)+90]) hull(){
						translate([0,Tube_OD/2,-20-Overlap]) cylinder(d=CablePath_ID+3, h=25+Overlap*2);
						translate([0,Skirt_ID/2-4,-20-Overlap]) cylinder(d=CablePath_ID+3, h=25+Overlap*2);
					} // hull
				} // union
				translate([0,0,-20]) cylinder(d=Tube_ID, h=20);
			} // intersection
				
		} // union
		
		//Cable Bearing
		rotate([0,0,Cable_a(CablePath_Y)-CableB_a])
			translate([0,CablePath_Y-1,3]) rotate([0,0,-CableB_a])
				rotate([-90,0,0]) cylinder(d=15, h=6, center=true);
				
		// Bolt holes
		for (j=[2:nBolts]) rotate([0,0,360/nBolts*(j+1)]) 
			translate([0,InnerTube2_OD/2+Bolt4Inset,0]) Bolt4Hole();
		
		// vertical tube for cable
		rotate([0,0,Cable_a(CablePath_Y)]) translate([0,CablePath_Y,-20-Overlap]) cylinder(d=6, h=25+Overlap*2);
		
		//Stager cable
		rotate([0,0,Cable_a(CablePath_Y)+180]) hull(){
			translate([0,Tube_OD/2,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
			translate([0,Skirt_ID/2-4,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
		} // hull
		
		//wires
		rotate([0,0,Cable_a(CablePath_Y)+90]) hull(){
			translate([0,Tube_OD/2,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
			translate([0,Skirt_ID/2-4,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
		} // hull
	} // difference
	
} // ST_CableRedirect

// ST_CableRedirect();
//ST_CableRedirect(Tube_OD=BT137Body_OD, Skirt_ID=BT137Body_ID, Tube_ID=BT137Coupler_ID, InnerTube_OD=BT54Body_OD, InnerTube2_OD=BT75Body_OD);

module ST_CableEndAndStop(Tube_OD=PML98Body_OD){
	BC_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	nBottomBolts=nInnerRaceBolts;
	Plate_H=4;
	Stop_a=Calc_a(8,BC_r);
	
	module BoltPattern(){
		for (j=[0:1]) rotate([0,0,360/nBottomBolts*j-180/nBottomBolts]) 
			translate([0,BC_r,0]) children();
	} // BoltPattern
	
	module StopPattern(){
		for (j=[0:1]) rotate([0,0,Stop_a]) 
			translate([0,BC_r,0]) children();
		for (j=[0:1]) rotate([0,0,-Stop_a]) 
			translate([0,BC_r,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			// base
			hull() {
				BoltPattern() cylinder(d=10, h=Plate_H);
				StopPattern() cylinder(d=10, h=Plate_H);
			} // hull
			
			rotate([0,0,Stop_a]) 
				translate([0,BC_r,0]) cylinder(d=8, h=10);
			
			rotate([0,0,-Stop_a]) 
				translate([0,BC_r,0]) cylinder(d=8, h=7);
			
			// Manual Set and Trigger lever
			translate([0,BC_r+4,3.5])
				cube([6,12,7],center=true);
		} // union
		
		// cable end retension
		rotate([0,0,-Stop_a]) translate([0,BC_r,0]) {
			rotate([0,-90,0]) hull(){ 
				cylinder(d=3.5, h=8); 
				translate([3,0,0]) cylinder(d=3.5, h=8); 
			} // hull
			
			// cable end insertion hole
			translate([5.4,0,-Overlap]) cylinder(d=3.6, h=Plate_H+Overlap*2);
			
			hull(){
				translate([Overlap,0,-Overlap]) rotate([0,90,0]) cylinder(d=1.5, h=5);
				translate([Overlap,0,4.5]) rotate([0,75,0]) cylinder(d=1.2, h=5);
			} // hull
		}
		
		translate([0,0,-Overlap]) cylinder(r=BC_r-Bolt4Inset, h=Plate_H+Overlap*2);
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
	
} // ST_CableEndAndStop

//rotate([0,180,-60]) ST_CableEndAndStop();

module ST_LockRing(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD){
	BallCircle_r=LockBallCircle_d(InnerTube_OD=InnerTube_OD)/2;
	Race_W=InnerRace_w;
	nBalls=nLockBalls;
	nBolts=nInnerRaceBolts;//*4; // allow 15° indexing
	Offset_a=-Calc_a(10,BallCircle_r);
	
	BallLocked_a=Calc_a((BearingBall_d/2.5),BallCircle_r); // was 6
	//echo(BallLocked_a=BallLocked_a);
	BallUnlocked_a=Calc_a((BearingBall_d*1.25),BallCircle_r); // was 20
	//echo(BallUnlocked_a=BallUnlocked_a);
	BallInsertion_a=Calc_a((BearingBall_d*1.40),BallCircle_r); // was 22
	//echo(BallInsertion_a=BallInsertion_a);
	
	difference(){
		OnePieceInnerRace(BallCircle_d=BearingBallCircle_d(Tube_OD=Tube_OD), Race_ID=Race_ID(InnerTube_OD=InnerTube_OD), Ball_d=BearingBall_d, 
						Race_w=Race_W, PreLoadAdj=ST_PreLoadAdj, 
						VOffset=0.00, BI=false, myFn=$preview? 90:720);
		
		// locked
		for (j=[0:nBalls-1]) 
			for (k=[0:BallLocked_a-1])
				hull(){
					rotate([0,0,Offset_a+360/nBalls*j-k]) translate([0, BallCircle_r, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,Offset_a+360/nBalls*j-k-1]) translate([0, BallCircle_r, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
			
		// Ramp to locked position		
		for (j=[0:nBalls-1]) 
				hull(){
					rotate([0,0,Offset_a+360/nBalls*j-BallLocked_a]) translate([0, BallCircle_r, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,Offset_a+360/nBalls*j-BallUnlocked_a]) translate([0, BallCircle_r+2.5, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,Offset_a+360/nBalls*j-BallUnlocked_a]) translate([0, BallCircle_r, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
				
		// unlocked	
		for (j=[0:nBalls-1]) 
			for (k=[BallUnlocked_a:BallInsertion_a])
				hull(){
					rotate([0,0,Offset_a+360/nBalls*j-k]) translate([0, BallCircle_r+2.5, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,Offset_a+360/nBalls*j-k]) translate([0, BallCircle_r, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,Offset_a+360/nBalls*j-k-1]) translate([0, BallCircle_r+2.5, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,Offset_a+360/nBalls*j-k-1]) translate([0, BallCircle_r, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
			
		// Ball insertion	
		for (j=[0:nBalls-1]) 
				hull(){
					rotate([0,0,Offset_a+360/nBalls*j-BallInsertion_a]) 
						translate([0, BallCircle_r+2.5, Race_W/2])
							sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,Offset_a+360/nBalls*j-BallInsertion_a]) 
						translate([0, BallCircle_r, Race_W/2])
							sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,Offset_a+360/nBalls*j-BallInsertion_a]) 
						translate([0, BallCircle_r+4.0, Race_W+1])
							sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,Offset_a+360/nBalls*j-BallInsertion_a]) 
						translate([0, BallCircle_r, Race_W+1])
							sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
				
		
		for (j=[0:nBolts]) rotate([0,0,360/nBolts*j]) 
			translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,Race_W]) Bolt4Hole(depth=Race_W);
	} // difference
	
	if ($preview) for (j=[0:nBalls-1]) rotate([0,0,Offset_a+360/nBalls*j]) 
		translate([0, BallCircle_r, 1+LockBall_d/2])	
			color("Red") sphere(d=LockBall_d);
} // ST_LockRing

//ST_LockRing();

module ST_DetentOnly(Tube_OD=PML98Body_OD){
	Race_W=InnerRace_w;
	BC_d=BoltCircle_d(Tube_OD=Tube_OD);
	nBottomBolts=nInnerRaceBolts;
	BoltCircle_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	Plate_H=4;
	DetentBall_d=3/8*25.4;
	Detent_a=0;
	DetentTravel_a=Calc_a(15,BoltCircle_r);
	DetentXtra=1.7;
	
	module BoltPattern(){
		for (j=[0:1]) rotate([0,0,-30+360/nBottomBolts*j]) 
			translate([0,BoltCircle_r,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			hull(){
				BoltPattern() cylinder(d=10, h=Plate_H);
				
				// Ball Detent
				rotate([0,0,Detent_a]) translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H);
				rotate([0,0,Detent_a+DetentTravel_a]) 
					translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H);
				rotate([0,0,Detent_a-DetentTravel_a]) 
					translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H);
			} // hull
			
			// Ball Detent, raised portion
			hull(){
				rotate([0,0,Detent_a]) 
					translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H+DetentXtra);
				rotate([0,0,Detent_a+DetentTravel_a]) 
					translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H+DetentXtra);
				rotate([0,0,Detent_a-DetentTravel_a]) 
					translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H+DetentXtra);
			} // hull
				
		} // union
		
		// Ball Detent
		rotate([0,0,Detent_a]) translate([0,BoltCircle_r+3,Plate_H+DetentXtra+DetentBall_d/2-1.5])
			sphere(d=DetentBall_d);
		
		translate([0,0,-Overlap]) 
			cylinder(r=BoltCircle_r-Bolt4Inset, h=Plate_H+DetentXtra+Overlap*2);
		
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
	

} // ST_DetentOnly

//rotate([0,180,-60]) ST_DetentOnly();
//ST_DetentOnly(Tube_OD=BT137Body_OD, InnerTube_OD=BT75Body_OD);

module ST_LockBallRetainer(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD){
	Race_W=InnerRace_w;
	BC_d=BoltCircle_d(Tube_OD=Tube_OD);
	
	BallCircle_r=LockBallCircle_d(InnerTube_OD=InnerTube_OD)/2;
	Offset_a=-Calc_a(10,BallCircle_r);
	BallInsertion_a=Offset_a-Calc_a((BearingBall_d*1.40),BallCircle_r);
	
	nBottomBolts=nInnerRaceBolts;
	Plate_H=4;
	nBalls=nLockBalls;
	DetentBall_d=3/8*25.4;
	
	Path_a=Calc_a(11,(BC_d/2)) ; // was 17
	
	module BoltPattern(){
		for (j=[0:nBottomBolts-1]) rotate([0,0,360/nBottomBolts*j]) 
			translate([0,BC_d/2,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			hull(){
				BoltPattern() cylinder(d=10, h=Plate_H);
				
				for (j=[0:nBalls-1]) 
					rotate([0,0,360/nBalls*j+BallInsertion_a]) 
						translate([0, LockBallCircle_d(InnerTube_OD=InnerTube_OD)/2+3, 0])
							cylinder(d=LockBall_d, h=Plate_H);
			} // hull
			
			// Ball insertion	
			for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j+BallInsertion_a])
				translate([0, LockBallCircle_d(InnerTube_OD=InnerTube_OD)/2+3, -1.5])
						cylinder(d=LockBall_d, h=Plate_H);
				
		} // union
				
		translate([0,0,-Race_W-Overlap]) 
			cylinder(d=Race_ID(InnerTube_OD=InnerTube_OD), h=Race_W+Plate_H+Overlap*2);
		
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
			
} // ST_LockBallRetainer

//translate([0,0,13]) ST_LockBallRetainer(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD);

//ST_LockBallRetainer(Tube_OD=BT137Body_OD, InnerTube_OD=BT75Body_OD);

module ST_BallSpacer(Tube_OD=PML98Body_OD){
	BallCircle_d=BearingBallCircle_d(Tube_OD=Tube_OD);
	Thickness=1.5;
	nBalls=nBearingBalls(Tube_OD=Tube_OD);//12;
	echo(nBalls=nBalls);
	
	difference(){
		cylinder(d=BallCircle_d+BearingBall_d*0.6, h=BearingBall_d/2+Thickness);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=BallCircle_d-BearingBall_d*0.6, h=BearingBall_d/2+Thickness+Overlap*2);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) 
			translate([BallCircle_d/2,0,BearingBall_d/2+Thickness])
				sphere(d=BearingBall_d+LooseFit, $fn=36);
			
		for (j=[0:nBalls/2-1]) rotate([0,0,720/nBalls*j-180/nBalls]){
			translate([BallCircle_d/2,0,0]) rotate([180,0,0]) Bolt2Hole();
			rotate([0,0,360/nBalls]) translate([BallCircle_d/2,0,0]) rotate([180,0,0]) Bolt2HeadHole();
		}
	} // difference
} // ST_BallSpacer

//ST_BallSpacer();

module ST_MT_DrillingJig(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Body_OD, Skirt_Len=30){
	// Sits on top of CableRedirect in place of Frame
	H=16; // same as the ball keeper
	nBalls=nLockBalls;
	Ball1_a=60;
	Race_W=OuterRace_w;
	BallCircle_r=LockBallCircle_d(InnerTube_OD=InnerTube_OD)/2;
	Offset_a=-Calc_a(10,BallCircle_r);
	CablePath_Y=BoltCircle_d(Tube_OD)/2; 
	
	// Skirt
	translate([0,0,-Skirt_Len]) 
		Tube(OD=Tube_OD, ID=Skirt_ID+IDXtra, Len=Skirt_Len+Overlap*2, myfn=$preview? 36:360);
			
	translate([0,0,-13]) 
		TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
			
	// Alignment key
	intersection(){
		translate([0,Skirt_ID/2,-16]) cylinder(d=4,h=5);
			
		translate([0,0,-18]) cylinder(d=Skirt_ID+1, h=40);
	} // intersection

	
	difference(){
		union(){
			translate([0,0,Race_W/2]) cylinder(d=InnerTube_OD+20, h=H, center=true);
			translate([0,0,Race_W/2-H/2]) cylinder(d=Tube_OD, h=4);
			
			// Cable Alignment
			rotate([0,0,Cable_a(CablePath_Y)]) 
				translate([0,Tube_OD/2-5,Race_W/2-H/2]) cylinder(d=5, h=5);
		} // union
		
		for (j=[0:nBalls-1]) rotate([0,0,Offset_a+360/nBalls*j]) translate([0,0,Race_W/2])
			rotate([-90,0,0]) cylinder(d=BearingBall_d-2, h=InnerTube_OD);
			
		translate([0,0,Race_W/2]) cylinder(d=InnerTube_OD+IDXtra*3, h=H+Overlap*2, center=true);
	} // difference
} // ST_MT_DrillingJig

//ST_MT_DrillingJig();
//ST_MT_DrillingJig(Tube_OD=BT137Body_OD, Skirt_ID=BT137Body_ID, InnerTube_OD=BT75Body_OD, Skirt_Len=34);

module ST_Frame(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Collar_Len=26, Skirt_Len=34,
			HasStagerCableRaceway=true,
			HasWireRaceway=true){
	
	Race_W=OuterRace_w;
	SkirtTubeStop_Z=-13;
	CollarTubeStop_Z=17; // added 1 11/5/22
	BC_d=BoltCircle_d(Tube_OD=Tube_OD);
	Raceway_Len=36;
	Raceway_Z=2;
	Raceway_ID=7;
	
	module RacewayHole(){
		translate([0,0,Raceway_Z+Raceway_Len/2]) 
			Raceway_Exit(Tube_OD=Tube_OD, Race_ID=Raceway_ID, Wall_t=4, Top_Len=10, Bottom_Len=10);
		translate([0,0,Raceway_Z-Raceway_Len/2]) rotate([180,0,0]) 
			Raceway_Exit(Tube_OD=Tube_OD, Race_ID=Raceway_ID, Wall_t=4, Top_Len=10, Bottom_Len=10);
	} // RacewayHole
	
	module RacewayOuter(){
		translate([0,0,Raceway_Z+Raceway_Len/2]) 
			Raceway_End(Tube_OD=Tube_OD, Race_ID=Raceway_ID, Wall_t=4, Len=Raceway_Len/2); //External cover end
		translate([0,0,Raceway_Z-Raceway_Len/2]) rotate([180,0,0]) 
			Raceway_End(Tube_OD=Tube_OD, Race_ID=Raceway_ID, Wall_t=4, Len=Raceway_Len/2); //External cover end
	} // RacewayOuter

	rotate([0,0,-Cable_a(BC_d/2)]) // align cable to 0°
	difference(){
		union(){
			// collar
			Tube(OD=Tube_OD, ID=Skirt_ID, Len=Collar_Len+Race_W, myfn=$preview? 36:360);
			translate([0,0,CollarTubeStop_Z]) rotate([180,0,0])
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
	
			ST_OuterRace(Tube_OD=Tube_OD);
			
			// Skirt
			translate([0,0,-Skirt_Len]) 
				Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+Overlap*2, myfn=$preview? 36:360);
			
			translate([0,0,SkirtTubeStop_Z]) 
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
			
			// Alignment key
			intersection(){
				union(){
					translate([0,Skirt_ID/2,SkirtTubeStop_Z-5]) cylinder(d=4,h=5);
					translate([0,Skirt_ID/2,SkirtTubeStop_Z-Overlap]) cylinder(d2=3, d1=4, h=2+Overlap);
					
					translate([0,Skirt_ID/2,CollarTubeStop_Z-2]) cylinder(d1=3, d2=4, h=2+Overlap);
					translate([0,Skirt_ID/2,CollarTubeStop_Z]) cylinder(d=4,h=5);
				} // union
				
				// don't protrude
				translate([0,0,-18]) cylinder(d=Skirt_ID+1, h=40);
			} // intersection
	
		} // union
		
		// Sustainer wires 270°
		if (HasWireRaceway) rotate([0,0,Cable_a(BC_d/2)+180]) RacewayHole();
		
		// Stager Cable 180°
		if (HasStagerCableRaceway) rotate([0,0,Cable_a(BC_d/2)-90]) RacewayHole();
		
		// Arm / Trigger access hole
		rotate([0,0,-30])
			translate([0, BearingBallCircle_d(Tube_OD=Tube_OD)/2-2, -3]) 
				rotate([0,90,0]) cylinder(d=3, h=Tube_OD, center=true);
		
	} // difference
	
	// Sustainer wires
	if (HasWireRaceway) rotate([0,0,180]) RacewayOuter();
	
	// Stager Cable 180°
	if (HasStagerCableRaceway) rotate([0,0,-90]) RacewayOuter();
	
} // ST_Frame

//ST_Frame(Tube_OD=BT137Body_OD, Skirt_ID=BT137Body_ID,HasStagerCableRaceway=true, HasWireRaceway=true);
//ST_Frame(HasStagerCableRaceway=true, HasWireRaceway=true);

module ST_OuterRace(Tube_OD=PML98Body_OD){
	Race_W=OuterRace_w;
	
	OnePieceOuterRace(BallCircle_d=BearingBallCircle_d(Tube_OD=Tube_OD), Race_OD=Tube_OD-1, 
					Ball_d=BearingBall_d, Race_w=Race_W, PreLoadAdj=ST_PreLoadAdj, 
					VOffset=0.00, BI=false, myFn=$preview? 90:720);
	
	
} // ST_OuterRace

//ST_OuterRace();

module ST_TubeEnd(Tube_OD=BT54Coupler_OD, Tube_ID=BT54Coupler_ID){
	
	difference(){
		union(){
			cylinder(d=Tube_OD,h=2);
			cylinder(d=Tube_ID,h=6);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=Tube_ID-4, h=6+Overlap*2);
		translate([-Tube_OD/2-1,0,-Overlap]) cube([Tube_OD+2,Tube_OD,6+Overlap*2]);
	} // difference
} // ST_TubeEnd

//ST_TubeEnd();

module ST_TubeLock(Tube_OD=BT54Coupler_OD, Skirt_ID=BT54Coupler_ID-2, SkirtLen=0){
	echo(Tube_OD=Tube_OD);
	H=(SkirtLen>0)? LockBall_d+2:LockBall_d+7;
	
	if (SkirtLen>0)
		translate([0,0,H-Overlap]) Tube(OD=Tube_OD, ID=Skirt_ID, Len=SkirtLen, myfn=$preview? 36:360);
	
	difference(){
		cylinder(d=Tube_OD, h=H);
			
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_OD, h=4);
		cylinder(d=ST_DSpring_ID, h=H+7);
		translate([0,0,H-5]) cylinder(d1=ST_DSpring_ID, d2=ST_DSpring_ID+7, h=5+Overlap);
		//translate([0,0,5 ]) cylinder(d=ST_DSpring_ID,h=15);
		
		translate([0,0,1+LockBall_d/2]) rotate_extrude()
			translate([LockBallCircle_d(InnerTube_OD=Tube_OD+3)/2,0,0]) circle(d=LockBall_d+IDXtra);
	} // difference
} // ST_TubeLock

//ST_TubeLock(Tube_OD=BT54Coupler_OD, Skirt_ID=BT54Coupler_ID-2, SkirtLen=15);
//ST_TubeLock(Tube_OD=BT75Coupler_OD, Skirt_ID=BT75Coupler_ID-2, SkirtLen=30);


module ST_TubeLockLanyard(Skirt_ID=BT54Coupler_ID-2){
	nSpokes=6;
	
	difference(){
		union(){
			cylinder(d=Skirt_ID, h=10);
			translate([0,0,-5]) cylinder(d1=ST_DSpring_ID, d2=ST_DSpring_ID+7, h=5+Overlap);
		} // union
		
		difference(){
			union(){
				cylinder(d=Skirt_ID-4.4, h=10+Overlap*2);
				translate([0,0,-5-Overlap]) 
					cylinder(d1=ST_DSpring_ID, d2=ST_DSpring_ID+7, h=5+Overlap*2);
			} // union
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j+180/nSpokes]) 
				translate([-2,0,-5-Overlap*2]) cube([4,Skirt_ID/2,15+Overlap*4]);
			translate([0,0,-5-Overlap*2]) cylinder(d=14.4, h=15+Overlap*4);
		} // difference
		
		hull(){
			translate([0,0,-5-Overlap]) cylinder(d=5, h=15+Overlap*2);
			translate([0,10,-5-Overlap]) cylinder(d=5, h=15+Overlap*2);
		} // hull
		
		translate([0,0,2]){
			sphere(d=10);
			cylinder(d=10, h=12+Overlap);
			}
	} // difference
} // ST_TubeLockLanyard

//translate([0,0,12]) ST_TubeLockLanyard();























