// ***********************************
// Project: 3D Printed Rocket
// Filename: Stager2Lib.scad
// by David M. Flynn
// Created: 10/10/2022 
// Revision: 1.0.2  10/29/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
// 2/2/2023 0.9.23 printed and assembled a full set of parts for 98mm/3.9" rocket. Worked!
// Printed a 137mm version, it works.
//
// Specifically built for a 4 inch rocket.
// It could be modified to a larger tube, but smaller would be hard. 
//
// A non-pyro active staging or dual deployment system.
// The "cup" is tightly held to the saucer until triggered.
// Minimum tube is about 4 inches. 
//
// My first intended use is a 4 inch 2 stage rocket. 
// At booster stage burnout: drop away from the sustainer and deploy a parachute.
//
// Parts 2 locks/3 locks
// ---------------
// 9/13 3/8" Delrin Balls for 2 locks
// 6 #4-40 x 1/4" Socket head cap screws (Lock Ring)
// 10 #4-40 x 1/4" Button head screws (saucer, ball detent, CableEndAndStop, add 4 for electrical conns) 
// 6/8  #2-56 x 1/4" Socket head cap screws (ball spacer)
// 4/6  #6-32 x 3/8" Button head cap screws (lock rods)
// 2/3 5/16" Dia. x 1-1/4" strong spring
// 1 5/16" Dia. x 3/4" 0.3" OD, 0.028" Wire, WB Jones p/n C10-028-024 light spring (ball detent)
// length of 1/32" or 1mm wire rope and 2 copper crimp on ends
// MR84 bearing 8mm OD x 4mm ID x 3mm thick
// 4mm x 16mm undersize steel dowel pin
// A 4 pin Molex connector is required for booster separation detection and sustainer ignition. 
// 
//  ***** Assembly Instructions *****
// -------------------------------------------------
//  Print all parts, PETG 0.4mm nozzle
//    0.3mm layers, 30% honey comb infil, 3 perimeters, 3 botoom layers, 3 top layers
//  Insert 3/8" Delrin lock balls 4 per lock
//  Insert lock ring, sit saucer in place 
//  Prepair ball spacers, drill 1/16" or #2-56 tap drill, cleanup counter bores w/ 9/64" drill
//    remove all brim and sand inside and out to fit loose between inner and outer races. 
//  Sit one ball spacer in place, then inner race w/ ball groove up/aligned to outer race
//  Install 5/16" Delrin balls and the other ball spacer, Install #2-56 screws
//  Install 6ea. #4-40 x 3/8" socket head screws connecting lock ring to inner race
//
//  ***** History *****
//
echo("StagerLib 1.0.2");
// 1.0.2   10/29/2023  Remved IDXtra*2 from OD of CableRedirect
// 1.0.1   5/16/2023   Added Height parameter to Stager_CableRedirect()
// 1.0.0   2/6/2023    It works good.
// 0.9.25  2/4/2023    Added inner tube skirt to Stager_Drogue_Cup
// 0.9.24  2/3/2023    Added Stager_Drogue_Cup()
// 0.9.23  2/2/2023    Added Stager_CableBearing() easier to pull.
// 0.9.22  12/16/2022  Added wire chanel to CableRedirect so wire don't get lost between centering rings.
// 0.9.21  12/13/2022  Small adjustments, centering rings to +IDXtra*2, built a 98mm version complete. 
// 0.9.20  12/4/2022   Tighter balls
// 0.9.19  12/2/2022   Reworked Stager_CableEndAndStop, re-did angle calculations
// 0.9.18  11/30/2022  Too tight added 0.5mm to LockingBallOffset
// 0.9.17  11/26/2022  More updates "Stager_" prefix
// 0.9.16  11/23/2022  Replaced some numbers w/ calculations
// 0.9.15  11/14/2022  5.5"? Not yet. 
// 0.9.14  11/11/2022  Code clean up.  
// 0.9.13  11/6/2022   Cleaned up ShowStager(). FC4
// 0.9.12  11/2/2022   Fixed CableEndAndStop for esier assembly, CableEndAndStop stop -6° about 3mm
// 0.9.11  11/1/2022   Back to 15° indexing, added electrical connection to saucer
// 0.9.10  10/31/2022  Added Raceway, Increased ID by 2mm
// 0.9.9  10/30/2022   Stager2 complete redesign, was too complex to be reliable
// 0.9.8  10/26/2022   Realigned the keys, FC3. 
// 0.9.7  10/25/2022   Small fixes, FC2
// 0.9.6  10/24/2022   Added a key to CableRedirect and KeyOffset_a to Stager_Mech
// 0.9.5  10/21/2022   FC1: Worked fully assembled for the first time.
// 0.9.4  10/17/2022   Added CableRedirect(). 
// 0.9.3  10/16/2022   Adapted to booster/sustainer. 
// 0.9.2  10/14/2022   Arming key, added 1.5mm to tube length
// 0.9.1  10/13/2022   Time to print a test article. 
// 0.9.0  10/10/2022   First code.
//
// ***********************************
//  ***** for STL output *****
//
// Stager_Drogue_Cup(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, HasInnerTube=true, InnerTube_OD=BT54Body_OD, nLocks=2, nFins=5, MultiStage=false, RG_H_Xtra=2);
//Stager_Drogue_Cup(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, HasInnerTube=true, InnerTube_OD=BT75Body_OD, nLocks=3, nFins=3, MultiStage=true, RG_H_Xtra=2);
// rotate([180,0,0]) Stager_Cup(Tube_OD=PML98Body_OD, ID=78, nLocks=2, BoltsOn=true);
// rotate([-90,0,0]) Stager_LockRod(Adj=0); // using this one
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5);
// rotate([-90,0,0]) Stager_LockRod(Adj=1.0);

// Stager_Saucer(Tube_OD=PML98Body_OD, nLocks=2, HasElectrical=false); // Bolts on
// Stager_Saucer(Tube_OD=BT137Body_OD, nLocks=3, HasElectrical=true); // Bolts on
// Stager_SaucerEConnHolder(Tube_OD=PML98Body_OD);
// Stager_SaucerEConnHolder(Tube_OD=BT137Body_OD);

// Stager_LockRing(Tube_OD=PML98Body_OD, nLocks=2, FlexComp_d=0.8); 
// Stager_LockRing(Tube_OD=BT137Body_OD, nLocks=3, FlexComp_d=0.8); 
//
// Stager_Mech(Tube_OD=PML98Body_OD, nLocks=2, Skirt_ID=PML98Body_ID, Skirt_Len=30, KeyOffset_a=0, HasRaceway=false, Raceway_a=270);
// Stager_Mech(Tube_OD=BT137Body_OD, nLocks=3, Skirt_ID=BT137Body_ID, Skirt_Len=30, KeyOffset_a=0, HasRaceway=true, Raceway_a=300);
//
// Stager_InnerRace(Tube_OD=PML98Body_OD);
// Stager_InnerRace(Tube_OD=BT137Body_OD);
// Stager_BallSpacer(Tube_OD=PML98Body_OD);
// Stager_BallSpacer(Tube_OD=BT137Body_OD);
// Stager_CableRedirectTop(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD, HasRaceway=true, Raceway_a=270);
// Stager_CableRedirectTop(Tube_OD=BT137Body_OD, Skirt_ID=BT137Body_ID, InnerTube_OD=BT75Body_OD, HasRaceway=true, Raceway_a=300);
// Stager_CableBearing();
// Stager_CableRedirect(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD, HasRaceway=true, Raceway_a=270, Height=20);
// Stager_CableRedirect(Tube_OD=BT137Body_OD, Skirt_ID=BT137Body_ID, Tube_ID=BT137Coupler_ID, InnerTube_OD=BT75Body_OD, HasRaceway=true, Raceway_a=300);
// Stager_CableEndAndStop(Tube_OD=PML98Body_OD, Xtra3=false);
// Stager_CableEndAndStop(Tube_OD=BT137Body_OD, Xtra3=false);
// Stager_Detent(Tube_OD=PML98Body_OD);
// Stager_Detent(Tube_OD=BT137Body_OD);
//
// ***********************************
//  ***** Routines *****
//
// Stager_CupHoles(Tube_OD=PML98Body_OD, ID=78, nLocks=2, BoltsOn=true);
// Stager_Cup(Tube_OD=PML98Body_OD, ID=78, nLocks=2);
// Stager_SaucerBoltPattern(Tube_OD=PML98Body_OD, nLocks=2);
// Stager_ArmDisarmAccess(Tube_OD=PML98Body_OD, KeyOffset_a=0, Len=PML98Body_OD);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowStager();
// ShowStagerAssy(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, CouplerTube_ID=BT137Coupler_ID, InnerTube_OD=PML75Body_OD, nLocks=3, ShowLocked=true);
//
// ***********************************

include<TubesLib.scad>
include<BearingLib.scad>
use<RacewayLib.scad>
use<RailGuide.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

// Heavy spring
Stager_Spring_OD=5/16*25.4;
Stager_Spring_FL=1.25*25.4;
Stager_Spring_CBL=0.7*25.4;

Stager_LockRod_X=10;
Stager_LockRod_Y=5;
Stager_LockRod_Z=36;
Stager_LockRod_R=1;
LockBall_d=3/8 * 25.4; // 3/8" Delrin balls
DetentBall_d=3/8 * 25.4;

LooseFit=0.8;
StagerLockInset_Y=11.5; // was 12.5

nInnerRaceBolts=6;
Bolt4Inset=4;
Saucer_Len=6;
Ball_d=5/16*25.4;
Stager_PreLoadAdj=-0.35;
Race_W=11;
Tube_Len=40; //44.5;
Race_Z=-Saucer_Len-Tube_Len;
EConnInset=6.5; // use Saucer_ID/2+EConnInset
Stager_LockingBallOffset=LockBall_d+0.2; // was 0.5 changed to 0.2 12/12/22
CamBall_a=-30;
CamBall_a2=20;

function Calc_a(Dist=1,R=2)=Dist/(R*2*PI)*360;
function BearingBallCircle_d(Tube_OD=PML98Body_OD)=Tube_OD-6-Ball_d;
function Race_ID(Tube_OD=PML98Body_OD)=BearingBallCircle_d(Tube_OD=Tube_OD)-Ball_d-Bolt4Inset*4;
function BoltCircle_d(Tube_OD=PML98Body_OD)=Race_ID(Tube_OD=Tube_OD)+Bolt4Inset*2;
function Saucer_ID(Tube_OD=PML98Body_OD)=Tube_OD-StagerLockInset_Y*2-Stager_LockRod_Y-6;
function nBearingBalls(Tube_OD=PML98Body_OD)=floor(BearingBallCircle_d(Tube_OD=Tube_OD)*PI/Ball_d/3)+
					(floor(BearingBallCircle_d(Tube_OD=Tube_OD)*PI/Ball_d/3)%2);

// ============================================================================ //

module ShowStager(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID,
					CouplerTube_ID=PML98Coupler_ID, 
					InnerTube_OD=BT54Mtr_OD, nLocks=2){
	
	translate([0,0,30]) Stager_Cup(Tube_OD=Tube_OD, ID=Tube_OD-24, nLocks=nLocks);
	translate([0,0,10]) color("LightBlue") Stager_Saucer(Tube_OD=Tube_OD, nLocks=nLocks, HasElectrical=false);
	Stager_Mech(Tube_OD=Tube_OD, nLocks=nLocks, Skirt_ID=Tube_ID, Skirt_Len=30, KeyOffset_a=0, HasRaceway=true, Raceway_a=270);
	
	translate([0,0,-140]) Stager_LockRing(Tube_OD=Tube_OD, nLocks=nLocks);
	
	//*
	translate([0,0,-150]) {
		translate([20,0,-40]) rotate([180,0,120]) Stager_CableEndAndStop(Tube_OD=Tube_OD);
		translate([0,0,-10]) Stager_InnerRace(Tube_OD=Tube_OD);
		translate([0,0,-30]) Stager_BallSpacer(Tube_OD=Tube_OD);
		translate([0,0,0]) rotate([180,0,0]) Stager_BallSpacer(Tube_OD=Tube_OD);
		rotate([0,180,120]) translate([0,20,40]) Stager_Detent(Tube_OD=Tube_OD);
	}
	/**/
	translate([0,0,-210]) {
		Stager_CableRedirectTop(Tube_OD=Tube_OD, Skirt_ID=Tube_ID, 
				InnerTube_OD=InnerTube_OD, HasRaceway=true, Raceway_a=270);
		translate([0,0,-25]) 
			Stager_CableRedirect(Tube_OD=Tube_OD, Skirt_ID=Tube_ID, 
							Tube_ID=CouplerTube_ID, 
							InnerTube_OD=InnerTube_OD,
							HasRaceway=true,
							Raceway_a=270);
		
	}
	
} // ShowStager

// ShowStager();
/*
ShowStager(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID,
			CouplerTube_ID=BT137Coupler_ID,
			InnerTube_OD=PML75Body_OD, nLocks=3);
/**/

module ShowStagerAssy(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_OD,
					CouplerTube_ID=PML98Coupler_ID, 
					InnerTube_OD=BT54Mtr_OD, nLocks=2, ShowLocked=true){
	
	// Shown in the locked position?
	Lock_a=	ShowLocked? 0:Calc_a(11,(BoltCircle_d(Tube_OD=PML98Body_OD)/2));
						
	
	Sep_Z=28; // 23 down from bearing

	translate([0,0,1]) Stager_LockRing(Tube_OD=Tube_OD, nLocks=nLocks);

	//*
	translate([0,0,-Race_Z]) 
	difference(){
		Stager_Mech(Tube_OD=Tube_OD, nLocks=nLocks, Skirt_ID=Tube_ID, Skirt_Len=30, KeyOffset_a=0);
		rotate([0,0,-45]) translate([0,0,-90]) cube([100,100,100]);
	}
	/**/

	//*
	//translate([0,0,Tube_Len+6+0.2]) Stager_Saucer();
	translate([0,0,-Sep_Z]) Stager_CableRedirectTop(Tube_OD=Tube_OD, Skirt_ID=Tube_ID, InnerTube_OD=InnerTube_OD, HasRaceway=false, Raceway_a=270);

	rotate([0,0,Lock_a]){
		Stager_InnerRace(Tube_OD=Tube_OD);
		translate([0,0,-12]) rotate([0,180,120]) Stager_Detent(Tube_OD=Tube_OD);

		translate([0,0,-12]) 
			rotate([0,180,-45]) Stager_CableEndAndStop(Tube_OD=Tube_OD);
	}
	/**/
					
} // ShowStagerAssy

//ShowStagerAssy(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, CouplerTube_ID=BT137Coupler_ID, InnerTube_OD=PML75Body_OD, nLocks=3, ShowLocked=true);

module BallDetentBody(){
	DetentSpring_d=7.7;
	DetentSpring_Len=14; // Lightly compressed
	Body_d=14;
	Body_Len=27;
	Nose_h=2;
	Protusion=1.5;
	
	difference(){
		union(){
			translate([0,0,Body_Len-Nose_h-Overlap]) cylinder(d1=Body_d, d2=DetentBall_d, h=Nose_h);
			cylinder(d=Body_d, h=Body_Len-Nose_h);
		} // union
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=DetentBall_d+LooseFit, h=Overlap);
			translate([0,0,Body_Len-DetentBall_d/2+Protusion]) sphere(d=DetentBall_d+LooseFit);
		} // hull
		
		
		if ($preview){
			translate([0,0,-Overlap]) cube([40,40,40]);
			
		}
	} // difference
	
	if ($preview) translate([0,0,Body_Len-DetentBall_d/2+Protusion]) color("Red") sphere(d=DetentBall_d);
} // ST_BallDetentBody

//ST_BallDetentBody();

module Stager_BallDetentStopper(Body_Len=27){
	DetentSpring_d=7.7;
	DetentSpring_Len=14; // Lightly compressed
	Body_d=14;
	
	Nose_h=2;
	Protusion=1.5;
	BottomOfSpring_h=3+Body_Len-DetentBall_d/2+Protusion-DetentSpring_Len;
	
	cylinder(d=Body_d-IDXtra*2, h=3);
	
	difference(){
		cylinder(d=DetentBall_d, h=BottomOfSpring_h+2);
		translate([0,0,BottomOfSpring_h]) cylinder(d=DetentSpring_d+IDXtra, h=3);
	} // difference
	
} // Stager_BallDetentStopper

//translate([0,0,-3]) Stager_BallDetentStopper(Body_Len=21);

module Stager_CableBearing(){
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
} // Stager_CableBearing

//Stager_CableBearing();

module Stager_CableRedirectTop(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, 
							InnerTube_OD=BT54Mtr_OD,
							HasRaceway=false,
							Raceway_a=270){
								
	// Orientation: Cable is at 0°
	// Cable_Offset_a must be a multiple of 15°
								
	nBolts=8;
	CablePath_Y=BoltCircle_d(Tube_OD=Tube_OD)/2;
	Exit_a=75;
	
	Cable_Offset_a=15*round((-60+Calc_a(12,CablePath_Y)+Calc_a(26,CablePath_Y) )/15);
	echo(Cable_Offset_a=Cable_Offset_a);	
	Stop_a= -Cable_Offset_a-60-Calc_a(21,CablePath_Y);
	BackStop_a=Stop_a+Calc_a(21+12,CablePath_Y);
	Cable_a=BackStop_a+Calc_a(26,CablePath_Y);
	echo(Cable_a=Cable_a);
								
	BallDetent_a=60-Calc_a(5,CablePath_Y); // 5mm past 60°
	Key_a=0;
	CablePath_ID=7;
	CableB_a=Calc_a(5.2,CablePath_Y);
								
	echo(CablePath_Y=CablePath_Y);
	echo(Stop_a=Stop_a);
								
	module CablePath(){
		R=7;
		translate([0,-R,0]) rotate([0,-90,0])			
			rotate([0,0,-0.5]) rotate_extrude(angle=91) translate([R,0,0]) circle(d=6);
			
	} // CablePath
	

	rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,-16.5])
		difference(){
			rotate([0,0,100]) BallDetentBody();
			
			translate([0,0,-Overlap]) cylinder(d=25, h=16.5);
		} // difference

	difference(){
		union(){
			rotate([0,0,22.5]) CenteringRing(OD=Skirt_ID, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=0);
			
			//Cable Bearing
			difference(){
				rotate([0,0,Cable_a-CableB_a])
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
				
			// Locked position stop
			rotate([0,0,Stop_a]) translate([0,CablePath_Y,0]) cylinder(d=8, h=10);
			
			// Unlocked position stop, allow 10mm of movement
			rotate([0,0,BackStop_a]) translate([0,CablePath_Y,0]) cylinder(d=8, h=8.5);
			
		} // union
		
		//Cable Bearing
		rotate([0,0,Cable_a-CableB_a])
			translate([0,CablePath_Y-1,3]) rotate([0,0,-CableB_a]){
				rotate([-90,0,0]) cylinder(d=15, h=6, center=true);
				rotate([-90,0,0]) cylinder(d=4+IDXtra*2, h=50, center=true);
				}
				
		// Bolt holes
		for (j=[2:nBolts]) rotate([0,0,180/nBolts+360/nBolts*j-5]) translate([0,InnerTube_OD/2+Bolt4Inset,5])
			Bolt4HeadHole();
		
		rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,5]) {
			translate([10,0,0]) Bolt4HeadHole();
			translate([-10,0,0]) Bolt4HeadHole();
		}
		
		// Wire path
		if (HasRaceway) rotate([0,0,Raceway_a]) hull(){
			translate([0,Skirt_ID/2,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
			translate([0,Skirt_ID/2-4,-20-Overlap]) cylinder(d=CablePath_ID, h=25+Overlap*2);
		}
		
		// Ball Detent
		rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,-21]) cylinder(d=14-Overlap, h=30);

		rotate([0,0,Cable_a]) translate([0,CablePath_Y,1]) rotate([0,0,Exit_a]) CablePath();
		
		// vertical tube for cable
		rotate([0,0,Cable_a]) translate([0,CablePath_Y,-20-Overlap]) cylinder(d=6, h=25+Overlap*2);
		
		// Alignment Key
		rotate([0,0,Key_a]) translate([0,Skirt_ID/2,-Overlap]) cylinder(d=5, h=5+Overlap*2);
	} // difference
	
} // Stager_CableRedirectTop

//Stager_CableRedirectTop(HasRaceway=true);
/*
Stager_CableRedirectTop(Tube_OD=BT137Body_OD, Skirt_ID=BT137Body_ID, 
							InnerTube_OD=PML75Body_OD,
							HasRaceway=true,
							Raceway_a=300);
/**/

/*
Stager_CableRedirect(Tube_OD=PML150Body_OD, Skirt_ID=PML150Body_ID, 
							Tube_ID=PML150Coupler_ID, 
							InnerTube_OD=PML75Body_OD,
							HasRaceway=true,
							Raceway_a=270);
/**/

module Stager_CableRedirect(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, 
							Tube_ID=PML98Coupler_ID, 
							InnerTube_OD=BT54Mtr_OD,
							HasRaceway=false,
							Raceway_a=270,
							Height=20){
								
	// Orientation: Cable is at 0°
	nBolts=8;
	CablePath_Y=BoltCircle_d(Tube_OD=Tube_OD)/2;
	Exit_a=75;
	Cable_Offset_a=15*round((-60+Calc_a(12,CablePath_Y)+Calc_a(26,CablePath_Y) )/15);
	Stop_a= -Cable_Offset_a-60-Calc_a(16,CablePath_Y);// 53mm= -84 for PML98Body_OD
	BackStop_a=Stop_a+Calc_a(16+12,CablePath_Y);
	Cable_a=BackStop_a+Calc_a(26,CablePath_Y);
	BallDetent_a=60-Calc_a(5,CablePath_Y); // 5mm past 60°
	Key_a=0;
	CablePath_ID=7;
	CableB_a=Calc_a(5.2,CablePath_Y);
								
	//echo(CablePath_Y=CablePath_Y);
	//echo(Stop_a=Stop_a);
								
	module CablePath(){
		R=7;
		translate([0,-R,0]) rotate([0,-90,0])			
			rotate([0,0,-0.5]) rotate_extrude(angle=91) translate([R,0,0]) circle(d=6);
			
	} // CablePath
	
	
	// Ball Detent Spring Holder
	rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,-Height+3.5]){
		translate([0,0,-3.5]) Stager_BallDetentStopper(Body_Len=Height+7);
		difference(){
			union(){
				hull(){
					rotate([0,0,100]) BallDetentBody();
					translate([10,0,0]) cylinder(d=8, h=Height-3.5);
					translate([-10,0,0]) cylinder(d=8, h=Height-3.5);
				} // hull
			} // union
			// Spring goes here
			cylinder(d=DetentBall_d+IDXtra*2, h=Height-3);
			// Trim top
			translate([0,0,Height-3.5]) cylinder(d=30, h=Height+10);
			// Bolt holes
			translate([10,0,Height-3.5]) Bolt4Hole();
			translate([-10,0,Height-3.5]) Bolt4Hole();
		} // difference
	}
	

	difference(){
		union(){
			
			translate([0,0,-Height]) {
				rotate([0,0,-20]) CenteringRing(OD=Tube_ID, ID=InnerTube_OD+IDXtra*2, 
										Thickness=5, nHoles=0);
				Tube(OD=InnerTube_OD+Bolt4Inset*4, ID=InnerTube_OD+IDXtra*2,
						Len=Height, myfn=$preview? 36:360);
			}
			
			// vertical tube
			rotate([0,0,Cable_a]) translate([0,CablePath_Y,-Height]) cylinder(d=10, h=Height);
			
			if (HasRaceway) 
			intersection(){
					
					//wires
					rotate([0,0,Raceway_a]) hull(){
						translate([0,Tube_OD/2,-Height-Overlap]) 
							cylinder(d=CablePath_ID+3, h=Height+Overlap*2);
						translate([0,Skirt_ID/2-4,-Height-Overlap]) 
							cylinder(d=CablePath_ID+3, h=Height+Overlap*2);
					} // hull
				
				translate([0,0,-Height]) cylinder(d=Tube_ID, h=Height);
			} // intersection
			
		} // union
		
		//Cable Bearing
		rotate([0,0,Cable_a-CableB_a])
			translate([0,CablePath_Y-1,3]) rotate([0,0,-CableB_a])
				rotate([-90,0,0]) cylinder(d=15, h=6, center=true);
				
		// Bolt holes
		for (j=[2:nBolts]) rotate([0,0,180/nBolts+360/nBolts*j-5]) 
			translate([0,InnerTube_OD/2+Bolt4Inset,0]) Bolt4Hole();
		
		// Ball detent bolt holes
		rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,0]) {
			translate([10,0,0]) Bolt4Hole();
			translate([-10,0,0]) Bolt4Hole();
		}
		
		// Wire path
		if (HasRaceway) rotate([0,0,Raceway_a]) hull(){
			translate([0,Skirt_ID/2,-Height-Overlap]) cylinder(d=CablePath_ID, h=Height+Overlap*2);
			translate([0,Skirt_ID/2-4,-Height-Overlap]) cylinder(d=CablePath_ID, h=Height+Overlap*2);
		}
		
		// Ball Detent
		rotate([0,0,BallDetent_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,-Height-1]) 
			cylinder(d=12, h=Height+2);

		
		// vertical tube for cable
		rotate([0,0,Cable_a]) translate([0,CablePath_Y,-Height-Overlap]) cylinder(d=6, h=Height+Overlap*2);
		
		
	} // difference
	
} // Stager_CableRedirect

//Stager_CableRedirect(HasRaceway=false, Height=20);

module Stager_LockRing(Tube_OD=PML98Body_OD, nLocks=2, FlexComp_d=0.8){
	// use FlexComp_d=0.4 for 98mm, FlexComp_d=0.8 for 137mm
	nBolts=nInnerRaceBolts;
	OD=Saucer_ID(Tube_OD=Tube_OD);
	Depth=3;
	Inset=1.0; // was 2, changed to 1.0 12/12/22 66.6 , w/ FlexComp_d=0.4  0.7 too tight, 2.0 too loose for 98mm
	nSteps=15;
	Arc_a=Calc_a(9,(OD/2-Inset));
	echo(Arc_a=Arc_a);
	Small_ID=OD-12;
	Large_ID=OD-5;
	
	Locked_Ball_X=Stager_LockRod_X/2+LockBall_d/2-2;
	Locked_Ball_Y=Tube_OD/2-StagerLockInset_Y;
	
	Locked_BallCircle_r=OD/2+LockBall_d/2-Inset;
	//echo(Arc_a=Arc_a);
	
	module BallGroove(Mir=false){
		X=(Mir==true)? -Locked_Ball_X:Locked_Ball_X;
		X2=(Mir==true)? -Stager_LockingBallOffset:Stager_LockingBallOffset;
		Rot_a=(Mir==true)? -CamBall_a:CamBall_a;
		Rot2_a=(Mir==true)? -CamBall_a2:CamBall_a2;
		
		for (j=[0:nSteps])
		hull(){
			rotate([0,0,-(Arc_a/nSteps)*j]) translate([X, Locked_Ball_Y, 0])
				rotate([0,0,Rot_a]) translate([X2,0,0]) 
					rotate([0,0,Rot2_a]) translate([0,-Depth/nSteps*j,0]) 
						sphere(d=LockBall_d+IDXtra, $fn=$preview? 18:72);
			
		
			rotate([0,0,-(Arc_a/nSteps)*(j+1)]) translate([X, Locked_Ball_Y, 0])
				rotate([0,0,Rot_a]) translate([X2,0,0]) 
					rotate([0,0,Rot2_a]) translate([0,-Depth/nSteps*(j+1),0]) 
						sphere(d=LockBall_d+IDXtra, $fn=$preview? 18:72);
		} // hull
	} // BallGroove
	
	difference(){
		union(){
			// Base
			cylinder(d=BoltCircle_d(Tube_OD=Tube_OD)+Bolt4Inset*2, h=6);
			
			cylinder(d=OD-1, h=Tube_Len-LockBall_d-6);
			translate([0,0,Tube_Len-LockBall_d-6-Overlap]) cylinder(d1=OD-1, d2=OD-Inset*2+FlexComp_d, h=3+Overlap*2);
			cylinder(d=OD-Inset*2+FlexComp_d, h=Tube_Len+3, $fn=$preview? 90:360);
			//
			echo(OD-Inset*2+FlexComp_d);
		} // union
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
			translate([0,0,Tube_Len-LockBall_d/2-0.8]) {
				BallGroove(Mir=false);
				BallGroove(Mir=true);
			}
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Small_ID, h=Tube_Len+3+Overlap*2); // top
		translate([0,0,-Overlap]) cylinder(d=Large_ID, h=Tube_Len-LockBall_d-9+Overlap); // bottom
		translate([0,0,Tube_Len-LockBall_d-9-Overlap]) cylinder(d1=Large_ID, d2=Small_ID, h=5); // transition
		translate([0,0,Tube_Len-3]) cylinder(d1=Small_ID, d2=OD-6, h=6+Overlap);
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) 
			translate([BoltCircle_d(Tube_OD=Tube_OD)/2,0,6]) Bolt4HeadHole();
	} // difference
	
} // Stager_LockRing

//translate([0,0,1]) Stager_LockRing(Tube_OD=BT137Body_OD, nLocks=3, FlexComp_d=0.8);
//Stager_LockRing(Tube_OD=PML98Body_OD, nLocks=2, FlexComp_d=0.4);

module Stager_Detent(Tube_OD=PML98Body_OD){
	nBottomBolts=nInnerRaceBolts;
	Plate_H=4;
	
	BoltCircle_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	Detent_a=360/nBottomBolts;
	DetentTravel_a=Calc_a(15,BoltCircle_r);
	DetentXtra=1.2;
	
	module BoltPattern(){
		for (j=[0:1]) rotate([0,0,30+360/nBottomBolts*j]) 
			translate([0,BoltCircle_r,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			hull(){
				BoltPattern() cylinder(d=10, h=Plate_H);
				
				// Ball Detent
				rotate([0,0,Detent_a]) translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H);
				rotate([0,0,Detent_a+DetentTravel_a]) translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H);
				rotate([0,0,Detent_a-DetentTravel_a]) translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H);
			} // hull
			
			// Ball Detent, raised portion
			hull(){
				rotate([0,0,Detent_a]) translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H+DetentXtra);
				rotate([0,0,Detent_a+DetentTravel_a]) translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H+DetentXtra);
				rotate([0,0,Detent_a-DetentTravel_a]) translate([0,BoltCircle_r+3,0]) cylinder(d=10, h=Plate_H+DetentXtra);
			} // hull
				
		} // union
		
		// Ball Detent
		rotate([0,0,Detent_a]) translate([0,BoltCircle_r+3,Plate_H+DetentXtra+DetentBall_d/2-1.5])
			sphere(d=DetentBall_d);
		
		translate([0,0,-Overlap]) cylinder(d=Race_ID(Tube_OD=Tube_OD), h=DetentXtra+Plate_H+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
			
} // Stager_Detent

//rotate([0,180,120]) Stager_Detent(Tube_OD=PML150Body_OD);
//Stager_Detent(Tube_OD=PML98Body_OD);

module Stager_CableEndAndStop(Tube_OD=PML98Body_OD, Xtra3=false){
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
		
			
			rotate([0,-90,0])
			if (Xtra3){
				translate([0,0,3]) rotate([10,0,0]) hull(){ 
					cylinder(d=3.5, h=8); 
					translate([3,0,0]) cylinder(d=3.5, h=8); 
				} // hull
			}else{
				hull(){ 
					cylinder(d=3.5, h=8); 
					translate([3,0,0]) cylinder(d=3.5, h=8); 
				} // hull
			}
			
			// cable end insertion hole
			translate([5.4,0,-Overlap]) cylinder(d=3.6, h=Plate_H+Overlap*2);
			
			
			hull(){
				translate([Overlap,0,-Overlap]) rotate([0,90,0]) cylinder(d=1.2, h=10, center=true);
				translate([Overlap,0,4.5]) rotate([0,75,0]) cylinder(d=1.2, h=10, center=true);
			} // hull
		}
		
		translate([0,0,-Overlap]) cylinder(r=BC_r-Bolt4Inset, h=Plate_H+Overlap*2);
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
} // Stager_CableEndAndStop

//rotate([0,180,-60]) Stager_CableEndAndStop(Tube_OD=PML98Body_OD, Xtra3=true);
//Stager_CableEndAndStop(Tube_OD=PML150Body_OD);

module Stager_LockRodBoltPattern(){
	// from bottom center
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;

	translate([0,-LR_Y/2,LR_Z-5]) rotate([90,0,0]) children();
	translate([0,-LR_Y/2,LR_Z-5-8]) rotate([90,0,0]) children();
	
} // Stager_LockRodBoltPattern

//Stager_LockRodBoltPattern() Bolt6Hole();

module Stager_LockRod(Adj=0){
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	Lock_Z=10-LockBall_d/2; // 10mm is the bottom of the saucer
	Lock_Cam=2;
	
	difference(){
		RoundRect(X=LR_X, Y=LR_Y, Z=LR_Z+Adj, R=Stager_LockRod_R);
		
		translate([0,0,Adj]) Stager_LockRodBoltPattern() Bolt6ButtonHeadHole();
		
		translate([-LockBall_d/2-LR_X/2+Lock_Cam, 0, Lock_Z])
			rotate([90,0,0]) cylinder(d=LockBall_d-1, h=LR_Y+Overlap*2, center=true);
		translate([LockBall_d/2+LR_X/2-Lock_Cam, 0, Lock_Z])
			rotate([90,0,0]) cylinder(d=LockBall_d-1, h=LR_Y+Overlap*2, center=true);
	} // difference
	
} // Stager_LockRod

//Stager_LockRod(Adj=-0.5);

module Stager_CupHoles(Tube_OD=PML98Body_OD, ID=78, nLocks=2, BoltsOn=true, Offset_a=0){
	Collar_h=18;
	nBolts=8;
	
	difference(){
		translate([0,0,-Overlap]) cylinder(d=Tube_OD+1, h=Collar_h+Overlap, $fn=$preview? 90:360); // test
		translate([0,0,-Overlap*2]) cylinder(d=ID-IDXtra*2, h=Collar_h+Overlap*4, $fn=$preview? 90:360); 
	} // difference
	
	translate([0,0,-12]) rotate([0,0,Offset_a]) Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
	
	// BoltHoles
	if (BoltsOn)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
			translate([0,Tube_OD/2-7.5,Collar_h]) 
				rotate([180,0,0]) Bolt4Hole(depth=12);
} // Stager_CupHoles

//Stager_CupHoles();

module Stager_Cup(Tube_OD=PML98Body_OD, ID=78, nLocks=2, BoltsOn=true, Collar_h=18, HasElectrical=false, Offset_a=0){
	Len=3;
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	nBolts=8;
	
	difference(){
		union(){
			difference(){
				translate([0,0,Len-Overlap]) 
					cylinder(d=Tube_OD, h=Collar_h, $fn=$preview? 90:360);
				translate([0,0,Len-Overlap*2]) 
					cylinder(d=ID, h=Collar_h+Overlap*2, $fn=$preview? 90:360); 
			} // difference
			
			cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
			translate([0,0,-2]) 
				cylinder(d1=Tube_OD-8, d2=Tube_OD-4, h=2+Overlap, $fn=$preview? 90:360);
		} // union
		
		// center hole
		translate([0,0,-2-Overlap]) cylinder(d=ID, h=Len+2+Overlap*2, $fn=$preview? 90:360);
		
		// BoltHoles
		if (BoltsOn)
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
				translate([0,Tube_OD/2-7.5,Collar_h-6]) 
					rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=Collar_h);
		
		if (nLocks>0)
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks, Offset_a=Offset_a);
		
		if (nLocks>0)
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+Offset_a]) 
			translate([0,Tube_OD/2-StagerLockInset_Y,-16])
				Stager_LockRodBoltPattern() Bolt6Hole(depth=StagerLockInset_Y);
		
		if (HasElectrical) rotate([0,0,-180/nLocks+Offset_a]){
			translate([0,Saucer_ID(Tube_OD=Tube_OD)/2+EConnInset,-2]) cube([10,10,22], center=true);
			translate([0,Saucer_ID(Tube_OD=Tube_OD)/2+EConnInset,8]) RoundRect(X=12, Y=12, Z=Collar_h, R=0.2);
			//translate([0,0,-2]) SaucerEConnBoltPattern() Bolt4ButtonHeadHole();
		}
	} // difference
	
	E_a=(nLocks>0)? -180/nLocks+Offset_a:0;
	if (HasElectrical) rotate([0,0,E_a])
			difference(){
				intersection(){
					translate([0,0,-2]) cylinder(d=Tube_OD-8, h=10);
					translate([0,Saucer_ID(Tube_OD=Tube_OD)/2+EConnInset,-2]) 
						RoundRect(X=14, Y=14, Z=10, R=1);
				} // intersection
				
				translate([0, Saucer_ID(Tube_OD=Tube_OD)/2+EConnInset,-2-Overlap]) 
					RoundRect(X=10, Y=10, Z=10+Overlap*2, R=0.2);
			} // difference
			
	if ($preview && (nLocks>0))
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+Offset_a]) translate([0, Tube_OD/2-StagerLockInset_Y,-16])
				color("Orange") Stager_LockRod();
} // Stager_Cup

//translate([0,0,Overlap]) Stager_Cup(Tube_OD=PML98Body_OD, ID=76, nLocks=2, Collar_h=18+15,HasElectrical=false);
//Stager_Cup(Tube_OD=PML98Body_OD, ID=78, nLocks=2, BoltsOn=true, Collar_h=18, HasElectrical=true);
//rotate([0,180,0]) Stager_Cup(Tube_OD=BT137Body_OD, ID=BT137Body_OD-28, nLocks=3, BoltsOn=false, Collar_h=18, HasElectrical=true);

module Stager_Drogue_Cup(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, HasInnerTube=true,
				InnerTube_OD=BT54Body_OD, nLocks=2, nFins=5, MultiStage=false, RG_H_Xtra=2){

	Collar_h=18;
	SkirtLen=Collar_h+42;
	RailGuide_Z=-SkirtLen/2;
	RG_Len=35; // Rail Guide Length
	RG_H=Tube_OD/2+RG_H_Xtra;
	Rivet_Z=-SkirtLen+10;
	Rivet_a=-90-360/nFins;
	
	rotate([180,0,0]) 
		Stager_Cup(Tube_OD=Tube_OD, 
					ID=Tube_OD-StagerLockInset_Y*2-Stager_LockRod_Y+3,
					nLocks=nLocks, BoltsOn=false, Collar_h=Collar_h, HasElectrical=MultiStage);
	
	// Skirt
	difference(){
		translate([0,0,-SkirtLen]) 
			Tube(OD=Tube_OD, ID=Tube_ID, Len=SkirtLen, myfn=$preview? 90:360);
	
		// Rail guide bolts
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,Tube_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Rivet holes
		for (j=[0:2]) rotate([0,0,120*j+Rivet_a]) translate([0,Tube_OD/2+1,Rivet_Z])
			rotate([90,0,0]) cylinder(d=4, h=5);
	} // difference
	
	// Rail Guide Boss
	difference(){
		union(){
			translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
				RailGuidePost(OD=Tube_OD, MtrTube_OD=InnerTube_OD, H=RG_H, 
					TubeLen=RG_Len+10, Length = RG_Len, BoltSpace=12.7);
					
			if (HasInnerTube) 
				translate([0,0,-SkirtLen])
					Tube(OD=InnerTube_OD+4.4+IDXtra*3, ID=InnerTube_OD+IDXtra*3, 
						Len=21, myfn=$preview? 90:360);
						
			// Spokes
			difference(){
				for (j=[0:nFins-1]) rotate([0,0,360/nFins*j]) hull(){
					translate([0,0,RailGuide_Z]) cylinder(d=3, h=RG_Len, center=true);
					translate([Tube_OD/2,0,RailGuide_Z]) cylinder(d=3, h=RG_Len, center=true);
				} // hull
				// Remove Outside
			
				difference(){
					translate([0,0,-SkirtLen]) cylinder(d=Tube_OD+5, h=SkirtLen);
					translate([0,0,-SkirtLen-Overlap]) cylinder(d=Tube_OD-1, h=SkirtLen+Overlap*2);
				} // diff
			} // difference
		} // union
		
		
		if (HasInnerTube){
			// Remove inside
			translate([0,0,-SkirtLen]) cylinder(d=InnerTube_OD+IDXtra*3, h=SkirtLen);
			// Remove Top
			translate([0,0,-18]) cylinder(d=Tube_OD-1, h=20);
			// Remove Bottom
			difference(){
				translate([0,0,-SkirtLen]) cylinder(d=Tube_OD-1, h=20);
				translate([0,0,-SkirtLen-Overlap]) cylinder(d=InnerTube_OD+4.4+IDXtra*3, h=20);
			} // diff
		} else {
			// Remove inside
			translate([0,0,-SkirtLen]) cylinder(d=Tube_OD-1, h=SkirtLen);
		}
		
		
		
		// Rivet holes
		for (j=[0:2]) rotate([0,0,120*j+Rivet_a]) translate([0,Tube_OD/2+1,Rivet_Z])
			rotate([90,0,0]) cylinder(d=4, h=5);
	} // difference
		
	if ($preview) rotate([0,0,-90-180/nFins])  translate([0,RG_H,RailGuide_Z]) 
		BoltOnRailGuide(Length = RG_Len, BoltSpace=12.7, RoundEnds=true);
} // Stager_Drogue_Cup

//Stager_Drogue_Cup();
//Stager_Drogue_Cup(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, nLocks=2, nFins=5, MultiStage=true, RG_H_Xtra=20);


module Stager_SaucerBoltPattern(Tube_OD=PML98Body_OD, nLocks=2){
	Inset_Y=7.5;
	Bolt_a=Calc_a(30,(Tube_OD/2));
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
		rotate([0,0,Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
		rotate([0,0,-Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
	}
} // Stager_SaucerBoltPattern

//Stager_SaucerBoltPattern() Bolt4ButtonHeadHole();

module Stager_LockRod_Holes(Tube_OD=PML98Body_OD, nLocks=2, Offset_a=0){
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Saucer_H=Saucer_Len;
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+Offset_a]) 
		translate([0,Tube_OD/2-StagerLockInset_Y, -Saucer_H-12-Overlap]){
		
			// BC_LockRod
			RoundRect(X=LR_X+LooseFit, Y=LR_Y+LooseFit, Z=LR_Z+12, R=1+LooseFit/2);
		
			// Spring
			translate([0,0,-Stager_Spring_CBL]) cylinder(d=Stager_Spring_OD+LooseFit, h=Stager_Spring_FL);
	}
} // Stager_LockRod_Holes
	
module SaucerEConnBoltPattern(Tube_OD=PML98Body_OD){
	Bolt_a=Calc_a(12.7,(Tube_OD/2));
	BoltInset=10;
	
	rotate([0,0,Bolt_a]) translate([0,Tube_OD/2-BoltInset,0]) children();
	rotate([0,0,-Bolt_a]) translate([0,Tube_OD/2-BoltInset,0]) children();
} // SaucerEConnBoltPattern

//SaucerEConnBoltPattern(Tube_OD=PML98Body_OD) Bolt4Hole();

module Stager_SaucerEConnHolder(Tube_OD=PML98Body_OD){
	ID=Saucer_ID(Tube_OD=Tube_OD);
	difference(){
		union(){
			hull(){
				SaucerEConnBoltPattern(Tube_OD=Tube_OD) cylinder(d=8, h=4);
				translate([0,ID/2+EConnInset,0]) RoundRect(X=14,Y=14,Z=4, R=2);
			} // hull
			
			translate([0,ID/2+EConnInset,0]) RoundRect(X=14,Y=14,Z=10, R=2);
		} // union
		
		// Connector
		translate([0,ID/2+EConnInset,-Overlap]) RoundRect(X=10,Y=10,Z=11, R=0.2);
		
		// Bolt holes
		translate([0,0,4])SaucerEConnBoltPattern(Tube_OD=Tube_OD) Bolt4Hole();
		
		// Trim Inside
		translate([0,0,-Overlap]) cylinder(d=ID, h=30);
		
		// Trim Outside
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Tube_OD+10, h=30);
			translate([0,0,-Overlap*2]) cylinder(d=Tube_OD-4, h=31);
		} // difference
		
	} // difference
	
} // Stager_SaucerEConnHolder

//translate([0,0,-6.2]) rotate([180,0,0]) Stager_SaucerEConnHolder();

module Stager_Saucer(Tube_OD=PML98Body_OD, nLocks=2, HasElectrical=false){
	Len=Saucer_Len;
	ID=Saucer_ID(Tube_OD=Tube_OD);
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Saucer_IDXtra=IDXtra*4; // was *3
	
	difference(){
		translate([0,0,-Len]) cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
		
		// Cup sits here
		translate([0,0,-2]) cylinder(d1=Tube_OD-8+Saucer_IDXtra, d2=Tube_OD-4+Saucer_IDXtra, h=2+Overlap, $fn=$preview? 90:360);
		
		// Center hole
		translate([0,0,-Len-Overlap]) cylinder(d=ID, h=Len, $fn=$preview? 90:360);
		
		if (nLocks>0)
			translate([0,0,-2]) 
				Stager_SaucerBoltPattern(Tube_OD=Tube_OD, nLocks=nLocks) Bolt4ButtonHeadHole();
		
		if (nLocks>0)
			Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		
		E_a=(nLocks>0)? -180/nLocks:0;
		if (HasElectrical) rotate([0,0,E_a]) {
			translate([0,ID/2+EConnInset,-Len]) cube([10,10,22], center=true);
			translate([0,0,-2]) SaucerEConnBoltPattern(Tube_OD=Tube_OD) Bolt4ButtonHeadHole();
		}
	} // difference
	
} // Stager_Saucer

//translate([0,0,Tube_Len+6+0.2]) Stager_Saucer(Tube_OD=PML98Body_OD, nLocks=2,  HasElectrical=true);

//Stager_Saucer(Tube_OD=BT137Body_OD, nLocks=3,  HasElectrical=true);

module Stager_BallSpacer(Tube_OD=PML98Body_OD){
	Thickness=1.5;
	nBalls=nBearingBalls(Tube_OD=Tube_OD);
	//echo(nBalls=nBalls);
	
	difference(){
		cylinder(d=BearingBallCircle_d(Tube_OD=Tube_OD)+Ball_d*0.6, h=Ball_d/2+Thickness);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=BearingBallCircle_d(Tube_OD=Tube_OD)-Ball_d*0.6, h=Ball_d/2+Thickness+Overlap*2);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BearingBallCircle_d(Tube_OD=Tube_OD)/2,0,Ball_d/2+Thickness])
			sphere(d=Ball_d+LooseFit, $fn=36);
			
		for (j=[0:nBalls/2-1]) rotate([0,0,720/nBalls*j-180/nBalls]){
			translate([BearingBallCircle_d(Tube_OD=Tube_OD)/2,0,0]) rotate([180,0,0]) Bolt2Hole();
			rotate([0,0,360/nBalls]) translate([BearingBallCircle_d(Tube_OD=Tube_OD)/2,0,0]) rotate([180,0,0]) Bolt2HeadHole();
		}
	} // difference
} // Stager_BallSpacer

//translate([0,0,Race_Z-Race_W]) Stager_BallSpacer();

module Stager_InnerRace(Tube_OD=PML98Body_OD){
	Race_WXtra=2;
	nBolts=nInnerRaceBolts*4; // allows 15° indexing
	
	difference(){
		translate([0,0,Race_WXtra/2]) rotate([180,0,0]) 
			OnePieceInnerRace(BallCircle_d=BearingBallCircle_d(Tube_OD=Tube_OD), Race_ID=Race_ID(Tube_OD=Tube_OD), Ball_d=Ball_d, 
						Race_w=Race_W+Race_WXtra, PreLoadAdj=Stager_PreLoadAdj, 
						VOffset=0.00, BI=true, myFn=$preview? 90:720);

		
		// Activator and Stop bolt holes
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) 
			translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,Race_WXtra/2])
				Bolt4Hole(depth=Race_W+Race_WXtra);
	} // difference
	
} //Stager_InnerRace

//translate([0,0,Race_Z]) Stager_InnerRace();
	
module Stager_Mech(Tube_OD=PML98Body_OD, nLocks=2, Skirt_ID=PML98Body_ID, Skirt_Len=30, KeyOffset_a=0, HasRaceway=true, Raceway_a=270){
		
	// KeyOffset_a must be a multiple 15°
		
	Len=Saucer_Len;
	ID=Saucer_ID(Tube_OD=Tube_OD);
	Raceway_Len=44;
	Raceway_Z=-49;

	Locked_Ball_X=Stager_LockRod_X/2+LockBall_d/2-2;
	Locked_Ball_Y=Tube_OD/2-StagerLockInset_Y;
	
	CablePath_Y=BoltCircle_d(Tube_OD=Tube_OD)/2;
	LockingBallOffset=Stager_LockingBallOffset;
	LockingBallDepthAdj=0.4;
	Cable_Offset_a=15*round((-60+Calc_a(12,CablePath_Y)+Calc_a(26,CablePath_Y) )/15);
	//echo(Cable_Offset_a=Cable_Offset_a);	
	
	
	module ShowBall(){
		color("Red") sphere(d=LockBall_d, $fn=18);
	} // ShowBall
	
	module BackStop(){
		Block_W=22;
		Block_H=LockBall_d+5;
		
		module BallPath(){
			
			// lock/unlock path
			hull(){
				translate([Locked_Ball_X, Locked_Ball_Y, -LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
				
				translate([Locked_Ball_X+4, Locked_Ball_Y, -LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
			} // hull
				
			// locking ball insertion hole
			hull(){
				translate([Locked_Ball_X+4, Locked_Ball_Y, -LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
				translate([Locked_Ball_X+4, Locked_Ball_Y, 1])
					sphere(d=LockBall_d+IDXtra*2);
			} // hull
			
			// Cam ball
			hull(){
				translate([Locked_Ball_X, Locked_Ball_Y, -LockBall_d/2])
					rotate([0,0,CamBall_a]) translate([LockingBallOffset,LockingBallDepthAdj,0]) sphere(d=LockBall_d+IDXtra*3);
				
				translate([Locked_Ball_X, Locked_Ball_Y, -LockBall_d/2])
					rotate([0,0,CamBall_a]) translate([LockingBallOffset,0,0]) 
						rotate([0,0,CamBall_a2]) translate([0,-LockBall_d,0]) sphere(d=LockBall_d+IDXtra*3);
			} // hull
			
			
		} // BallPath
		
		difference(){
			intersection(){
				translate([0,Tube_OD/2-StagerLockInset_Y,-Block_H/2]) 
					cube([Tube_OD,Block_W,Block_H], center=true);
				translate([0,0,-Block_H]) cylinder(d=Tube_OD-1, h=Block_H);
			} // intersection
			
			// center hole
			translate([0,0,-Block_H-Overlap])
				cylinder(d=ID, h=Block_H+Overlap*2);
				
			BallPath();
			mirror([1,0,0]) BallPath();
			
			translate([0,0,5]) Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
			Stager_SaucerBoltPattern(Tube_OD=Tube_OD, nLocks=nLocks) Bolt4Hole();
		} // difference
		
		if ($preview) 
			translate([Locked_Ball_X, Locked_Ball_Y, -LockBall_d/2]){
				ShowBall();
				rotate([0,0,CamBall_a]) translate([LockingBallOffset,LockingBallDepthAdj,0]) ShowBall();
			}
	} // BackStop
	
// *******************

	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
		translate([0,0,-Len]) BackStop();
		
	
	// Spring wells
	difference(){
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
			translate([0,Tube_OD/2-StagerLockInset_Y, -Len-Stager_Spring_FL])
				difference(){
					cylinder(d=Stager_Spring_OD+5, h=Stager_Spring_CBL);
					translate([0,0,2]) cylinder(d=Stager_Spring_OD+LooseFit, h=Stager_Spring_FL);
					// center hole
				} // difference
		translate([0,0,-Len-Tube_Len-Overlap]) cylinder(d=ID, h=Len+Tube_Len+Overlap*2, $fn=$preview? 90:360);
	} // difference
	
	// The Tube
	difference(){
		union(){
			translate([0,0,-Len-Tube_Len]) 
				cylinder(d=Tube_OD, h=Tube_Len, $fn=$preview? 90:360);
			
			// Skirt
			translate([0,0,Race_Z-Race_W-Skirt_Len]) 
				Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+Overlap*2, myfn=$preview? 36:360);
			
			translate([0,0,Race_Z-23]) 
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
			
			// Alignment key
			rotate([0,0,KeyOffset_a])
			intersection(){
				translate([0,Skirt_ID/2,Race_Z-27]) cylinder(d=4,h=5);
				translate([0,0,Race_Z-27]) cylinder(d=Skirt_ID+1, h=5);
			} // intersection

		} // union
		
		translate([0,0,-Len-Tube_Len-Overlap]) 
			cylinder(d=Tube_OD-4.0, h=Tube_Len+Overlap*2, $fn=$preview? 90:360);
		
		// Arm / Trigger access hole
		Stager_ArmDisarmAccess(Tube_OD=Tube_OD, KeyOffset_a=KeyOffset_a, Len=Tube_OD);

		if (HasRaceway) rotate([0,0,90+Raceway_a]){
			translate([0,0,Raceway_Z+Raceway_Len/2]) 
				Raceway_Exit(Tube_OD=Tube_OD, Race_ID=7, Wall_t=4, Top_Len=10, Bottom_Len=10);
			translate([0,0,Raceway_Z-Raceway_Len/2]) rotate([180,0,0]) 
				Raceway_Exit(Tube_OD=Tube_OD, Race_ID=7, Wall_t=4, Top_Len=10, Bottom_Len=10);
		} // if

	} // difference
	
	if (HasRaceway) rotate([0,0,90+Raceway_a]){
		translate([0,0,Raceway_Z+Raceway_Len/2]) 
			Raceway_End(Tube_OD=Tube_OD, Race_ID=7, Wall_t=4, Len=Raceway_Len/2); //External cover end
		translate([0,0,Raceway_Z-Raceway_Len/2]) rotate([180,0,0]) 
			Raceway_End(Tube_OD=Tube_OD, Race_ID=7, Wall_t=4, Len=Raceway_Len/2); //External cover end
	} // if
	
	translate([0,0,Race_Z+Overlap]) rotate([0,0,180/nLocks]) rotate([180,0,0])
		OnePieceOuterRace(BallCircle_d=BearingBallCircle_d(Tube_OD=Tube_OD), Race_OD=Tube_OD, 
					Ball_d=Ball_d, Race_w=Race_W, PreLoadAdj=Stager_PreLoadAdj, 
					VOffset=0.00, BI=true, myFn=$preview? 90:720);
	
} // Stager_Mech

//Stager_Mech();

//Stager_Mech(Tube_OD=PML150Body_OD, nLocks=3, Skirt_ID=PML150Body_ID, Skirt_Len=30, HasRaceway=true, Raceway_a=300);

module Stager_ArmDisarmAccess(Tube_OD=PML98Body_OD, KeyOffset_a=0, Len=PML98Body_OD){
	CablePath_Y=BoltCircle_d(Tube_OD=Tube_OD)/2;
	Cable_Offset_a=15*round((-60+Calc_a(12,CablePath_Y)+Calc_a(26,CablePath_Y) )/15);
	
	rotate([0,0,-Cable_Offset_a+KeyOffset_a-66]) translate([0,BearingBallCircle_d(Tube_OD=Tube_OD)/2-2,Race_Z-Race_W-3])
			rotate([0,90,0]) cylinder(d=3, h=Len, center=true);
} // Stager_ArmDisarmAccess

//Stager_ArmDisarmAccess();




























