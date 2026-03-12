// ***********************************
// Project: 3D Printed Rocket
// Filename: R75Lib.scad
// by David M. Flynn
// Created: 7/17/2024 
// Revision: 0.9.6  3/1/2026
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of parts for 75mm rockets.
//
//  ***** History *****
//
function R75Lib_Rev()="R75Lib Rev 0.9.6";
// 0.9.6  3/1/2026   Added R75_EBayBR(), R75_EBayMC()
// 0.9.5  2/16/2026  Added R75_MotorNutStop(), R75_MotorTubeTopperTR()
// 0.9.4  2/15/2026  Changed R75_PetalHub params,
// 0.9.3  8/29/2025  Added shock cord sleeve to R75_BallRetainerBottom()
// 0.9.2  7/22/2024  Added R75_UpperRailGuideMount()
// 0.9.1  7/18/2024  3 petals, 5 balls, 6 bolts
// 0.9.0  7/17/2024  First code, copied from many places
//
// ***********************************
//  ***** for STL output *****
//
// R75_UpperRailGuideMount(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD);
// R75_MotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID);
// R75_MotorNutStop(MT_ID=ULine38Body_ID, Hole_d=8);
// R75_MotorTubeTopperTR(OD=ULineH75Body_ID, ID=ULine38Body_OD, MT_ID=ULine38Body_ID-3);
// R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);  // One small servo w/ shock cord attachment.
// R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=false);
// R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=true); // for bottom of ebay
// R75_PetalHub(OD=BT75Coupler_OD, nPetals=nPetals, nBolts=nPetals*2, Skirt_h=1, HasCenterHole=false); // for bottom of ebay
// R75_NC_Base_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID); // for bottom of nosecone
// R75_NC_GPS_Mounting_Plate(OD=ULineH75Body_ID, nBolts=6, Skirt_h=5, HasAlTube=true);
// R75_EBayBR(OD=BT75Coupler_OD, CenterBolt_d=0.312*25.4, CenterBolt_p=25.4/18);
// R75_EBayMC(OD=BT75Coupler_OD, CenterBolt_d=0.250*25.4, CenterBolt_p=25.4/20, HasRS_Mount=false, BaseOnly=true, UseMCClip=false);
//
// ***********************************
include<TubesLib.scad>
use<SpringThingBooster.scad> echo(SpringThingBoosterRev());
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad>
use<NoseCone.scad>
use<ThreadLib.scad>
use<BatteryHolderLib.scad>		echo(BatteryHolderLibRev());
use<AltBay.scad>				echo(AltBayRev());


Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

Thread1024_d=0.190*25.4; // 10-24 NC
Thread1024_p=25.4/24;
Thread25020_d=0.250*25.4; // 1/4-20 NC
Thread25020_p=25.4/20;
Thread31218_d=5/16*25.4; // 5/16-18 NC
Thread31218_p=25.4/18;

Bolt10Inset=5.5;
Bolt4Inset=4;

CouplerLenXtra=-5;
nLockBalls=5;
nPetals=3;

Engagement_Len=20;

Body_OD=BT75Body_OD;
Body_ID=BT75Body_ID;

Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;

module R75_DeepSocket500(Len=40){
	// 1/2" Socket for 5/16-18 nuts (38mm RMS)
	Al_Tube_d=1/2*25.4;
	ID=5/16*25.4+IDXtra*4;
	Depth=8;
	
	difference(){
		cylinder(d=Al_Tube_d+6, h=Len); 
			
		// center hole
		hull(){
			translate([0,0,Depth-Overlap*2]) Bolt312NutHole(depth=Overlap);
			translate([0,0,Depth]) cylinder(d=ID, h=4);
		} // hull	
		
		cylinder(d=ID, h=Len);
		translate([0,0,Depth+6]) cylinder(d=Al_Tube_d+IDXtra, h=Len);
	
		// nut
		translate([0,0,-Overlap]) Bolt312NutHole(depth=Depth);
	} // difference
} // R75_DeepSocket500

// R75_DeepSocket500();

module R75_NoseCone(Shoulder_OD=BT75Coupler_OD, OD=ULineH75Body_OD, nBolts=6,
			NC_Len=150, NC_Base_L=6, NC_Tip_R=3, NC_Wall_t=1.2){
	
	ShoulderWall_t=2.2;
	
	BluntOgiveNoseCone(ID=OD-ShoulderWall_t*2, OD=OD, L=NC_Len, Base_L=NC_Base_L, nRivets=0, RivertInset=0, Tip_R=NC_Tip_R, HasThreadedTip=false, Wall_T=NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);

	difference(){
		PD_PetalHubBoltPattern(OD=Shoulder_OD, nBolts=nBolts) hull(){
			cylinder(d=7, h=NC_Base_L);
			translate([0,4.5,0]) scale([1,0.2,1]) cylinder(d=9, h=NC_Base_L);
		}
		
		PD_PetalHubBoltPattern(OD=Shoulder_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4Hole();					
	} // difference
} // R75_NoseCone

// R75_NoseCone();

module R75_UpperRailGuideMount(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, Len=25, HasSpokes=false, Extended=0, HasTube=false, HasStopAtTop=false){
	
	Wall_t=2.2;
	nSpokes=7;
	AlTube_d=12.7;
	AlTube_Z=AlTube_d;
	
	difference(){
		union(){
			if (!HasSpokes)
				Tube(OD=Body_ID, ID=MotorTube_OD+IDXtra*2, Len=Len, myfn=$preview? 36:360);
			else{
				Tube(OD=Body_ID, ID=Body_ID-Wall_t*2, Len=Len, myfn=$preview? 36:360);
				translate([0,0,-Extended])
				Tube(OD=MotorTube_OD+IDXtra*2+Wall_t*2, ID=MotorTube_OD+IDXtra*2, Len=Len+Extended, myfn=$preview? 36:360);
				
				if (Extended>0 && !HasStopAtTop)
					translate([0,0,-Extended+Len]) 
					TubeStop(InnerTubeID=MotorTube_OD-3, OuterTubeOD=MotorTube_OD+Wall_t*2, myfn=$preview? 36:360);
					
				if (HasStopAtTop)
					translate([0,0,Len-4.5]) 
					TubeStop(InnerTubeID=MotorTube_OD-3, OuterTubeOD=MotorTube_OD+2, myfn=$preview? 36:360);
				
				for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j+180/nSpokes]) hull(){
					translate([0,MotorTube_OD/2+IDXtra+Wall_t/2,0]) cylinder(d=Wall_t, h=Len);
					translate([0,Body_ID/2-Wall_t/2,0]) cylinder(d=Wall_t, h=Len);
				}
				
				// Rail guide bolts
				translate([0, Body_ID/2-Wall_t+Overlap, Len/2]) {
					translate([0,0,6.35]) rotate([90,0,0]) cylinder(d=12, h=Body_ID/2-MotorTube_OD/2-IDXtra-Wall_t);
					translate([0,0,-6.35]) rotate([90,0,0]) cylinder(d=12, h=Body_ID/2-MotorTube_OD/2-IDXtra-Wall_t);
				}
				
				if (HasTube) translate([0,0,AlTube_Z]) difference(){
					scale([1,1,1.35]) rotate([0,90,0]) cylinder(d=AlTube_d+6, h=Body_ID-2.6, center=true);
					cylinder(d=MotorTube_OD+1, h=AlTube_d*2+1, center=true);
				}
			} // else
		} // union
				
		if (HasTube) translate([0,0,AlTube_Z]) rotate([0,90,0]) cylinder(d=AlTube_d+IDXtra, h=Body_ID+2, center=true);
		
		// Rail guide bolts
		translate([0, Body_ID/2, Len/2]) {
			translate([0,0,6.35]) rotate([-90,0,0]) Bolt6Hole();
			translate([0,0,-6.35]) rotate([-90,0,0]) Bolt6Hole();
		}
	} // difference
} // R75_UpperRailGuideMount

// R75_UpperRailGuideMount(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD);
// R75_UpperRailGuideMount(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, Len=30, HasSpokes=true, Extended=0, HasTube=true, HasStopAtTop=true);

module R75_MotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID){
// Z zero is top of motor tube
// Sits on top of motor tube
// Has Rail Guide bolt holes
// Has centering ring
// Has shock cord attachment tube
// Has spring holder

	Al_Tube_d=12.7;
	Al_Tube_Z=-Al_Tube_d/2-5;
	Al_Tube_a=-22.50;
	
	ST_DSpring_OD=SE_Spring_CS4323_OD();
	ST_DSpring_ID=SE_Spring_CS4323_ID();
	
	nRopes=3;
	Rope_d=4;
	RopeHoleBC_r=(MotorTube_OD+6)/2+Rope_d/2;

	difference(){
		union(){
			translate([0,0,-20]) 
				Tube(OD=MotorTube_ID, ID=MotorTube_ID-6, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=MotorTube_OD+6, ID=MotorTube_OD+IDXtra*3, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-IDXtra*2-6, Len=21, myfn=$preview? 36:360);
			
			CenteringRing(OD=Body_ID, ID=ST_DSpring_ID, Thickness=5, nHoles=0, Offset=0);
			translate([0,0,4]) 
				Tube(OD=ST_DSpring_OD+8, ID=ST_DSpring_OD, Len=8, myfn=$preview? 36:360);
				
			// Rail guide bolt bosses
			translate([Body_ID/2-2, 0, -9]) hull(){
				translate([0,0,6.35]) rotate([0,-90,0]) cylinder(d=9, h=6);
				translate([0,0,-6.35]) rotate([0,-90,0]) cylinder(d=9, h=6);
		}
		} // union
	
		//translate([0,0,-20]) Tube(OD=MotorTube_ID, ID=MotorTube_ID-6, Len=21, myfn=$preview? 36:360);
		
		translate([0,0,3]) cylinder(d=ST_DSpring_OD, h=4+Overlap);
		translate([0,0,7]) cylinder(d1=ST_DSpring_OD, d2=ST_DSpring_OD+4, h=5+Overlap);
		
		translate([0,0,Al_Tube_Z]) rotate([90,0,Al_Tube_a]) cylinder(d=Al_Tube_d+IDXtra, h=Body_OD, center=true);
		
		// Rail guide bolts
		translate([Body_OD/2, 0, -9]) {
			translate([0,0,6.35]) rotate([0,90,0]) Bolt6Hole();
			translate([0,0,-6.35]) rotate([0,90,0]) Bolt6Hole();
		}
		
		// Rope holes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) {
			translate([0,RopeHoleBC_r,-20-Overlap]) cylinder(d=Rope_d, h=25+Overlap*2);
			translate([0,RopeHoleBC_r,-20-Overlap]) cylinder(d=Rope_d+3, h=19);
			}
		
	} // difference

} // R75_MotorTubeTopper

// R75_MotorTubeTopper();

module R75_MotorNutStop(MT_ID=ULine38Body_ID, Hole_d=6.35){
	Len=20;
	
	difference(){
		cylinder(d=MT_ID, h=Len);
		
		translate([0,0,-Overlap]) cylinder(d=Hole_d+IDXtra*2, h=Len+Overlap*2);
		translate([0,0,Len-5]) cylinder(d1=Hole_d+IDXtra*2, d2=MT_ID-3, h=5+Overlap);
	} // difference
} // R75_MotorNutStop

// R75_MotorNutStop();

module R75_MotorTubeTopperTR(OD=ULineH75Body_ID, ID=ULine38Body_OD, MT_ID=ULine38Body_ID-3){
	Len=20;
	nSpokes=5;
	Spoke_W=2;
	ShockCord_d=2.2;
	myfn=180;
	
	difference(){
		union(){
			// Body
			Tube(OD=OD, ID=OD-2.4, Len=Len, myfn=$preview? 90:myfn);
			// Motor
			Tube(OD=ID+IDXtra*2+2.4, ID=ID+IDXtra*2, Len=Len, myfn=$preview? 90:myfn);
			// Stop
			translate([0,0,Len-2]) Tube(OD=ID+IDXtra+2.4, ID=MT_ID, Len=2, myfn=$preview? 90:myfn);
			
			// spokes
			for(j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j]) hull(){
				translate([0,(ID+IDXtra+2.4)/2,0]) cylinder(d=Spoke_W, h=Len);
				translate([0,(OD-2.4)/2,0]) cylinder(d=Spoke_W, h=Len);
			} // hull
			
			// rail button 
			intersection(){
				cylinder(d=OD, h=Len);
					
				hull(){
					translate([0,ID/2+IDXtra,Len/2]) rotate([-90,0,0]) cylinder(d=10, h=(OD-ID)/2);
					translate([0,ID/2+IDXtra,2.5]) rotate([-90,0,0]) cylinder(d=5, h=(OD-ID)/2);
					translate([0,ID/2+IDXtra,Len-2.5]) rotate([-90,0,0]) cylinder(d=5, h=(OD-ID)/2);
				} // hull
			} // intersection
		} // union
		
		// Rail button bolt
		translate([0,OD/2+1,Len/2]) rotate([-90,0,0]) Bolt8Hole();
		
	} // difference
} // R75_MotorTubeTopperTR

// R75_MotorTubeTopperTR();

module R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, nBolts=3){
	Tube_d=12.7;
	Tube_Z=25;
	Tube_a=-70;
	TubeSlot_w=35;
	TubeOffset_X=10;
	
	Wall_t=3;
	BoltInset=7.5;
	Skirt_H=8;
	Bolt_a=(nBolts==3)? 0:-25; // 3 or 4 bolts
	
	difference(){
		union(){
			STB_BallRetainerTop(Body_ID=Body_ID, Body_OD=Body_ID, nLockBalls=nLockBalls,
								HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=CouplerLenXtra,
								Outer_OD=Body_OD,
								HasSecondServo=false, UsesBigServo=false, Engagement_Len=Engagement_Len);
			
			translate([0,0,Tube_Z]) 
				Tube(OD=Body_ID, ID=Body_ID-IDXtra-Wall_t*2, Len=Tube_d/2+Wall_t, myfn=$preview? 90:360);
			
			// Shock cord retention
			difference(){
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z])
				hull(){
					rotate([90,0,0]) cylinder(d=Tube_d+Wall_t*2, h=Body_ID-2, center=true);
					translate([0,0,-17]) 
						cube([Tube_d+6, Body_ID-2, 1], center=true);
				} // hull
				
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) hull(){
					rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
					translate([0,0,-17]) 
						cube([Tube_d+6+Overlap, TubeSlot_w,1], center=true);
					}
				// Trim outside
				Tube(OD=Body_OD+20, ID=Body_ID-1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
	
		rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		//Bolt holes for ebay
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a])
			translate([0, -Body_OD/2-1, Engagement_Len/2+Skirt_H+7.5]) 
				rotate([90,0,0]) Bolt4Hole(depth=6);
		
	} // difference
} // R75_BallRetainerTop

//  R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
// R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, nBolts=4);

module R75_BallRetainerTopTest(Body_OD=Body_OD, Body_ID=Body_ID){
  // test of thick walled e-bay

	Tube_d=12.7;
	Tube_Z=25;
	Tube_a=-70;
	TubeSlot_w=35;
	TubeOffset_X=10;
	
	Wall_t=3;
	nBolts=3;
	BoltInset=7.5;
	Skirt_H=8;
	
	EBayWall_t=3.5;
	EBay_ID=Body_OD-EBayWall_t*2;
	
	difference(){
		union(){
			STB_BallRetainerTop(Body_ID=Body_ID, Body_OD=Body_ID, nLockBalls=nLockBalls,
								HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=CouplerLenXtra,
								Outer_OD=Body_OD,
								HasSecondServo=false, UsesBigServo=false, Engagement_Len=Engagement_Len);
			
			translate([0,0,Tube_Z]) 
				Tube(OD=EBay_ID-IDXtra, ID=EBay_ID-IDXtra-Wall_t*2, Len=Tube_d/2+Wall_t, myfn=$preview? 90:360);
			
			// Shock cord retention
			difference(){
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z])
				hull(){
					rotate([90,0,0]) cylinder(d=Tube_d+Wall_t*2, h=EBay_ID-2, center=true);
					translate([0,0,-17]) 
						cube([Tube_d+6, EBay_ID-2, 1], center=true);
				} // hull
				
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) hull(){
					rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
					translate([0,0,-17]) 
						cube([Tube_d+6+Overlap, TubeSlot_w,1], center=true);
					}
				// Trim outside
				Tube(OD=Body_OD+20, ID=EBay_ID-1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
	
		rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		//Bolt holes for ebay
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+12])
			translate([0, -Body_OD/2-1, Engagement_Len/2+Skirt_H+7.5]) 
				rotate([90,0,0]) Bolt4Hole();
		
	} // difference
} // R75_BallRetainerTopTest

//  R75_BallRetainerTopTest(Body_OD=Body_OD, Body_ID=Body_ID);

module R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=false){
	// PD_Ring is required to attach the petal hub because 3 balls isn't good enough and 5 won't line up.
	
	Bolt_a=20;// offset between PD_PetalHub and R65_BallRetainerBottom

	
	PD_Ring_h=9;
	
	difference(){
		union(){
			STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, 
					nLockBalls=nLockBalls, HasSpringGroove=false, Engagement_Len=Engagement_Len, HasLargeInnerBearing=false);
					
		
			if (HasPD_Ring){
				translate([0,0,-Engagement_Len/2-PD_Ring_h])
					Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-IDXtra-4.4, Len=PD_Ring_h+Overlap, myfn=$preview? 90:360);
				
				rotate([0,0,Bolt_a]) translate([0,0,-Engagement_Len/2-PD_Ring_h])
					PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=6) cylinder(d=8, h=PD_Ring_h+Overlap);
			}
		} // union
		
		if (HasPD_Ring)
		rotate([0,0,Bolt_a]) translate([0,0,-Engagement_Len/2-PD_Ring_h])
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=6) rotate([180,0,0]) Bolt4Hole(depth=PD_Ring_h-1);

	} // difference
	
	// Shock cord hole
	if (HasPD_Ring)
		difference(){
			translate([0,0,-Engagement_Len+1]) 
			hull() STB_ShockCordHolePattern(Body_ID=Body_ID, Body_OD=Body_ID) 
				cylinder(d=STB_SCord_T(Body_ID)+4.4, h=PD_Ring_h);
				
			translate([0,0,-Engagement_Len-PD_Ring_h-Overlap]) 
			hull() STB_ShockCordHolePattern(Body_ID=Body_ID, Body_OD=Body_ID) 
				cylinder(d=STB_SCord_T(Body_ID), h=PD_Ring_h+15);
		} // difference
} // R75_BallRetainerBottom

// R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=false);
// R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=true);

module R75_PetalHub(OD=BT75Coupler_OD, nPetals=nPetals, nBolts=nPetals*2, Skirt_h=1, HasCenterHole=false){
	ShockCord_a=45;
	mySC_a=HasCenterHole? -2:ShockCord_a;
	CenterHole_d=21;
	
	PD_PetalHub(OD=OD, 
					nPetals=nPetals, 
					HasBolts=true,
					nBolts=nBolts,
					ShockCord_a=mySC_a,
					HasNCSkirt=false,CenterHole_d=CenterHole_d);
					
					
	
	translate([0,0,-Skirt_h])
	difference(){
		union(){
			PD_PetalHubBoltPattern(OD=OD, nBolts=nBolts) hull(){
				cylinder(d=7, h=Skirt_h+Overlap);
				translate([0,3.0,0]) scale([1,0.2,1]) cylinder(d=9, h=Skirt_h+Overlap);
			}
			
			if (Skirt_h==1){
			  cylinder(d=OD, h=Skirt_h+Overlap, $fn=180);
			}else{
				if (Skirt_h>0)
					Tube(OD=OD, ID=OD-3.6, Len=Skirt_h+Overlap, myfn=$preview? 90:360);
			}
			
			cylinder(d=CenterHole_d+6, h=Skirt_h+Overlap);
		} // union
		
		PD_PetalHubBoltPattern(OD=OD, nBolts=nPetals*2) rotate([180,0,0]) Bolt4ClearHole(depth=Skirt_h+10);
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=Skirt_h+Overlap*3);
		
		//if (HasWirePath) WireHole();
	} // difference
} // R75_PetalHub

//translate([0,0,-21]) rotate([180,0,200]) R75_PetalHub(HasCenterHole=true);
						
module R75_NC_Base_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID, Coupler_OD=Coupler_OD){
	ShockCord_a=-1;
	
	difference(){
		PD_PetalHub(OD=Coupler_OD, 
					nPetals=3, 
					HasBolts=true,
					nBolts=6,
					ShockCord_a=ShockCord_a,
					HasNCSkirt=false, 
						Body_OD=Body_OD,
						Body_ID=Body_ID,
						NC_Base=0, 
						SkirtLen=10);
						
		translate([0,0,-Overlap]) cylinder(d=21, h=10);
	} // difference
} // R75_NC_Base_PetalHub

// R75_NC_Base_PetalHub();

module R75_NC_Base(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=15, Coupler_OD=Coupler_OD){
	nBolts=6;
	
	difference(){
		union(){
			NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
			
			translate([0,0,-3]) cylinder(d=Body_OD, h=3, $fn=$preview? 90:360);
		} // union
		
		translate([0,0,-20]) cylinder(d=Body_OD+1, h=17);
		translate([0,0,-3-Overlap]) hull(){
			translate([-8,0,0]) cylinder(d=19, h=6);
			translate([8,0,0]) cylinder(d=19, h=6);
		} // hull
		
		rotate([0,0,20]) translate([0,0,-3]) PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4Hole();
	} // difference
} // R75_NC_Base

// R75_NC_Base();


module R75_NC_GPS_Mounting_Plate(OD=ULineH75Body_ID, nBolts=6, Skirt_h=5, HasAlTube=true){
// *** not finished ***

	Al_Tube_d=12.7;
	Al_Tube_Len=50;
	CenterHole_d=21;
	Wall_t=1.8;
	
	// GPS mount
	Post_W=10;
	Post_Y=4.75;
	Post_Z=7;
	Post_X=28;
	rotate([0,0,-30]) translate([Post_X,0,Post_Z]) rotate([0,-10,0]) rotate([0,0,90]) FW_GPS_Mount();
	rotate([0,0,-30]) translate([Post_X-1,0,0]) rotate([0,0,90]) translate([-Post_W/2, Post_Y, 0]) cube([Post_W, 10.2, Skirt_h+2]);
	
	module FW_GPS_SW_Hole(){
		// Switch
		translate([5,-1.6-1,-1]) 
			rotate([90,0,0]) cylinder(d=3, h=100);
			
		// Terminal block
		translate([10,0,4]) rotate([0,0,180]) cube([7,10,7]);
	} // FW_GPS_SW_Hole

	module FW_GPS_Mount(){
		Boss_d=10;
		
		module Boss(){
			difference(){
				rotate([-90,0,0]) cylinder(d1=7,d2=Boss_d,h=6);
					
				rotate([90,0,0]) Bolt4Hole();
			} // difference
		} // Boss
		
		// Backing plate
		
		Boss_Y=1;
		Boss_Z=13.5;
		Post_W=10;
		Post_Y=6;
		GPS_BoltSpace_X=12.7;
		GPS_BoltSpace_Z=25.4;
		
		difference(){
			union(){
				hull(){
					translate([-Post_W/2,Post_Y,0]) cube([Post_W,3,44]);
					translate([-Post_W/2,Post_Y,0]) cube([Post_W,10,1]);
				} // hull
				
				hull(){
					translate([-GPS_BoltSpace_X/2,Post_Y+Boss_Y,Boss_Z]) rotate([-90,0,0]) cylinder(d=Boss_d,h=3);
					translate([0,Post_Y,Boss_Z]) rotate([-90,0,0]) scale([0.1,1,1]) cylinder(d=Post_W+8,h=6);
				} // hull
				
				hull(){
					translate([GPS_BoltSpace_X/2,Post_Y+Boss_Y,Boss_Z+GPS_BoltSpace_Z]) rotate([-90,0,0]) cylinder(d=Boss_d,h=3);
					translate([0,Post_Y,Boss_Z+GPS_BoltSpace_Z-4]) rotate([-90,0,0]) scale([0.1,1,1]) cylinder(d=Post_W+8,h=4);
				} // hull
				
				translate([-GPS_BoltSpace_X/2,Boss_Y,Boss_Z]) Boss();
				translate([-GPS_BoltSpace_X/2,Boss_Y,Boss_Z]) translate([GPS_BoltSpace_X,0,GPS_BoltSpace_Z]) Boss();
			} // union
			
			translate([-GPS_BoltSpace_X/2,Boss_Y,Boss_Z]) rotate([90,0,0]) Bolt4Hole(depth=20);
			translate([-GPS_BoltSpace_X/2,Boss_Y,Boss_Z]) translate([GPS_BoltSpace_X,0,GPS_BoltSpace_Z]) rotate([90,0,0]) Bolt4Hole();
		} // difference
		
	} // FW_GPS_Mount

	module FW_GPS_Batt_Mount(){
		Batt_X=25;
		Batt_Y=5;
		Batt_Z=37;
		Wall_t=2.4;
		
		difference(){
			union(){
				translate([0,0,-Wall_t]) cube([Batt_X-8, Batt_Y+Wall_t*2, Batt_Z+Wall_t], center=true);
				
				// gusset
				hull(){
					translate([0,Batt_Y/2+Wall_t,Batt_Z/2-Wall_t]) 
						cube([10,Overlap,Wall_t],center=true);
					translate([0,Batt_Y/2+Wall_t+3,-Batt_Z/2-Wall_t]) 
						cube([10,6,Overlap],center=true);
				} // hull
			} // union
			
			cube([Batt_X+Overlap, Batt_Y, Batt_Z+Overlap], center=true);
			
			translate([0, -3, 5]) cube([Batt_X+Overlap, Batt_Y+2, Batt_Z], center=true);
		} // difference
		
	} // FW_GPS_Batt_Mount

	rotate([0,0,-120]) translate([0,-20,24]) rotate([-10,0,0]) FW_GPS_Batt_Mount();
	
	difference(){
		union(){
			// GPS and Batt support
			intersection(){
				difference(){
					union(){
						// GPS
						hull(){
							cylinder(d=1, h=Skirt_h);
							rotate([0,0,-120-30]) translate([0,OD/2,0]) cylinder(d=1, h=Skirt_h);
							rotate([0,0,-120]) translate([0,OD/2,0]) cylinder(d=1, h=Skirt_h);
							rotate([0,0,-120+30]) translate([0,OD/2,0]) cylinder(d=1, h=Skirt_h);
						} // hull
						// Batt
						hull(){
							cylinder(d=1, h=Skirt_h);
							rotate([0,0,60-30]) translate([0,OD/2,0]) cylinder(d=1, h=Skirt_h);
							rotate([0,0,60]) translate([0,OD/2,0]) cylinder(d=1, h=Skirt_h);
							rotate([0,0,60+30]) translate([0,OD/2,0]) cylinder(d=1, h=Skirt_h);
						} // hull
					} // union
					
					translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=Skirt_h+Overlap*2);
				} // difference
				
				cylinder(d=OD, h=Skirt_h);
			} // intersection
			
		
			PD_PetalHubBoltPattern(OD=OD, nBolts=nBolts){
				// Bolt bosses
				hull(){
					cylinder(d=7, h=Skirt_h);
					translate([0,3.0,0]) scale([1,0.2,1]) cylinder(d=9, h=Skirt_h);
				} // hull
				
				// Spokes
				hull(){
					cylinder(d=Wall_t, h=Skirt_h);
					translate([0,-OD/2,0]) cylinder(d=Wall_t, h=Skirt_h);
				} // hull
			}
			
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Skirt_h, myfn=$preview? 90:360);
			Tube(OD=CenterHole_d+Wall_t*2, ID=CenterHole_d, Len=Skirt_h, myfn=$preview? 90:360);
			
			// Al_Tube mount
			if (HasAlTube)
			hull(){
				translate([0,0,Al_Tube_d/2+Skirt_h]) rotate([90,0,-30]) cylinder(d=Al_Tube_d+4, h=Al_Tube_Len, center=true);
				rotate([0,0,-30]) translate([-Al_Tube_d/2-3, -Al_Tube_Len/2,0]) cube([Al_Tube_d+6, Al_Tube_Len, 1]);
			} // hull
			
		} // union
		
		PD_PetalHubBoltPattern(OD=OD, nBolts=nBolts) rotate([180,0,0]) Bolt4ClearHole();
		
		// Aluminum Tube
		if (HasAlTube)
			translate([0,0,Al_Tube_d/2+Skirt_h]) rotate([90,0,-30]) cylinder(d=Al_Tube_d, h=OD, center=true);
			
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=Skirt_h+Al_Tube_d+4);
	} // difference
} // R75_NC_GPS_Mounting_Plate

// R75_NC_GPS_Mounting_Plate(OD=ULineH75Body_ID, nBolts=6, Skirt_h=5, HasAlTube=true);

module R75_ExtensionAlignmentRing38(OD=37, Len=6){
	nSpokes=6;
	Wall_t=1.2;
	Thread_d=Thread31218_d; // 38mm RMS Threaded Plugged Forward Closure
	Thread_p=Thread31218_p;
	
	difference(){
		union(){
			rotate([0,0,30]) cylinder(d=1/2*25.4*1.1339, h=Len, $fn=6);
			
			Tube(OD=OD, ID=OD-Wall_t*2, Len=3, myfn=$preview? 36:90);
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j])
				hull(){
					cylinder(d=Wall_t, h=3);
					translate([0,OD/2-Wall_t,0]) cylinder(d=Wall_t, h=3);
				} // hull
		} // union
		
		// Thread
		translate([0,0,-Overlap])
			if ($preview){
				cylinder(d=Thread_d, h=Len+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Len+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
		
	} // difference
} // R75_ExtensionAlignmentRing38

// R75_ExtensionAlignmentRing38();
// R75_ExtensionAlignmentRing38(OD=53, Len=7);

module R75_ShortMotorAdaptor(Len=48){ // One 38mm grain is 48mm in case length
	// a.k.a. Long Nut
	
	Thread_d=Thread31218_d;
	Thread_p=Thread31218_p;
		
	difference(){
		cylinder(d=1/2*25.4*1.1339, h=Len, $fn=6);
		
		translate([0,0,Len-4]) cylinder(d1=Thread_d-2, d2=11, h=4+Overlap);
		// Thread
		translate([0,0,-Overlap])
			if ($preview){
				cylinder(d=Thread_d, h=Len+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Len+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
	} // difference
} // R75_ShortMotorAdaptor

// R75_ShortMotorAdaptor();
// R75_ShortMotorAdaptor(Len=84.5-7);


module R75_EBay_BasePlate(OD=ULineH75Body_ID, IsLowerPlate=false, 
					CenterBolt_d=0.312*25.4, CenterBolt_p=25.4/18, HasSecBolts=false, ShockCord_a=-30){
	Plate_t=2;
	Boss_t=8;
	nOuterBolts=2;
	Outer_BC_d=OD-Bolt10Inset*2;
	LP_OuterBolt_a=22.5;
	Nut_a=IsLowerPlate? 180:0;
	Wall_t=1.2;
	
	Thread1024_d=0.190*25.4;
	Thread_d=CenterBolt_d;
	Thread_p=CenterBolt_p;

	module ThreadedHole(Chamfer=false){
		Thread_d=Thread1024_d;
		Thread_p=25.4/24;
		
		if (Chamfer)
			cylinder(d1=Thread_d+2, d2=Thread_d, h=2);
			
		if ($preview){
			cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
		}else{
			ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
					Length=Boss_t+Overlap*2, 
					Step_a=2,TrimEnd=true,TrimRoot=true);
		} // if
	} // ThreadedHole

	difference(){
		union(){
			cylinder(d=OD, h=Plate_t);
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Boss_t, myfn=$preview? 90:180);
			
			// Bolt bosses
			if (!IsLowerPlate || HasSecBolts)
				cylinder(d=CenterBolt_d+4.4, h=Boss_t);
			
			if (nOuterBolts>0)
				for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
					translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=Boss_t);
					
			if (nOuterBolts>0 && (IsLowerPlate || HasSecBolts))
				for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a])
					translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=Boss_t);
			
		} // union
		
		// Motor tube hole
		if (IsLowerPlate) translate([0,0,-Overlap]) cylinder(d=33, h=Plate_t+Overlap*2);
			
		// Shock cord
		rotate([0,0,ShockCord_a]) translate([0,OD/2-Wall_t-4,-Overlap]) cylinder(d=6, h=Plate_t+Overlap*2);
		
		if (!IsLowerPlate || HasSecBolts)
		translate([0,0,-Overlap]){
		
			translate([0,0,-Overlap])
					cylinder(d1=Thread_d+2, d2=Thread_d, h=2);
			if ($preview){
				cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
		} // translate
	
		if (nOuterBolts>0)
			if (IsLowerPlate){
				for (j=[0:nOuterBolts-1]){
					rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a]) 
						translate([0,Outer_BC_d/2,-Overlap]) ThreadedHole(Chamfer=true);
						
					rotate([0,0,360/nOuterBolts*j]) 
						translate([0,Outer_BC_d/2,-Overlap]) rotate([0,0,Nut_a]) ThreadedHole();	
				} // for
			}else{
				for (j=[0:nOuterBolts-1]){
					rotate([0,0,360/nOuterBolts*j])
						translate([0,Outer_BC_d/2,-Overlap]) ThreadedHole();
					
					if (HasSecBolts){
						rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a]) 
							translate([0,Outer_BC_d/2,-Overlap]) rotate([0,0,Nut_a]) ThreadedHole();
					}else{
						rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a])
							translate([0,Outer_BC_d/2,Plate_t]) Bolt10ClearHole();
					}
				} // for
			} // if

	} // difference
} // R75_EBay_BasePlate

// R75_EBay_BasePlate(IsLowerPlate=true);
// R75_EBay_BasePlate(IsLowerPlate=false);


module R75_EBayBR(OD=BT75Coupler_OD, CenterBolt_d=0.312*25.4, CenterBolt_p=25.4/18){
	// Blue Raven, Mag Switch, Rocket Servo, 2 cell LiPo
	Raven_Z=30;
	Raven_a=-90;
	Raven_X=-7;
	Raven_Y=0;

	RocketServo_Z=33.5;
	RocketServo_a=0;
	RocketServo_Y=-7;
	
	Mag_SW_a=180; // old 0,23,0
	Mag_SW_X=21;
	Mag_SW_Y=-9;
	
	
	Battery_Z=22.2;
	Battery_X=0;
	Battery_Y=20;
	Battery_a=90;
	
	Batt_X=20;
	Batt_Y=12.2;
	Batt_Z=40; // was 43
	
	module BattHole(Xtra_X=0,Xtra_Y=0, Xtra_Z=0){
		cube([Batt_X+Xtra_X, Batt_Y+Xtra_Y, Batt_Z+Xtra_Z], center=true);
	} // BattHole
	
	module BattPocket(){
		Wall_t=1.2;
		
		difference(){
			BattHole(Xtra_X=Wall_t*2,Xtra_Y=Wall_t*2, Xtra_Z=Wall_t*2);
			
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			
			// wires
			translate([0,0,Batt_Z/2+2]) rotate([0,90,0]) cylinder(d=7, h=20);
			
			// push-up
			translate([0,0,-Batt_Z/2-Wall_t-Overlap]) cylinder(d=5,h=5);
			
			// Lighter
			hull(){
				rotate([90,0,0]) cylinder(d=14, h=Batt_Y+Wall_t*2+Overlap, center=true);
				translate([0,0,Battery_Z/2]) rotate([90,0,0]) cylinder(d=4, h=Batt_Y+Wall_t*2+Overlap, center=true);
				translate([0,0,-Battery_Z/2]) rotate([90,0,0]) cylinder(d=4, h=Batt_Y+Wall_t*2+Overlap, center=true);
			} // hull
			
			hull(){
				rotate([0,90,0]) cylinder(d=10, h=Batt_X+Wall_t*2+Overlap, center=true);
				translate([0,0,Battery_Z/2]) rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
				translate([0,0,-Battery_Z/2]) rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
			} // hull
			
		} // difference
	} // BattPocket
	
	// Mag_Sw
	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y,0])
	hull(){
		H=18.5;
		translate([-7,0,0]) cylinder(d=4, h=H);
		translate([7,0,0]) cylinder(d=4, h=H);
	} // hull
	
	// Raven
	rotate([0,0,90+Raven_a]) translate([Raven_Y,-Raven_X+3,0])
	hull(){
		translate([-9,0,0]) cylinder(d=6, h=7);
		translate([9,0,0]) cylinder(d=6, h=7);
	} // hull
		
	BasePlate_a=0; // was 30
	
	difference(){
		rotate([0,0,BasePlate_a]) 
			R75_EBay_BasePlate(OD=OD, IsLowerPlate=false, CenterBolt_d=CenterBolt_d, CenterBolt_p=CenterBolt_p,
					HasSecBolts=false, ShockCord_a=-30);
					
		// extra SC hole
		translate([10,0,-Overlap]) cylinder(d=6, h=4);
		
		// Battery pushing hole and cleanup inside
		rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,-90]) {
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			translate([0,0,-Batt_Z/2-4-Overlap]) cylinder(d=5,h=5);}
	} // difference

	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y+2,28]) rotate([0,0,0]) rotate([90,0,0]) 
		FW_MagSw_Mount(HasMountingEars=false);
	
	difference(){
		rotate([0,0,Raven_a]) translate([Raven_X,Raven_Y,Raven_Z]) rotate([0,-90,0]) BlueRavenMount();
		
		rotate([0,0,Mag_SW_a]) translate([18.5,2,28]) rotate([0,0,0]) rotate([90,0,0]) FW_MagSw_BoltPattern() Bolt4Hole();
	} // difference
	
	rotate([0,0,RocketServo_a]) translate([0,RocketServo_Y,RocketServo_Z]) rotate([0,180,0]) rotate([90,0,0]) 
		difference(){
			RocketServoHolderRevC(IsDouble=false, HasBackHoles=false);
			
			hull(){
				translate([0,0,-Overlap]) cylinder(d=12, h=5);
				translate([0,28,-Overlap]) cylinder(d=4, h=5);
				translate([0,-28,-Overlap]) cylinder(d=4, h=5);
			} // hull
		} // difference
	
	rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,-90]) BattPocket();
	
} // R75_EBayBR

// R75_EBayBR();

module R75_RocketServoMountVert2(Base_h=0, Light=true){
	difference(){
		translate([0,0,RSHolder_OAY()/2+Base_h]) rotate([-90,0,0]) RocketServoHolderRevC(IsDouble=false,HasBackHoles=false);
		
		if (Light) translate([0,-Overlap, RSHolder_OAY()/2+Base_h])
			hull(){
				rotate([-90,0,0]) cylinder(d=10, h=5);
				translate([0,0,27]) rotate([-90,0,0]) cylinder(d=2, h=5);
				translate([0,0,-27]) rotate([-90,0,0]) cylinder(d=5, h=5);
			} // hull
	} // difference
	
	translate([-RSHolder_OAX()/2,0,0]) cube([RSHolder_OAX(), RSHolder_OAZ(), Base_h+2.2]);
} // R75_RocketServoMountVert2

// R75_RocketServoMountVert2();

module R75_RocketServoMountVertBoltPattern(Base_h=0){
	translate([0,0,RSHolder_OAY()/2+Base_h]) rotate([-90,0,0]) 
		RocketServoRevCBoltPattern() children();
	
} // R75_RocketServoMountVertBoltPattern

// R75_RocketServoMountVertBoltPattern(Base_h=0) Bolt4Hole();

	

module R75_EBayMC(OD=BT75Coupler_OD, CenterBolt_d=0.250*25.4, CenterBolt_p=25.4/20, HasRS_Mount=false, BaseOnly=true, UseMCClip=false){
	// Mission Control version
	// Featherweight Mag Switch, Rocket Servo PCBA, 2S LiPo
		
	Thread_d=CenterBolt_d;
	Thread_p=CenterBolt_p;

	Mag_SW_a=90;
	Mag_SW_X=-20.5;
	Mag_SW_Y=-8.5;
	Mag_SW_Z=18;

	EBayMC_Len=MC_Size_Z()+10;
	Alt_Z=EBayMC_Len/2+2;
	Alt_Y=OD/2-14;
	AltBoltBoss_h=3.5;
	BackPlate_W=42;
	BackPlate_t=4;

	Battery_Z=22.2;
	Battery_X=0;
	Battery_Y=-20;
	Battery_a=0;
	BattRotation_a=90;

	// Battery size
	Batt_X=20;
	Batt_Y=12.2;
	Batt_Z=40; // was 43

	RS_X=7;
	RS_Y=-3;

	module Gusset(X0=0, Y0=0, Z=0, X1=10, Y1=10, Len=10){
		T=1.2;
		
		hull(){
			translate([X0,Y0,Z]) cylinder(d=T, h=Len);
			translate([X1,Y1,Z]) cylinder(d=T, h=Len);
		} // hull
	} // Gusset
	
	module AltHoles(){
		AltHoles_X=28;
		AltHoles_Y=86.35;

		if (!BaseOnly){
			translate([-AltHoles_X/2, AltHoles_Y/2, 0]) children();
			translate([AltHoles_X/2, AltHoles_Y/2, 0]) children();
		}
		translate([-AltHoles_X/2, -AltHoles_Y/2, 0]) children();
		translate([AltHoles_X/2, -AltHoles_Y/2, 0]) children();
	} // AltHoles
	
	module MC_ClipBolts(){
		PCB_X=33.1;
		PCB_t=1.55;
		Clip_Z=Bolt4Inset*2;
		Clip_t=6;
		Clip_BC=PCB_X+3;
		
			translate([-Clip_BC/2,Clip_t,0]) rotate([-90,0,0]) Bolt4Hole();
			translate([Clip_BC/2,Clip_t,0]) rotate([-90,0,0]) Bolt4Hole();

	}
	
	module MC_Clip(){
		PCB_X=33.1;
		PCB_t=1.55;
		Clip_Z=Bolt4Inset*2;
		Clip_t=6;
		Clip_BC=PCB_X+3;
		
		difference(){
			hull(){
				translate([-Clip_BC/2,0,0]) rotate([-90,0,0]) cylinder(d=Clip_Z, h=Clip_t);
				translate([Clip_BC/2,0,0]) rotate([-90,0,0]) cylinder(d=Clip_Z, h=Clip_t);
			} // hull
			
			// PCB
			
			translate([-PCB_X/2-0.25,Clip_t-PCB_t,-Clip_Z/2-Overlap]) cube([PCB_X+0.5,5,Clip_Z+Overlap*2]);
			
			MC_ClipBolts();
		} // difference
	
	} // MC_Clip
	
	// MC_Clip();
	
	module BattHole(Xtra_X=0,Xtra_Y=0, Xtra_Z=0){
		cube([Batt_X+Xtra_X, Batt_Y+Xtra_Y, Batt_Z+Xtra_Z], center=true);
	} // BattHole
	
	module BattPocket(){
		Wall_t=1.2;
		
		difference(){
			BattHole(Xtra_X=Wall_t*2,Xtra_Y=Wall_t*2, Xtra_Z=Wall_t*2);
			
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			
			// wires
			translate([0,0,Batt_Z/2+2]) rotate([0,90,0]) cylinder(d=7, h=20);
			
			// push-up
			translate([0,0,-Batt_Z/2-Wall_t-Overlap]) cylinder(d=5,h=5);
			
			// Lighter		
			hull(){
				rotate([90,0,0]) cylinder(d=14, h=Batt_Y+Wall_t*2+Overlap, center=true);
				translate([0,0,Batt_Z/3]) rotate([90,0,0]) cylinder(d=3, h=Batt_Y+Wall_t*2+Overlap, center=true);
				translate([0,0,-Batt_Z/3]) rotate([90,0,0]) cylinder(d=3, h=Batt_Y+Wall_t*2+Overlap, center=true);
			} // hull
			
			hull(){
				rotate([0,90,0]) cylinder(d=10, h=Batt_X+Wall_t*2+Overlap, center=true);
				translate([0,0,Batt_Z/3]) rotate([0,90,0]) cylinder(d=3, h=Batt_X+Wall_t*2+Overlap, center=true);
				translate([0,0,-Batt_Z/3]) rotate([0,90,0]) cylinder(d=3, h=Batt_X+Wall_t*2+Overlap, center=true);
			} // hull
			
		} // difference
	} // BattPocket
	
	// Battery Holder
	difference(){
		rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,BattRotation_a]) 
			BattPocket();
			
		rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y+2,Mag_SW_Z]) rotate([90,0,0]) 
			FW_MagSw_BoltPattern(Reversed=true) translate([0,0,5]) Bolt4Hole();
			
		translate([-RS_X,RS_Y,0]) rotate([0,0,90]) R75_RocketServoMountVertBoltPattern(Base_h=1) Bolt4Hole();
		translate([RS_X,RS_Y,0]) rotate([0,0,-90]) R75_RocketServoMountVertBoltPattern(Base_h=1) Bolt4Hole();
	} // difference
	
	// Base Plate
	difference(){
		rotate([0,0,90]) 
			R75_EBay_BasePlate(OD=OD, IsLowerPlate=false, 
					CenterBolt_d=CenterBolt_d, CenterBolt_p=CenterBolt_p, HasSecBolts=false, ShockCord_a=22.5);
		
		// Sustainer wire path uses SecBolt hole
		
		// Servo wire path
		SWire_a=40;
		SWire_Y=OD/2-4;
		rotate([0,0,SWire_a])
		hull(){
			translate([3,SWire_Y,-Overlap]) cylinder(d=3.5, h=5);
			translate([-3,SWire_Y,-Overlap]) cylinder(d=3.5, h=5);
		} // hull
		
		// Battery pushing hole and cleanup inside
		rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,BattRotation_a]) rotate([0,0,-90]) {
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			translate([0,0,-Batt_Z/2-4-Overlap]) cylinder(d=5,h=5);}
	} // difference
	
	// Mission Control Mount
	difference(){
		union(){
			// Alt bolt bosses
			translate([0,Alt_Y,Alt_Z]) rotate([90,0,0]) AltHoles() cylinder(d2=10, d1=6, h=AltBoltBoss_h+0.5+Overlap);
			
			// Backing plate
			hull(){
				if (!BaseOnly){
					translate([BackPlate_W/2-6.5, Alt_Y-AltBoltBoss_h-BackPlate_t/2, Alt_Z+MC_HoleSpace_Z()/2]) 
						rotate([90,0,0]) cylinder(d=10, h=BackPlate_t, center=true);
					
					translate([-BackPlate_W/2+6.5, Alt_Y-AltBoltBoss_h-BackPlate_t/2, Alt_Z+MC_HoleSpace_Z()/2]) 
						rotate([90,0,0]) cylinder(d=10, h=BackPlate_t, center=true);
				}
			
				translate([BackPlate_W/2-BackPlate_t/2, Alt_Y-AltBoltBoss_h-BackPlate_t/2, 0]) 
					cylinder(d=BackPlate_t, h=15);
				
				translate([-BackPlate_W/2+BackPlate_t/2, Alt_Y-AltBoltBoss_h-BackPlate_t/2, 0]) 
					cylinder(d=BackPlate_t, h=15);
			} // hull
			
			// Threaded rod 
			if (!BaseOnly)
			translate([0, 0, Alt_Z+MC_Size_Z()/2-2]) 
				hull(){
					cylinder(d=CenterBolt_d+4.4, h=5, center=true);
					translate([0, Alt_Y-AltBoltBoss_h-2.5, 0]) scale([1,0.1,1]) cylinder(d=CenterBolt_d+10, h=5, center=true);
				} // hull
				
			if (UseMCClip)
				translate([0,Alt_Y-4.5,65]) MC_Clip();
					
		} // union
		
		if (UseMCClip){
			translate([0,Alt_Y-4.5,65]) MC_ClipBolts();
			translate([-30,Alt_Y-40,65+4]) cube([60,60,60]);
			// Center cut-out
			translate([0, Alt_Y-AltBoltBoss_h-1.5, Alt_Z+2.5-16]) cube([26,20,43.5], center=true);
		}else{
			// Center cut-out
			translate([0, Alt_Y-AltBoltBoss_h-1.5, Alt_Z+2.5]) cube([26,20,75], center=true);
		}

		
		// MagSW Bolts
		rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y+2,Mag_SW_Z]) rotate([90,0,0]) 
			FW_MagSw_BoltPattern(Reversed=true) translate([0,0,5]) Bolt4Hole(depth=6);
			
		// Terminal block clearance
		translate([-27/2,0,Alt_Z+MC_Size_Z()/2-20.7]) cube([27,20,15]);
		
		// connector
		translate([0, Alt_Y-AltBoltBoss_h-1.5, Alt_Z-MC_Size_Z()/2+5.5]) cube([21,20,12], center=true);
		
		
		// Threaded rod
		//cylinder(d=MotorBolt_d, h=EBayMC_Len+10);
		Boss_t=5;
		
		// Align to lower thread
		translate([0,0,-Overlap+floor((Alt_Z+MC_Size_Z()/2-2-Boss_t/2)/Thread_p)*Thread_p])
			if ($preview){
				cylinder(d=Thread_d, h=Boss_t+Thread_p); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Thread_p, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
			
		// alt bolts
		translate([0,Alt_Y,Alt_Z]) rotate([90,0,0]) AltHoles() 
			rotate([180,0,0]) Bolt4Hole(depth=AltBoltBoss_h+5);
	} // difference

	if (HasRS_Mount){
		//translate([12,-2,0]) rotate([0,0,90]) R75_RocketServoMountVert(Base_h=1);
		//translate([-12,-2,0]) rotate([0,0,-90]) R75_RocketServoMountVert(Base_h=1);
		
		translate([-RS_X,RS_Y,0]) rotate([0,0,90]) R75_RocketServoMountVert2(Base_h=1, Light=true);
		translate([RS_X,RS_Y,0]) rotate([0,0,-90]) R75_RocketServoMountVert2(Base_h=1, Light=true);
		
		// gussets
		/*
		difference(){
			union(){
				Gusset(X0=-15, Y0=11, Z=0, X1=-12, Y1=6, Len=65);
				Gusset(X0=15, Y0=11, Z=0, X1=12, Y1=6, Len=65);
			} // union
			
			translate([-RS_X,RS_Y,0]) rotate([0,0,90]) 
				R75_RocketServoMountVertBoltPattern(Base_h=1) translate([0,0,1.7]) Bolt4ButtonHeadHole();
			translate([RS_X,RS_Y,0]) rotate([0,0,-90]) 
				R75_RocketServoMountVertBoltPattern(Base_h=1) translate([0,0,1.7]) Bolt4ButtonHeadHole();

			// alt bolts
			translate([0,Alt_Y,Alt_Z]) rotate([90,0,0]) AltHoles() 
				rotate([180,0,0]) Bolt4Hole(depth=12);
		} // difference
		/**/
	}
	
	// LED face plate
	MC_LED_Z=Alt_Z-MC_Size_Z()/2+MC_LED_Z();
	MC_ArmScrew_Z=Alt_Z-MC_Size_Z()/2+MC_ArmingScrew_Z();
	RS_LED_Z=MC_LED_Z-7;
	RS2_LED_Z=MC_ArmScrew_Z-7;
	difference(){
		translate([0,OD/2-2.2,0]) RoundRect(X=12, Y=3, Z=MC_LED_Z()+15, R=1.3);
		
		translate([0,Alt_Y,MC_LED_Z]) rotate([-90,0,0]) cylinder(d=5, h=20);
		translate([0,Alt_Y,MC_ArmScrew_Z]) rotate([-90,0,0]) cylinder(d=5, h=20);
		
		translate([0,Alt_Y,RS_LED_Z]) rotate([-90,0,0]) cylinder(d=3, h=20);
		translate([0,Alt_Y,RS2_LED_Z]) rotate([-90,0,0]) cylinder(d=3, h=20);
	} // difference
	
	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y+2,Mag_SW_Z]) rotate([90,0,0]) FW_MagSw_Mount(HasMountingEars=false, Reversed=true);
	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y-0.5,0]) RoundRect(X=17.4,Y=5,Z=Mag_SW_Z-9.5, R=0.1);
	
	//if ($preview) translate([0,Alt_Y,Alt_Z]) rotate([0,0,180]) rotate([90,0,0]) AltPCB();
} // R75_EBayMC

// R75_EBayMC(OD=LOC65Coupler_OD, CenterBolt_d=0.250*25.4, CenterBolt_p=25.4/20, HasRS_Mount=false, BaseOnly=true, UseMCClip=false);

module R75_EBayMCTop(OD=ULineH75Body_ID, CenterBolt_d=0.312*25.4, CenterBolt_p=25.4/18){
	// Mission Control version
	// Featherweight Mag Switch, Rocket Servo PCBA, 2S LiPo
		
	Thread_d=CenterBolt_d;
	Thread_p=CenterBolt_p;

	EBayMC_Len=MC_Size_Z()+10;
	Alt_Z=EBayMC_Len/2+2;
	Alt_Y=OD/2-15;
	AltBoltBoss_h=3.5;
	BackPlate_W=42;
	BackPlate_t=4;

	module AltHoles(){
		AltHoles_X=28;
		AltHoles_Y=86.35;

		translate([-AltHoles_X/2, AltHoles_Y/2, 0]) children();
		translate([AltHoles_X/2, AltHoles_Y/2, 0]) children();
		//translate([-AltHoles_X/2, -AltHoles_Y/2, 0]) children();
		//translate([AltHoles_X/2, -AltHoles_Y/2, 0]) children();
	} // AltHoles

	// Mission Control Mount
	difference(){
		union(){
			// Alt bolt bosses
			translate([0,Alt_Y,Alt_Z]) rotate([90,0,0]) AltHoles() cylinder(d2=10, d1=6, h=AltBoltBoss_h+0.5+Overlap);
			
			// Backing plate
			hull(){
				translate([BackPlate_W/2-6.5, Alt_Y-AltBoltBoss_h-BackPlate_t/2, Alt_Z+MC_HoleSpace_Z()/2]) 
					rotate([90,0,0]) cylinder(d=10, h=BackPlate_t, center=true);
					
				translate([-BackPlate_W/2+6.5, Alt_Y-AltBoltBoss_h-BackPlate_t/2, Alt_Z+MC_HoleSpace_Z()/2]) 
					rotate([90,0,0]) cylinder(d=10, h=BackPlate_t, center=true);
			} // hull
			
			// Threaded rod 
			H=7;
			translate([0, 0, Alt_Z+MC_Size_Z()/2-1.1]) 
				hull(){
					cylinder(d=CenterBolt_d+4.4, h=H, center=true);
					translate([0, Alt_Y-AltBoltBoss_h-2.5, 0]) scale([1,0.1,1]) cylinder(d=CenterBolt_d+10, h=H, center=true);
				} // hull
		} // union
		
		// Terminal block clearance
		translate([-27/2,0,Alt_Z+MC_Size_Z()/2-20.7]) cube([27,20,15]);
		
		// Center cut-out
		translate([0, Alt_Y-AltBoltBoss_h-1.5, Alt_Z+2.5]) cube([26,20,75], center=true);
		
		// Threaded rod
		//cylinder(d=MotorBolt_d, h=EBayMC_Len+10);
		Boss_t=7;
		
		// Align to lower thread
		translate([0,0,-Overlap+floor((Alt_Z+MC_Size_Z()/2-2-Boss_t/2)/Thread_p)*Thread_p])
			if ($preview){
				cylinder(d=Thread_d, h=Boss_t+Thread_p*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Thread_p*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
	
		
		// alt bolts
		translate([0,Alt_Y,Alt_Z]) rotate([90,0,0]) AltHoles() rotate([180,0,0]) Bolt4Hole(depth=AltBoltBoss_h+5);
	} // difference
	
	//if ($preview) translate([0,Alt_Y,Alt_Z]) rotate([0,0,180]) rotate([90,0,0]) AltPCB();
} // R75_EBayMCTop

// R75_EBayMCTop();













