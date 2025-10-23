// ***********************************
// Project: 3D Printed Rocket
// Filename: R65Lib.scad
// by David M. Flynn
// Created: 10/21/2025 
// Revision: 0.9.2  10/23/2025 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of parts for 65mm rockets.
//
//  ***** History *****
//
function R65Lib_Rev()="R65Lib 0.9.2";
echo(R65Lib_Rev());
// 0.9.2  10/23/2025 Added Blue Raven and Mission Control ebays
// 0.9.1  10/22/2025 Added more, R65_MotorTubeTopper(), ...
// 0.9.0  10/21/2025 First code, copied from Rocket6551
//
// ***********************************
//  ***** for STL output *****
//
// R65_NoseCone(Shoulder_OD=LOC65Coupler_OD, OD=LOC65Body_OD, nBolts=6, NC_Len=150, NC_Base_L=6, NC_Tip_R=3, NC_Wall_t=1.2);
// R65_NC_GPS_Mounting_Plate(OD=LOC65Coupler_OD, nBolts=6, Skirt_h=5, HasAlTube=true);
// R65_EBay_BasePlate(OD=LOC65Coupler_OD, IsLowerPlate=false, CenterBolt_d=0.250*25.4, CenterBolt_p=25.4/20, HasSecBolts=false, ShockCord_a=-30);
// R65_EBayBR(OD=LOC65Coupler_OD, CenterBolt_d=0.250*25.4, CenterBolt_p=25.4/20);
// R65_RocketServoMountVert(Base_h=0);
// R65_EBayMC(OD=LOC65Coupler_OD, CenterBolt_d=0.250*25.4, CenterBolt_p=25.4/20, HasRS_Mount=false);
// R65_EBayMiddleRing(OD=LOC65Coupler_OD, Len=30, Thread_d=5/16*25.4, Thread_p=25.4/18);
// R65_PetalHub(OD=LOC65Coupler_OD, nPetals=3, nBolts=6, Skirt_h=5, HasWirePath=false);
// R65_DroguePetalHub(OD=LOC65Coupler_OD, nPetals=3, nBolts=6, Skirt_h=5, HasWirePath=false);
/*
R65_DrogueCoupler(OD=LOC65Body_ID, Coupler_ID=LOC65Coupler_ID, 
			Thread_d=Thread25020_d, Thread_p=Thread25020_Pitch, LockPin_d=16,
			nRopes=0, Skirt_h=25, HasTubeStop=false, Body_OD=LOC65Body_OD, HasWirePath=false, HasStiffCore=false);
/**/
// R65_MotorNutStop(MT_ID=ULine38Body_ID, Hole_d=6.35);
// R65_FwdSpringEnd(OD=LOC65Coupler_OD, ID=LOC65Coupler_ID, LockPin_d=16, nRopes=0, Skirt_h=25, HasServoConnector=false);
// R65_SpringSliderLight(OD=LOC65Coupler_OD, Len=35);
// R65_MotorTubeTopper(OD=LOC65Body_ID, ID=LOC29Body_OD, MT_ID=LOC29Body_ID-3);
//
//  *** Tools ***
//
// R65_DeepSocket(); // 7/16" Socket for 1/4-20 nuts (29mm RMS)
// R65_DeepSocket500(); // 1/2" Socket for 5/16-18 nuts (38mm RMS)
//
// ***********************************
include<TubesLib.scad>
use<SpringThingBooster.scad>	echo(SpringThingBoosterRev());
use<PetalDeploymentLib.scad>	echo(PetalDeploymentLibRev());
use<SpringEndsLib.scad>			echo(SpringEndsLibRev());
use<NoseCone.scad>				echo(NoseConeRev());
use<ThreadLib.scad>         	echo(ThreadLibRev());
use<BatteryHolderLib.scad>		echo(BatteryHolderLibRev());
use<AltBay.scad>				echo(AltBayRev());

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

Thread1024_d=0.190*25.4;
Thread25020_d=0.250*25.4;
Thread25020_Pitch=25.4/20;
Bolt10Inset=5.5;
Bolt4Inset=4;

module R65_DeepSocket(){
	// 7/16" Socket for 1/4-20 nuts (29mm RMS)
	Len=40;
	Al_Tube_d=5/16*25.4;
	
	difference(){
		cylinder(d=16, h=Len);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Al_Tube_d+IDXtra, h=Len+Overlap*2);
	
		translate([0,0,-Overlap]) Bolt250NutHole(depth=7);
	} // difference
} // DeepSocket

// R65_DeepSocket();

module R65_DeepSocket500(){
	// 1/2" Socket for 5/16-18 nuts (38mm RMS)
	Len=40;
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
} // R65_DeepSocket500

// R65_DeepSocket500();

module R65_NoseCone(Shoulder_OD=LOC65Coupler_OD, OD=LOC65Body_OD, nBolts=6,
			NC_Len=150, NC_Base_L=6, NC_Tip_R=3, NC_Wall_t=1.2){
	
	BluntOgiveNoseCone(ID=OD-4.4, OD=OD, L=NC_Len, Base_L=NC_Base_L, nRivets=0, RivertInset=0, Tip_R=NC_Tip_R, HasThreadedTip=false, Wall_T=NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);

	difference(){
		PD_PetalHubBoltPattern(OD=Shoulder_OD, nBolts=nBolts) hull(){
			cylinder(d=7, h=NC_Base_L);
			translate([0,3.5,0]) scale([1,0.2,1]) cylinder(d=9, h=NC_Base_L);
		}
		
		PD_PetalHubBoltPattern(OD=Shoulder_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4Hole();					
	} // difference
} // R65_NoseCone

// R65_NoseCone();

module R65_NC_GPS_Mounting_Plate(OD=LOC65Coupler_OD, nBolts=6, Skirt_h=5, HasAlTube=true){
// *** not finished ***

	Al_Tube_d=8;
	Al_Tube_Len=30;
	CenterHole_d=18;
	Wall_t=1.8;
	
	// GPS mount
	Post_W=10;
	Post_Y=6;
	rotate([0,0,-30]) translate([24,0,4]) rotate([0,-15,0]) rotate([0,0,90]) FW_GPS_Mount();
	rotate([0,0,-30]) translate([24,0,0]) rotate([0,0,90]) translate([-Post_W/2,Post_Y,0]) cube([Post_W,10,Skirt_h]);
	
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

	difference(){
		union(){
			// GPS support
			intersection(){
				difference(){
					hull(){
						cylinder(d=1, h=Skirt_h);
						rotate([0,0,-120]) translate([0,OD/2,0]) cylinder(d=32, h=Skirt_h);
					} // hull
					
					translate([0,0,-Overlap]) cylinder(d=20, h=Skirt_h+Overlap*2);
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
				translate([0,0,Al_Tube_d/2+Skirt_h]) rotate([90,0,0]) cylinder(d=Al_Tube_d+4, h=Al_Tube_Len, center=true);
				translate([-Al_Tube_d/2-3, -Al_Tube_Len/2,0]) cube([Al_Tube_d+6, Al_Tube_Len, 1]);
			} // hull
			
		} // union
		
		PD_PetalHubBoltPattern(OD=OD, nBolts=nBolts) rotate([180,0,0]) Bolt4ClearHole();
		
		// Aluminum Tube
		if (HasAlTube)
			translate([0,0,Al_Tube_d/2+Skirt_h]) rotate([90,0,0]) cylinder(d=Al_Tube_d, h=OD, center=true);
			
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=Skirt_h+Al_Tube_d+4);
	} // difference
} // R65_NC_GPS_Mounting_Plate

// R65_NC_GPS_Mounting_Plate();


module R65_EBay_BasePlate(OD=LOC65Coupler_OD, IsLowerPlate=false, 
					CenterBolt_d=0.250*25.4, CenterBolt_p=25.4/20, HasSecBolts=false, ShockCord_a=-30){
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
} // R65_EBay_BasePlate

// R65_EBay_BasePlate(IsLowerPlate=true);
// R65_EBay_BasePlate(IsLowerPlate=false);

module R65_EBayBR(OD=LOC65Coupler_OD, CenterBolt_d=0.250*25.4, CenterBolt_p=25.4/20){
	// Blue Raven, Mag Switch, Rocket Servo, 2 cell LiPo
	Raven_Z=30;
	Raven_a=-90;
	Raven_X=-7;
	Raven_Y=0;

	RocketServo_Z=33.5;
	RocketServo_a=0;
	RocketServo_Y=-7;
	
	Mag_SW_a=0;
	Mag_SW_X=23;
	Mag_SW_Y=0;
	
	
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
		
	difference(){
		rotate([0,0,30]) R65_EBay_BasePlate(OD=OD, IsLowerPlate=false, CenterBolt_d=CenterBolt_d, CenterBolt_p=CenterBolt_p,
				HasSecBolts=false, ShockCord_a=-30);
		
		// Battery pushing hole and cleanup inside
		rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,-90]) {
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			translate([0,0,-Batt_Z/2-4-Overlap]) cylinder(d=5,h=5);}
	} // difference

	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y+2,28]) rotate([0,0,0]) rotate([90,0,0]) FW_MagSw_Mount(HasMountingEars=false);
	
	difference(){
		rotate([0,0,Raven_a]) translate([Raven_X,Raven_Y,Raven_Z]) rotate([0,-90,0]) BlueRavenMount();
		
		rotate([0,0,Mag_SW_a]) translate([18.5,2,28]) rotate([0,0,0]) rotate([90,0,0]) FW_MagSw_BoltPattern() Bolt4Hole();
	} // difference
	
	rotate([0,0,RocketServo_a]) translate([0,RocketServo_Y,RocketServo_Z]) rotate([0,180,0]) rotate([90,0,0]) 
		difference(){
			RocketServoHolderRevC(IsDouble=false);
			
			hull(){
				translate([0,0,-Overlap]) cylinder(d=12, h=5);
				translate([0,28,-Overlap]) cylinder(d=4, h=5);
				translate([0,-28,-Overlap]) cylinder(d=4, h=5);
			} // hull
		} // difference
	
	rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,-90]) BattPocket();
	
} // R65_EBayBR

// R65_EBayBR();

module R65_RocketServoMountVert(Base_h=0){
	RS_PCB_X=15;
	RS_PCB_Z=61;
	RS_PCB_t=1.6;
	Wall_t=1.2;
	
	// Base
	difference(){
		translate([0,1,0]) RoundRect(X=RS_PCB_X+1+Wall_t*2, Y=7, Z=4+Base_h, R=0.5);
		
		translate([0,0,4+Base_h]) cube([RS_PCB_X+IDXtra*2, RS_PCB_t+IDXtra*2, 4], center=true);
	} // difference
	
	translate([0,0,2+45+Base_h]) 
		difference(){
			hull(){
				translate([0,2,2]) RoundRect(X=RS_PCB_X+1+Wall_t*2, Y=4, Z=2, R=0.5);
				translate([0,3,-2]) RoundRect(X=RS_PCB_X+1+Wall_t*2, Y=1.5, Z=1, R=0.5);
			} // hull
			
			translate([0,-2+RS_PCB_t/2,2]) cube([RS_PCB_X+IDXtra*2, 4, 25], center=true);
			
			translate([0,-2+RS_PCB_t/2,2]) cube([RS_PCB_X-2, 8, 25], center=true);
		} //difference
	
	// post
	translate([0,4,0]) RoundRect(X=RS_PCB_X+1+Wall_t*2, Y=3, Z=51+Base_h, R=0.5);
} // R65_RocketServoMountVert

//R65_RocketServoMountVert(Base_h=0);

module R65_EBayMC(OD=LOC65Coupler_OD, CenterBolt_d=0.250*25.4, CenterBolt_p=25.4/20, HasRS_Mount=false){
	// Mission Control version
	// Featherweight Mag Switch, Rocket Servo PCBA, 2S LiPo
		
	Thread_d=CenterBolt_d;
	Thread_p=CenterBolt_p;

	Mag_SW_a=-122;
	Mag_SW_X=23.5;
	Mag_SW_Y=0;
	Mag_SW_Z=18;

	EBayMC_Len=MC_Size_Z()+10;
	Alt_Z=EBayMC_Len/2+2;
	Alt_Y=OD/2-15;
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
	
	difference(){
		rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,BattRotation_a]) 
			BattPocket();
			
		rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y+2,Mag_SW_Z]) rotate([90,0,0]) 
			FW_MagSw_BoltPattern() Bolt4Hole();
	} // difference
	
	// Base Plate
	difference(){
		rotate([0,0,259+180]) 
			R65_EBay_BasePlate(OD=OD, IsLowerPlate=false, 
					CenterBolt_d=CenterBolt_d, CenterBolt_p=CenterBolt_p, HasSecBolts=true, ShockCord_a=-20);
		
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
				translate([BackPlate_W/2-6.5, Alt_Y-AltBoltBoss_h-BackPlate_t/2, Alt_Z+MC_HoleSpace_Z()/2]) 
					rotate([90,0,0]) cylinder(d=10, h=BackPlate_t, center=true);
					
				translate([-BackPlate_W/2+6.5, Alt_Y-AltBoltBoss_h-BackPlate_t/2, Alt_Z+MC_HoleSpace_Z()/2]) 
					rotate([90,0,0]) cylinder(d=10, h=BackPlate_t, center=true);
			
				translate([BackPlate_W/2-BackPlate_t/2, Alt_Y-AltBoltBoss_h-BackPlate_t/2, 0]) 
					cylinder(d=BackPlate_t, h=Alt_Z+MC_HoleSpace_Z()/2);
				
				translate([-BackPlate_W/2+BackPlate_t/2, Alt_Y-AltBoltBoss_h-BackPlate_t/2, 0]) 
					cylinder(d=BackPlate_t, h=Alt_Z+MC_HoleSpace_Z()/2);
			} // hull
			
			// Threaded rod 
			translate([0, 0, Alt_Z+MC_Size_Z()/2-2]) 
				hull(){
					cylinder(d=CenterBolt_d+4.4, h=5, center=true);
					translate([0, Alt_Y-AltBoltBoss_h-2.5, 0]) scale([1,0.1,1]) cylinder(d=CenterBolt_d+10, h=5, center=true);
				} // hull
		} // union
		
		// Terminal block clearance
		translate([-27/2,0,Alt_Z+MC_Size_Z()/2-20.7]) cube([27,20,15]);
		
		// connector
		translate([0, Alt_Y-AltBoltBoss_h-1.5, Alt_Z-MC_Size_Z()/2+5.5]) cube([21,20,12], center=true);
		
		// Center cut-out
		translate([0, Alt_Y-AltBoltBoss_h-1.5, Alt_Z+2.5]) cube([26,20,75], center=true);
		
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
		translate([0,Alt_Y,Alt_Z]) rotate([90,0,0]) AltHoles() rotate([180,0,0]) Bolt4Hole(depth=AltBoltBoss_h+5);
	} // difference
	
	if (HasRS_Mount){
		translate([12,-2,0]) rotate([0,0,90]) R65_RocketServoMountVert(Base_h=1);
		translate([-12,-2,0]) rotate([0,0,-90]) R65_RocketServoMountVert(Base_h=1);
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
	
	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y+2,Mag_SW_Z]) rotate([90,0,0]) FW_MagSw_Mount(HasMountingEars=false);
	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y,0]) RoundRect(X=17,Y=4,Z=Mag_SW_Z-9.5, R=1);
	
	//if ($preview) translate([0,Alt_Y,Alt_Z]) rotate([0,0,180]) rotate([90,0,0]) AltPCB();
} // R65_EBayMC

// R65_EBayMC(HasRS_Mount=true);


module R65_EBayMiddleRing(OD=LOC65Coupler_OD, Len=30, Thread_d=5/16*25.4, Thread_p=25.4/18){
	nSpokes=6;
	Spoke_t=1.2;
	Wall_t=1.8;
	nRivets=3;

	nOuterBolts=2;
	Outer_BC_d=OD-Bolt10Inset*2;
	
	difference(){
		union(){
			cylinder(d=Thread_d+4.4, h=Len);
			
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j])
					hull(){
						H=(j==1)? 8:Len;
						cylinder(d=Spoke_t, h=H);
						translate([0,OD/2-Wall_t,0]) cylinder(d=Spoke_t, h=H);
					} // hull
				
			
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 36:180);
			
			// #10-24 threaded rods
			for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
				hull(){
					translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=Len);
					translate([0,OD/2-1,0]) scale([1,0.1,1]) cylinder(d=Thread1024_d+6.4, h=Len);
				} // hull
			
			// shock cord
			ShockCord_a=-30;
			rotate([0,0,ShockCord_a])
				translate([0,10,Len/2]) cylinder(d=11, h=10, center=true);
				
		} // union
		
		// shock cord
			ShockCord_a=-30;
			rotate([0,0,ShockCord_a])
				translate([0,10,Len/2]) cylinder(d=3.6, h=11, center=true);
				
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+180/nSpokes])
			translate([0,OD/2,Len/2]) rotate([90,0,0]) cylinder(d=4, h=6, center=true);
		
		// center Thread
		translate([0,0,-Overlap])
			if ($preview){
				cylinder(d=Thread_d, h=Len+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Len+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
			
		for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
			translate([0,Outer_BC_d/2,-Overlap]) {
				Thread_d=Thread1024_d;
				Thread_p=25.4/24;
						
				if ($preview){
					cylinder(d=Thread_d, h=Len+Overlap*2); 
				}else{
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
							Length=Len+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true);
				}}
	} // difference

} // R65_EBayMiddleRing

// R65_EBayMiddleRing();

module R65_PetalHub(OD=LOC65Coupler_OD, nPetals=3, nBolts=6, Skirt_h=5, HasWirePath=false){
	// attaches to nose cone
	
	CenterHole_d=5;
	
	module WireHole(){
		// wire path
		translate([0,-OD/2+6,-Skirt_h-Overlap]) rotate([0,0,90])
		hull(){
			translate([0,-4,0]) cylinder(d=3.5, h=Skirt_h+20);
			translate([0,+4,0]) cylinder(d=3.5, h=Skirt_h+20);
		} // hull
		
		// Shock cord, must miss servo
		rotate([0,0,120]) translate([0,-10,-Skirt_h-Overlap]) cylinder(d=4, h=Skirt_h+20);
	} // WireHole
	
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
		
		if (HasWirePath) WireHole();
	} // difference
	
	difference(){
		PD_PetalHub(OD=OD, 
					nPetals=nPetals, 
					HasReplaceableSpringHolder=false,
					HasBolts=true,
					nBolts=nPetals*2, // Same as nPetals
					ShockCord_a=-1,
					HasNCSkirt=false, 
						Body_OD=BT75Body_OD,
						Body_ID=BT75Body_ID,
						NC_Base=0, 
						SkirtLen=10, 
					CenterHole_d=0, nRopes=0);
					
		// center hole
		//translate([0,0,-Overlap]) cylinder(d=28, h=30);
		translate([0,0,-Skirt_h-Overlap]) cylinder(d=CenterHole_d, h=Skirt_h+30);
		
		if (HasWirePath) WireHole();
			
	} // difference
} // R65_PetalHub

// R65_PetalHub();

module R65_DroguePetalHub(OD=LOC65Coupler_OD, nPetals=3, nBolts=6, Skirt_h=5, HasWirePath=false){
	Skirt_H=15;
	Thread_d=Thread1024_d;
	Thread_p=25.4/24;
	LockPin_d=16;
	Spring_ID=SE_Spring_CS4323_ID();
	
	difference(){
		union(){
			R65_PetalHub(OD=OD, nPetals=nPetals, Skirt_h=Skirt_H, HasWirePath=true);
			translate([0,0,-Skirt_H]) cylinder(d=LockPin_d, h=Skirt_H+6);
			
			translate([0,0,-4]) Tube(OD=Spring_ID, ID=Spring_ID-4.4, Len=5, myfn=90);
		} // union
		
		
		translate([0,0,-Skirt_H-Overlap]) 				
		if ($preview){
			cylinder(d=Thread_d, h=Skirt_H+7); 
		}else{
			ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
					Length=Skirt_H+7, 
					Step_a=2,TrimEnd=true,TrimRoot=true);
		}
	} // difference
} // R65_DroguePetalHub

// R65_DroguePetalHub();

module R65_DrogueCoupler(OD=LOC65Body_ID, Coupler_ID=LOC65Coupler_ID, 
			Thread_d=Thread25020_d, Thread_p=Thread25020_Pitch, LockPin_d=16,
			nRopes=0, Skirt_h=25, HasTubeStop=false, Body_OD=LOC65Body_OD, HasWirePath=false, HasStiffCore=false){
// This locks onto the bottom of the petals.
// For drogue bay

	CR_t=3;
	Rope_d=3;

	Petal_ID=OD-3.5; // should fit loose
	PetalLock_ID=OD-7.5; // Should not touch at all
	ShockCord_Y=HasStiffCore? Thread_p/2+10:OD/2-10;
	
	Boss_t=4;
	nVentHoles=5;
	VentHole_d=7;
	VentHole_Y=15+VentHole_d/2;
	Wall_t=1.8;
	myFn=floor(OD)*3;
	Len=HasTubeStop? Skirt_h*2+7:Skirt_h*2+4;
	CenterHole_H=HasStiffCore? Len:Boss_t;
	
	nSpokes=(nRopes==0)? nVentHoles:nRopes;
	Spoke_t=1.2;
	Spoke_a=180/nSpokes;
	ShockCord_a=Spoke_a;
	
	difference(){
		union(){
			difference(){
				cylinder(d=OD, h=6, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t-Overlap]) cylinder(d1=Coupler_ID-4, d2=Coupler_ID, h=4+Overlap*2, $fn=$preview? 90:myFn);
			} // difference
			
			cylinder(d=LockPin_d, h=Boss_t);
			
			// spokes
			if (HasStiffCore){
				// spokes
				for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j+Spoke_a])
					hull(){
						translate([0,0,CR_t-Overlap]) cylinder(d=Spoke_t, h=Len-CR_t+Overlap);
						translate([0,OD/2-Spoke_t,CR_t-Overlap]) cylinder(d=Spoke_t, h=Len-CR_t+Overlap);
					} // hull
					
				cylinder(d=Thread_d+4.4, h=Len);
				
				// Shock cord anchor
				rotate([0,0,ShockCord_a])
				hull(){
					translate([0,0,2.5]) rotate([-90,0,0]) cylinder(d=5, h=OD/2-1);
					translate([0,0,Len/2]) rotate([-90,0,0]) cylinder(d=12, h=OD/2-1);
					translate([0,0,Len-2.5]) rotate([-90,0,0]) cylinder(d=5, h=OD/2-1);
				} // hull
			} // if
			
			// Skirt
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 90:myFn);
			
			// Tube Stop
			if (HasTubeStop) translate([0,0,Skirt_h]) 
				Tube(OD=Body_OD, ID=OD-Wall_t*2, Len=3, myfn=$preview? 90:myFn);
			
			// Petal Lock ring
			difference(){
				cylinder(d=OD, h=CR_t+5.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t]) cylinder(d=PetalLock_ID-2.8, h=4.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t+3.5]) cylinder(d1=PetalLock_ID-2.8, d2=Coupler_ID, h=3.5+Overlap, $fn=$preview? 90:myFn);
			} // difference
			
		} // union
		
		// Center hole
		translate([0,0,-Overlap]) 
			if ($preview){
				cylinder(d=Thread_d, h=CenterHole_H+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=CenterHole_H+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			}
		
		// Air Vent Holes
		for (j=[0:nVentHoles-1]) rotate([0,0,360/nVentHoles*j]) 
			translate([0,VentHole_Y,-Overlap]) cylinder(d=VentHole_d, h=CR_t+Overlap*2);
		
		// Shock cord
		if (HasStiffCore){
			rotate([0,0,ShockCord_a+30]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=CR_t+Overlap*2);
			rotate([0,0,ShockCord_a-30]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=CR_t+Overlap*2);
		}else{
			rotate([0,0,180/nVentHoles]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=CR_t+Overlap*2);
		}
		
		if (HasWirePath) rotate([0,0,-Spoke_a*3+15]) translate([0,OD/2-10,-Overlap]) cylinder(d=5, h=30);
		
		// Petal Locks
		difference(){
			translate([0,0,-Overlap]) cylinder(d=OD+1, h=4.5+Overlap*2, $fn=$preview? 90:myFn);
			
			// Puller ring
			translate([0,0,-Overlap*2]) cylinder(d=Petal_ID, h=2+Overlap*3, $fn=$preview? 90:myFn);
			// Petal lock
			translate([0,0,-Overlap*2]) cylinder(d=PetalLock_ID, h=4.5+Overlap*3, $fn=$preview? 90:myFn);
			
		} // difference
		
		// Rope holes
		if (nRopes>0) for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
			translate([0,Spring_OD/2+Rope_d/2+2,-Overlap]) cylinder(d=Rope_d, h=CR_t+Overlap*2);
			
		//if ($preview) translate([0,0,-Overlap]) cube([100,100,100]);
	} // difference
	
} // R65_DrogueCoupler

// R65_DrogueCoupler();

module R65_MotorNutStop(MT_ID=ULine38Body_ID, Hole_d=6.35){
	Len=20;
	
	difference(){
		cylinder(d=MT_ID, h=Len);
		
		translate([0,0,-Overlap]) cylinder(d=Hole_d+IDXtra*2, h=Len+Overlap*2);
		translate([0,0,Len-5]) cylinder(d1=Hole_d+IDXtra*2, d2=MT_ID-3, h=5+Overlap);
	} // difference
} // R65_MotorNutStop

// R65_MotorNutStop();

module R65_FwdSpringEnd(OD=LOC65Coupler_OD, ID=LOC65Coupler_ID, LockPin_d=16, nRopes=0, Skirt_h=25, HasServoConnector=false){
// This locks onto the bottom of the petals.
	CR_t=2;
	Rope_d=3;
	Spring_OD=SE_Spring_CS4323_OD();
	Spring_ID=SE_Spring_CS4323_ID();

	Petal_ID=OD-3.5; // should fit loose
	PetalLock_ID=OD-7.5; // Should not touch at all
	ShockCord_Y=Spring_ID/2-2.2-Rope_d/2-1;
	Boss_t=4;
	nVentHoles=5;
	VentHole_d=7;
	VentHole_Y=LockPin_d/2+VentHole_d/2;
	myFn=floor(OD)*3;
	
	difference(){
		union(){
			difference(){
				cylinder(d=OD, h=6, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t-Overlap]) cylinder(d1=ID-4, d2=ID, h=4+Overlap*2, $fn=$preview? 90:myFn);
			} // difference
			
			cylinder(d=LockPin_d, h=Boss_t);
			
			// Skirt
			Tube(OD=OD, ID=ID, Len=Skirt_h, myfn=$preview? 90:myFn);
			
			difference(){
				cylinder(d=OD, h=CR_t+5.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t]) cylinder(d=PetalLock_ID-2.8, h=4.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t+3.5]) cylinder(d1=PetalLock_ID-2.8, d2=ID, h=3.5+Overlap, $fn=$preview? 90:myFn);
			} // difference
			
			// Spring
			Tube(OD=Spring_ID, ID=Spring_ID-4.4, Len=CR_t+4, myfn=$preview? 90:myFn);
			
		} // union
		
		// Servo connector
		if (HasServoConnector) rotate([0,0,30]) translate([0,OD/2-7,-Overlap]) RoundRect(X=11, Y=4, Z=10, R=0.2);
		
		// Center hole
		Thread_d=Thread1024_d;
		Thread_p=25.4/24;
		translate([0,0,-Overlap]) 
			if ($preview){
				cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			}
		
		// Air Vent Holes
		for (j=[0:nVentHoles-1]) rotate([0,0,360/nVentHoles*j]) 
			translate([0,VentHole_Y,-Overlap]) cylinder(d=VentHole_d, h=CR_t+Overlap*2);
		
		// Shock cord
		rotate([0,0,180/nVentHoles]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=30);
		
		// Petal Locks
		difference(){
			translate([0,0,-Overlap]) cylinder(d=OD+1, h=4.5+Overlap*2, $fn=$preview? 90:myFn);
			
			// Puller ring
			translate([0,0,-Overlap*2]) cylinder(d=Petal_ID, h=2+Overlap*3, $fn=$preview? 90:myFn);
			// Petal lock
			translate([0,0,-Overlap*2]) cylinder(d=PetalLock_ID, h=4.5+Overlap*3, $fn=$preview? 90:myFn);
			
		} // difference
		
		// Rope holes
		if (nRopes>0) for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
			translate([0,Spring_OD/2+Rope_d/2+2,-Overlap]) cylinder(d=Rope_d, h=CR_t+Overlap*2);
			
		//if ($preview) translate([0,0,-Overlap]) cube([100,100,100]);
	} // difference
	
} // R65_FwdSpringEnd

//R65_FwdSpringEnd();

module R65_SpringSliderLight(OD=LOC65Coupler_OD, Len=35){
	Wall_t=1.2;
	nSpokes=6;
	SpringStop_Z=15;
	Spring_OD=SE_Spring_CS4323_OD();
	Spring_ID=SE_Spring_CS4323_ID();
	Taper_d=1;
	
	// Outside
	Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 90:180);
	
	// Inside
	difference(){
		union(){
			// Spokes
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j])
				hull(){
					translate([0,OD/2-Wall_t/2,0]) cylinder(d=Wall_t, h=Len);
					translate([0,Spring_OD/2+Wall_t/2,0]) cylinder(d=Wall_t, h=Len);
				} // hull
			
			translate([0,0,SpringStop_Z+8]) cylinder(d2=Spring_OD+Taper_d+Wall_t*2, d1=Spring_OD+Wall_t*2, h=Len-SpringStop_Z-8);
			translate([0,0,SpringStop_Z-5-Overlap]) cylinder(d=Spring_OD+Wall_t*2, h=13+Overlap*2);
			cylinder(d1=Spring_OD+Taper_d+Wall_t*2, d2=Spring_OD+Wall_t*2, h=SpringStop_Z-5);
		} // union
	
		translate([0,0,SpringStop_Z+8]) cylinder(d2=Spring_OD+Taper_d, d1=Spring_OD, h=Len-SpringStop_Z-8+Overlap);
		translate([0,0,SpringStop_Z+3]) cylinder(d=Spring_OD, h=6);
		cylinder(d=Spring_ID-1, h=Len);
		cylinder(d=Spring_OD, h=SpringStop_Z);
		translate([0,0,-Overlap]) cylinder(d1=Spring_OD+Taper_d, d2=Spring_OD, h=SpringStop_Z-5+Overlap);
	} // difference
} // R65_SpringSliderLight

// R65_SpringSliderLight();


module R65_MotorTubeTopper(OD=LOC65Body_ID, ID=LOC29Body_OD, MT_ID=LOC29Body_ID-3){
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
} // R65_MotorTubeTopper

// rotate([180,0,0]) R65_MotorTubeTopper();
































