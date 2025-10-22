// ***********************************
// Project: 3D Printed Rocket
// Filename: R65Lib.scad
// by David M. Flynn
// Created: 10/21/2025 
// Revision: 0.9.0  10/21/2025 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of parts for 65mm rockets.
//
//  ***** History *****
//
// 0.9.0  10/21/2025 First code, copied from Rocket6551
//
// ***********************************
//  ***** for STL output *****
//
// R65_NoseCone(Shoulder_OD=LOC65Coupler_OD, OD=LOC65Body_OD, nBolts=6, NC_Len=150, NC_Base_L=6, NC_Tip_R=3, NC_Wall_t=1.2);
// R65_PetalHub(OD=LOC65Coupler_OD, nPetals=3, nBolts=6, Skirt_h=5, HasWirePath=false);
/*
R65_DrogueCoupler(OD=LOC65Body_ID, Coupler_ID=LOC65Coupler_ID, 
			Thread_d=Thread25020_d, Thread_p=Thread25020_Pitch, LockPin_d=16,
			nRopes=0, Skirt_h=25, HasTubeStop=false, Body_OD=LOC65Body_OD, HasWirePath=false, HasStiffCore=false);
/**/
// R65_MotorNutStop(MT_ID=ULine38Body_ID, Hole_d=6.35);
// R65_FwdSpringEnd(OD=LOC65Coupler_OD, ID=LOC65Coupler_ID, LockPin_d=16, nRopes=0, Skirt_h=25, HasServoConnector=false);
// R65_SpringSliderLight(OD=LOC65Coupler_OD, Len=35);
//
// ***********************************
include<TubesLib.scad>
use<SpringThingBooster.scad>	echo(SpringThingBoosterRev());
use<PetalDeploymentLib.scad>	echo(PetalDeploymentLibRev());
use<SpringEndsLib.scad>			echo(SpringEndsLibRev());
use<NoseCone.scad>				echo(NoseConeRev());
use<ThreadLib.scad>         	echo(ThreadLibRev());

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

Thread1024_d=0.190*25.4;
Thread25020_d=0.250*25.4;
Thread25020_Pitch=25.4/20;
Bolt10Inset=5.5;

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
		hull(){
			translate([0,-OD/2+5,-Skirt_h-Overlap]) cylinder(d=3.5, h=Skirt_h+20);
			translate([0,-OD/2+13,-Skirt_h-Overlap]) cylinder(d=3.5, h=Skirt_h+20);
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


































