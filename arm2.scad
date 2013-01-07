PEG_OVERALL_LENGTH = 30;
PEG_POINT_LENGTH = 10;
PEG_POINT_SPINE_ANGLE = 20;
PEG_WIDTH = 5;
PEG_THICKNESS = 1;
PEG_SPINE_HEIGHT = 3;

ARM_DIAMETER = 8;
ELBOW_DIAMETER = 10;
HAND_DIAMETER = 18;
FINGER_DIAMETER = 2;

DETAIL = 20;

module point()
{
    linear_extrude(height = PEG_THICKNESS, center = false, convexity = 3, twist = 0, slices = DETAIL)
        polygon(points=[[PEG_WIDTH / -2, 0],[PEG_WIDTH / 2, 0],[0, PEG_POINT_LENGTH]]);
}

module body()
{
    union()
    {
        // Point    
        translate(v = [0, PEG_OVERALL_LENGTH - PEG_POINT_LENGTH, 0])
            point();
        // Main body
        translate(v = [PEG_WIDTH / -2, 0, 0])
            cube(size = [PEG_WIDTH, PEG_OVERALL_LENGTH - PEG_POINT_LENGTH, PEG_THICKNESS]);
        // Spine
        translate(v = [PEG_THICKNESS / -2, 0, 0])
            cube(size = [PEG_THICKNESS, PEG_OVERALL_LENGTH, PEG_SPINE_HEIGHT]);
    }
}

module peg()
{
    difference()
    {
        body();
        translate(v = [-15, PEG_OVERALL_LENGTH, 0])
            rotate(a = [90 - PEG_POINT_SPINE_ANGLE, 0, 0])
                cube(size = [30, 30, 30]);
    }
}

module flat_stick(length)
{
    union()
    {
        translate(v = [0, 0, ARM_DIAMETER / 2])
            rotate(a = [-90, 0, 0])
                cylinder(r = ARM_DIAMETER / 2, h = length, $fn = DETAIL);
        translate(v = [ARM_DIAMETER / -2, 0, 0])
            cube(size = [ARM_DIAMETER, length, ARM_DIAMETER / 2]);
    }    
}

module hand()
{
    difference()
    {
        union()
        {
            // Palm
            sphere(r = HAND_DIAMETER / 2, $fn = DETAIL);
            // Fingers
            rotate(a = [90, 0, 200])
                cylinder(r = FINGER_DIAMETER / 2, h = ARM_DIAMETER / 2 + 10, $fn = DETAIL);
            rotate(a = [90, 0, 230])
                cylinder(r = FINGER_DIAMETER / 2, h = ARM_DIAMETER / 2 + 10, $fn = DETAIL);
            rotate(a = [90, 0, 260])
                cylinder(r = FINGER_DIAMETER / 2, h = ARM_DIAMETER / 2 + 10, $fn = DETAIL);
            rotate(a = [90, 0, 290])
                cylinder(r = FINGER_DIAMETER / 2, h = ARM_DIAMETER / 2 + 10, $fn = DETAIL);
        }
        translate(v = [-15, -15, -30])
            cube(size = [30, 30, 30]);
    }
}

union()
{
    // Peg
    rotate(a = [0, 0, 180])
        peg();
    // Upper arm
    translate(v = [0, -10, 0])
        flat_stick(50);
    // Elbow
    translate(v = [0, 40, 0])
        cylinder(r = ELBOW_DIAMETER / 2, h = ARM_DIAMETER, $fn = DETAIL);
    // Lower arm
    translate(v = [0, 40, 0])
        rotate(a = [0, 0, -100])
            flat_stick(50);
    translate(v = [53, 31, 0])
        rotate(a = [0, 0, 210])
            hand();
}
