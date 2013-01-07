

OVERALL_LENGTH = 30;
POINT_LENGTH = 10;
POINT_SPINE_ANGLE = 20;

/*
OVERALL_LENGTH = 20;
POINT_LENGTH = 10;
POINT_SPINE_ANGLE = 20;
*/
/*
OVERALL_LENGTH = 10;
POINT_LENGTH = 5;
POINT_SPINE_ANGLE = 30;
*/

WIDTH = 5;
THICKNESS = 1;
SPINE_HEIGHT = 3;
DETAIL = 20;

module point()
{
    linear_extrude(height = THICKNESS, center = false, convexity = 3, twist = 0, slices = DETAIL)
        polygon(points=[[WIDTH / -2, 0],[WIDTH / 2, 0],[0, POINT_LENGTH]]);
}

module body()
{
    union()
    {
        // Point    
        translate(v = [0, OVERALL_LENGTH - POINT_LENGTH, 0])
            point();
        // Main body
        translate(v = [WIDTH / -2, 0, 0])
            cube(size = [WIDTH, OVERALL_LENGTH - POINT_LENGTH, THICKNESS]);
        // Spine
        translate(v = [THICKNESS / -2, 0, 0])
            cube(size = [THICKNESS, OVERALL_LENGTH, SPINE_HEIGHT]);
    }
}

difference()
{
    body();
    translate(v = [-15, OVERALL_LENGTH, 0])
        rotate(a = [90 - POINT_SPINE_ANGLE, 0, 0])
            cube(size = [30, 30, 30]);
}