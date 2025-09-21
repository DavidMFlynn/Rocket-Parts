// *****************************************
// ISO Thread Library
// Filename: ThreadLib.scad
// by David M. Flynn
// License: MIT
// Creaded: 11/22/2019
// Revision: 0.9.1 6/16/2022
// Units:mm
// *****************************************
//  ***** History *****
//
function ThreadLibRev()="ThreadLib 0.9.1";
echo(ThreadLibRev());
//
// 0.9.1 6/16/2022 Bug fix
// 0.9.0 11/22/2019 First code
//
// *****************************************
//  ***** Routines *****
// ExternalThread_Triangle(Pitch=1);
// ExternalThread_OneRotation(Pitch=1,Dia_Nominal=6,Step_a=20);
// ExternalThread(Pitch=1, Dia_Nominal=6, Length=5, Step_a=20, TrimEnd=true, TrimRoot=false);
// HexHead(WrenchSize=11);
// *****************************************
//  ***** for STL output *****
//
// HexHead(WrenchSize=12.7); ExternalThread(Pitch=25.4/18,Dia_Nominal=5/16*25.4,Length=7,Step_a=$preview? 20:5,TrimEnd=true,TrimRoot=false); // 5/16-18
//
// *****************************************

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

module ExternalThread_Triangle(Pitch=1) {
	//H=0.8660254*Pitch; // 30° Thread height, peak to peak
	H = 0.5*Pitch; // 45°
	
	polyhedron(points=[[-H/8,-0.001,-Pitch/16],[-H,-0.001,-Pitch/2],[-H,-0.001,Pitch/2],[-H/8,-0.001,Pitch/16],
		[-H/8,0.001,-Pitch/16],[-H,0.001,-Pitch/2],[-H,0.001,Pitch/2],[-H/8,0.001,Pitch/16]],
		faces=[[0,1,2,3],[7,6,5,4],[1,5,6,2],[0,3,7,4],[2,6,7,3],[1,5,4,0]]);
	
} // ExternalThread_Triangle

//ExternalThread_Triangle(Pitch=1.27);

module ExternalThread_OneRotation(Pitch=1,Dia_Nominal=6,Step_a=20) {
	//H = 0.8660254*Pitch;
	H = 0.5*Pitch;
	D_min = Dia_Nominal - H*2 + H/4;

	for(i=[0:Step_a:360-Step_a]) hull(){
		rotate([0,0,i])
			translate([Dia_Nominal/2,0,i/360*Pitch])
				ExternalThread_Triangle(Pitch);
		rotate([0,0,i+Step_a])
			translate([Dia_Nominal/2,0,(i+Step_a)/360*Pitch])
				ExternalThread_Triangle(Pitch);
	}

	// Central Shaft
	translate([0,0,Pitch/2])
		cylinder(d=D_min,h=2*Pitch,$fn=360/Step_a,center=true);
} // ExternalThread_OneRotation

//ExternalThread_OneRotation(Pitch=1.27,Dia_Nominal=6.35,Step_a=20);

module ExternalThread(Pitch=1, Dia_Nominal=6, Length=5, Step_a=20, TrimEnd=true, TrimRoot=false){
	// H = 0.8660254*Pitch; // 60°
	H = 0.5*Pitch;
	Dia_min=Dia_Nominal - H*2 + H/2;
	
	intersection(){
		for(i=[-1:Length/Pitch+2]) translate([0,0,i*Pitch])
			ExternalThread_OneRotation(Pitch=Pitch,Dia_Nominal=Dia_Nominal,Step_a=Step_a);
			
		
		union(){
			if (TrimRoot==true){
				cylinder(d1=Dia_min,d2=Dia_Nominal,h=Pitch/3+Overlap);
			} else {
				cylinder(d=Dia_Nominal,h=Pitch/3+Overlap);
			}
			
			translate([0,0,Pitch/3]) cylinder(d=Dia_Nominal,h=Length-Pitch/3*2);
			
			if (TrimEnd==true){
				translate([0,0,Length-Pitch/3-Overlap]) cylinder(d1=Dia_Nominal,d2=Dia_min,h=Pitch/3+Overlap);
			} else {
				translate([0,0,Length-Pitch/3-Overlap]) cylinder(d=Dia_Nominal,h=Pitch/3+Overlap);
			}
		} //union
	} // difference
} // Thread

//ExternalThread(Pitch=1,Dia_Nominal=6,Length=5,Step_a=10); // M6x1.00
//ExternalThread(Pitch=5, Dia_Nominal=36, Length=50, Step_a=20); 
//ExternalThread(Pitch=1.27,Dia_Nominal=6.35,Length=5,Step_a=$preview? 20:5); // 1/4-20
//ExternalThread(Pitch=25.4/18,Dia_Nominal=5/16*25.4,Length=7,Step_a=$preview? 20:5); // 5/16-18
//HexHead(WrenchSize=12.7);

module HexHead(WrenchSize=11){
	Head_h=WrenchSize*0.4;
	Hex_h=Head_h*0.8;
	
	translate([0,0,-Head_h+Overlap])
	intersection(){
		 hull()
			for (j=[0:5]) rotate([0,0,60*j])
				translate([WrenchSize/2*1.144-0.5,0,0]) cylinder(d=1,h=Head_h,$fn=18);
			
		union(){
			translate([0,0,-Overlap]) cylinder(d1=WrenchSize*0.95,d2=WrenchSize*0.95+Head_h,h=Head_h/2+Overlap*2);
			translate([0,0,Head_h+Overlap]) rotate([180,0,0])
				cylinder(d1=WrenchSize*0.95,d2=WrenchSize*0.95+Head_h,h=Head_h/2+Overlap*2);
		}
	}
	
} // HexHead





