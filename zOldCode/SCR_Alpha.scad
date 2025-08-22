// ********************************************************************
//  ***** Small Cable Release *****
// ********************************************************************
// Partial design, doesn't work
// ****************************
//  ***** for STL output *****
//
// rotate([180,0,0]) 	SCR_Housing(ShowCut=false);
// 						SCR_BallCup(ShowLocked=true, ShowCut=false);
// rotate([180,0,0]) 	SCR_LockPin(Len=12);
// 						SCR_EndStop(ShowCut=false);
// rotate([180,0,0]) 	SCR_ServoMount();
// 						SCR_Screw();
//
// ****************************

SCR_Ball_d=5/16*25.4;
SCR_Lock_d=12.7;
SCR_nBalls=3;
SCR_LooseFit=IDXtra*4;
SCR_Body_OD=BT38Coupler_OD;

module SCR_Show_All(ShowLocked=true){
	SCR_BallCup(ShowLocked=ShowLocked, ShowCut=true);
	SCR_LockPin();
	SCR_ShowMyBalls(ShowLocked=ShowLocked);
	SCR_Housing(ShowCut=true);
	SCR_EndStop(ShowCut=true);
} // SCR_Show_All

// SCR_Show_All(ShowLocked=true);
// SCR_Show_All(ShowLocked=false);



module SCR_Screw(){
	D=17;
	H=2.5;
	Steps=28;
	Step_a=90/Steps;
	nRamps=3;
	Wheel_h=6;
	Wheel_Slot_h=4;
	
	for (k=[0:nRamps-1]) rotate([0,0,360/nRamps*k])
	
	for (j=[1:Steps]) hull(){
		rotate([0,0,Step_a*j]){
			translate([0,D/2-2,0]) cylinder(d=1, h=H/Steps*j);
			translate([0,D/2,0]) cylinder(d=1, h=H/Steps*j);
		}
		rotate([0,0,Step_a*(j+1)]) {
			translate([0,D/2-2,0]) cylinder(d=1, h=H/Steps*(j+1));
			translate([0,D/2,0]) cylinder(d=1, h=H/Steps*(j+1));
		}
	}
	
	CrossBar_d=3.8;
	CrossBar_Len=16.5-CrossBar_d;
	
	CrossBar2_d1=7;
	CrossBar2_d2=4.2;
	CrossBar2_Len=16.5;
	
	CrossBar3_d1=6;
	CrossBar3_d2=4.2;
	CrossBar3_Len=13.5;
	
	// Servo wheel
	translate([0,0,-Wheel_h+Overlap]) 
	difference(){
		cylinder(d=D+1,h=Wheel_h);
		
		translate([0,0,-Overlap]) cylinder(d=7, h=Wheel_h+Overlap*2);
		
		hull(){
			translate([0,-CrossBar_Len,-Overlap]) cylinder(d=CrossBar_d, h=Wheel_Slot_h);
			translate([0,CrossBar_Len,-Overlap]) cylinder(d=CrossBar_d, h=Wheel_Slot_h);
		} // hull
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=CrossBar2_d1, h=Wheel_Slot_h);
			translate([CrossBar2_Len,0,-Overlap]) cylinder(d=CrossBar2_d2, h=Wheel_Slot_h);
		} // hull
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=CrossBar3_d1, h=Wheel_Slot_h);
			translate([-CrossBar3_Len,0,-Overlap]) cylinder(d=CrossBar3_d2, h=Wheel_Slot_h);
		} // hull
		
	} // difference

} // SCR_Screw

// SCR_Screw();

module SCR_ServoMount(){
	// Mount for SG90 (MS18)
	Base_Z=-35.2;
	nBolts=3;
	Bolt_Y=(SCR_Body_OD-4.4)/2-4;
	
		Servo_w=12.7;
		Servo_l=23;
		ServoOffset=5.25;
		ServoEar_l=33;
		ServoEar_z=13.5;
		Servo_BC_d=28;
	
	module Servo(){
		
		translate([-Servo_w/2,-Servo_l/2+ServoOffset,0]) mirror([0,0,1]) cube([Servo_w,Servo_l,20]);
		translate([-Servo_w/2,-ServoEar_l/2+ServoOffset,-ServoEar_z]) mirror([0,0,1]) cube([Servo_w,ServoEar_l,20]);
		translate([0,-Servo_BC_d/2+ServoOffset,-ServoEar_z]) rotate([180,0,0]) Bolt2Hole();
		translate([0,Servo_BC_d/2+ServoOffset,-ServoEar_z]) rotate([180,0,0]) Bolt2Hole();
		
	} // Servo
	//translate([0,0,Base_Z]) Servo();
	
	module ServoMount(){
		Wall_t=2.2;
		
		intersection(){
			translate([0,0,-15]) cylinder(d=SCR_Body_OD, h=20);
			
			difference(){
				hull(){
					translate([-Servo_w/2-Wall_t,-ServoEar_l/2+ServoOffset-Wall_t,-5]) 
						mirror([0,0,1]) cube([Servo_w+Wall_t*2,ServoEar_l+Wall_t*2,4]);
						
					cylinder(d=SCR_Body_OD, h=1);
				} // hull
				
				translate([0,0,2]) Servo();
				for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bolt_Y,0]) rotate([180,0,0]) Bolt4HeadHole();
				
				
				translate([0,0,-2-Overlap]) cylinder(d1=SCR_Body_OD-12, d2=SCR_Body_OD-8.8, h=3+Overlap*2);
			} // difference
		} // intersection
	} // ServoMount
	
	translate([0,0,Base_Z]) ServoMount();
	
	difference(){
		translate([0,0,Base_Z]) cylinder(d=SCR_Body_OD, h=5);
			
		
		translate([0,0,Base_Z-Overlap]) cylinder(d=SCR_Body_OD-8.8, h=5+Overlap*2);
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bolt_Y,Base_Z]) rotate([180,0,0]) Bolt4HeadHole();
	} // difference
	
	difference(){
		intersection(){
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bolt_Y,Base_Z]) hull(){
				cylinder(d=8, h=5);
				translate([0,2,0]) cylinder(d=10, h=5);
			} // hull
			
			translate([0,0,Base_Z]) cylinder(d=SCR_Body_OD-4.4, h=5);
		} // intersection
	
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bolt_Y,Base_Z]) rotate([180,0,0]) Bolt4HeadHole();
		
		translate([0,0,Base_Z-Overlap]) cylinder(d=20, h=6);
	} // difference

	
} // SCR_ServoMount

// SCR_ServoMount();

module SCR_EndStop(ShowCut=false){
	Base_Z=-30.1;
	H=9;
	nBolts=3;
	Bolt_Y=(SCR_Body_OD-4.4)/2-4;
	nLocks=5;
	
	difference(){
		union(){
			translate([0,0,Base_Z]) cylinder(d=SCR_Body_OD, h=2);
			translate([0,0,Base_Z]) cylinder(d=SCR_Body_OD-4.4, h=H);
			
			// Twist lock
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0,(SCR_Body_OD-4.4)/2-0.5,Base_Z+5]) sphere(d=2);
		} // union
		
		translate([0,0,Base_Z-Overlap]) cylinder(d=SCR_Body_OD-8.8, h=H+Overlap*2);
	} // difference
	
	difference(){
		intersection(){
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bolt_Y,Base_Z]) hull(){
				cylinder(d=8, h=5);
				translate([0,2,0]) cylinder(d=10, h=5);
			} // hull
			
			translate([0,0,Base_Z]) cylinder(d=SCR_Body_OD-4.4, h=5);
		} // intersection
	
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bolt_Y,Base_Z+5]) Bolt4Hole();
		
		translate([0,0,Base_Z-Overlap]) cylinder(d=20, h=6);
	} // difference

} // SCR_EndStop

// SCR_EndStop();

module SCR_Housing(ShowCut=false){
	nLocks=5;
	Locked_ID=SCR_Lock_d+SCR_Ball_d*0.6+SCR_Ball_d+IDXtra;
	
	// Stop Ring
	difference(){
		translate([0,0,SCR_Ball_d/2+0.2]) cylinder(d=SCR_Lock_d+SCR_Ball_d+SCR_Ball_d/2, h=5);
		
		translate([0,0,SCR_Ball_d/2+0.2-Overlap]) cylinder(d=SCR_Lock_d+SCR_LooseFit, h=5+Overlap*2);
		
		if (ShowCut) translate([0,0,-25]) cube([50,50,50]);
	} // difference
	
	// ball retainer
	difference(){
		union(){
			translate([0,0,-SCR_Ball_d/2-2]) cylinder(d=SCR_Lock_d+SCR_LooseFit+3, h=SCR_Ball_d*1.5);
			
			intersection(){
				translate([0,0,-SCR_Ball_d/2-2]) cylinder(d=Locked_ID-1, h=SCR_Ball_d*1.5);
			
				// ball walls
				translate([0,0,-SCR_Ball_d/2+1]) for (j=[0:SCR_nBalls-1]) rotate([0,0,360/SCR_nBalls*j]) {
					translate([SCR_Ball_d/2+0.5,5,0]) cube([1.2,10,SCR_Ball_d*1.5]);
					translate([-SCR_Ball_d/2-0.5-1.2,5,0]) cube([1.2,10,SCR_Ball_d*1.5]);
					}
					
			} // intersection
		} // union
		
		translate([0,0,-SCR_Ball_d-Overlap]) cylinder(d=SCR_Lock_d+SCR_LooseFit, h=SCR_Ball_d*2+Overlap*2);
		
		Ball_Offset=SCR_Ball_d*0.3;
	
		for (j=[0:SCR_nBalls-1]) rotate([0,0,360/SCR_nBalls*j]) 
			translate([0,SCR_Lock_d/2+Ball_Offset,0]) hull(){
				translate([0,0,0.5]) sphere(d=SCR_Ball_d+IDXtra);
				translate([0,0,-0.5]) sphere(d=SCR_Ball_d+IDXtra);
			}
		
		if (ShowCut) translate([0,0,-25]) cube([50,50,50]);
	} // difference
	
	// top
	difference(){
		cylinder(d=SCR_Body_OD, h=SCR_Ball_d+5);
		
		translate([0,0,-Overlap]) cylinder(d=SCR_Body_OD-4.4, h=9);
		translate([0,0,-Overlap]) cylinder(d=SCR_Lock_d+SCR_LooseFit, h=SCR_Ball_d+5+Overlap*2);
		
		if (ShowCut) translate([0,0,-25]) cube([50,50,50]);
	} // difference
	
	Skirt_Len=28;
	// skirt
	difference(){
		translate([0,0,-Skirt_Len]) cylinder(d=SCR_Body_OD, h=Skirt_Len+Overlap);
		
		translate([0,0,-Skirt_Len-Overlap]) cylinder(d=SCR_Body_OD-4.4, h=Skirt_Len+Overlap*3);
		
		// Twist lock
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]){
			hull(){
				translate([0,(SCR_Body_OD-4.4)/2-0.3,-Skirt_Len+3]) sphere(d=2);
				translate([0,(SCR_Body_OD-4.4)/2-0.3,-Skirt_Len]) sphere(d=2);
			} // hull
			
			for (k=[0:4])
			hull(){
				rotate([0,0,k*2]) translate([0,(SCR_Body_OD-4.4)/2-0.3,-Skirt_Len+3]) sphere(d=2);
				
				rotate([0,0,(k+1)*2]) translate([0,(SCR_Body_OD-4.4)/2-0.3,-Skirt_Len+3]) sphere(d=2);
			} // hull
		}
			
		if (ShowCut) translate([0,0,-25]) cube([50,50,50]);
	} // difference
	
} // SCR_Housing

// SCR_Housing(ShowCut=true);

module SCR_BallCup(ShowLocked=true, ShowCut=false){
	Locked_ID=SCR_Lock_d+SCR_Ball_d*0.6+SCR_Ball_d+IDXtra;
	UnLocked_ID=SCR_Lock_d+SCR_Ball_d*2+1;
	Wall_t=4;
	Position_Z=ShowLocked? 0:6;
	nBolts=3;
	Len=9+SCR_Ball_d*1.5; // below center
	Spring_d=7.65+IDXtra*2;
	
	translate([0,0,Position_Z])
	difference(){
		union(){
			translate([0,0,-2]) cylinder(d=Locked_ID+Wall_t*2, h=SCR_Ball_d+2, center=true);
			
			translate([0,0,-Len]) cylinder(d=Locked_ID+Wall_t*2, h=Len+Overlap);
		} // union
		
		cylinder(d=Locked_ID, h=SCR_Ball_d*2+Overlap, center=true);
		
		// Lower chamfer
		translate([0,0,-4]) cylinder(d2=Locked_ID, d1=UnLocked_ID, h=3);
		// Upper chamfer
		translate([0,0,1]) cylinder(d1=Locked_ID, d2=UnLocked_ID, h=2+Overlap);
		
		translate([0,0,-8]) cylinder(d=UnLocked_ID, h=4+Overlap);
		translate([0,0,-SCR_Ball_d-2]) cylinder(d=UnLocked_ID, h=4);
		
		// Spring
		translate([0,0,-Len-Overlap]) cylinder(d=Spring_d, h=18);
		
		translate([0,0,-SCR_Ball_d*2-1]) cylinder(d=SCR_Lock_d+SCR_LooseFit, h=SCR_Ball_d*2);
		
		// cut out for ball retainer
		translate([0,0,-SCR_Ball_d*1.6]) cylinder(d=SCR_Lock_d+4.4, h=6);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Locked_ID/2-2,-Len])
			rotate([180,0,0]) Bolt4Hole(depth=9);
		
		if (ShowCut) translate([0,0,-25]) cube([50,50,50]);
	} // difference
	
	// #cylinder(d=Body_ID, h=1);
} // SCR_BallCup

// SCR_BallCup(ShowLocked=true, ShowCut=true);
// SCR_BallCup(ShowLocked=false, ShowCut=true);


module SCR_LockPin(Len=20){

	difference(){
		union(){
			translate([0,0,-SCR_Ball_d-2]) cylinder(d1=SCR_Lock_d/2, d2=SCR_Lock_d, h=SCR_Ball_d/2+Overlap);
			translate([0,0,-SCR_Ball_d/2-2]) cylinder(d=SCR_Lock_d, h=SCR_Ball_d+Len);
		} // union
		
		// ball groove
		rotate_extrude() translate([SCR_Lock_d/2+SCR_Ball_d*0.3,0,0]) circle(d=SCR_Ball_d+IDXtra);
		
		// bolt hole
		translate([0,0,SCR_Ball_d+Len]) Bolt10Hole(depth=SCR_Ball_d*3+Len+1);
	} // difference

} // SCR_LockPin

// SCR_LockPin();

module SCR_ShowMyBalls(ShowLocked=true){
	Ball_Offset=ShowLocked? SCR_Ball_d*0.3:SCR_Ball_d*0.55;
	
	for (j=[0:SCR_nBalls-1]) rotate([0,0,360/SCR_nBalls*j]) 
		translate([0,SCR_Lock_d/2+Ball_Offset,0]) color("White") sphere(d=SCR_Ball_d);
} // SCR_ShowMyBalls

// SCR_ShowMyBalls(ShowLocked=true);

// SCR_ShowMyBalls(ShowLocked=false);





