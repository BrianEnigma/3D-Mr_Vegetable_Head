include <eyes-functions.scad>

rotate(a = [0, 0, 90])
difference()
{
    eyes();
    union()
    {
        translate(v = [EYE_OFFSET, 0, EYE_DIAMETER / 2 - 4])
            cylinder(h = 20, r = PUPIL_DIAMETER / 2 - 0.1, $fn = DETAIL);
        translate(v = [-1 * EYE_OFFSET, 0, EYE_DIAMETER / 2 - 4])
            cylinder(h = 20, r = PUPIL_DIAMETER / 2 - 0.1, $fn = DETAIL);
    }
}
