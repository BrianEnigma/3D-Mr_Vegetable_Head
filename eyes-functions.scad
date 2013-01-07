

PEG_NEGATIVE_LENGTH = 5;
PEG_WIDTH = 5;
PEG_THICKNESS = 1;
PEG_SPINE_HEIGHT = 3;
TOLERANCE = 0.7;
DETAIL = 100;

EYE_DIAMETER = 30;
EYE_OFFSET = 10;
PUPIL_DIAMETER = 15;
IRIS_DIAMETER = 4;

module peg_negative()
{
    // Main body
    translate(v = [(PEG_WIDTH + TOLERANCE) / -2, 0, 0])
        cube(size = [PEG_WIDTH + TOLERANCE, PEG_NEGATIVE_LENGTH + 1, PEG_THICKNESS + TOLERANCE]);
    // Spine
    translate(v = [PEG_THICKNESS / -2, 0, 0])
        cube(size = [PEG_THICKNESS, PEG_NEGATIVE_LENGTH + 1, PEG_SPINE_HEIGHT]);
    
}

module peg_negatives()
{
    translate(v = [0, 0, -1])
        rotate(a = [90, 0, 180])
            peg_negative();
}

module eyeballs()
{
    union()
    {
        // Eyeballs
        difference()
        {
            union()
            {
                translate(v = [EYE_OFFSET, 0, 0])
                    sphere(r = EYE_DIAMETER / 2, $fn = DETAIL);
                translate(v = [-1 * EYE_OFFSET, 0, 0])
                    sphere(r = EYE_DIAMETER / 2, $fn = DETAIL);
            }
            translate(v = [EYE_OFFSET, 0, EYE_DIAMETER / 2 - 5])
                cylinder(r = PUPIL_DIAMETER / 2, h = 20, $fn = DETAIL);
            translate(v = [-1 * EYE_OFFSET, 0, EYE_DIAMETER / 2 - 5])
                cylinder(r = PUPIL_DIAMETER / 2, h = 20, $fn = DETAIL);
        }
        // Pupils, Irises
        difference()
        {
            translate(v = [EYE_OFFSET, 0, -1.5])
                sphere (r = EYE_DIAMETER / 2, $fn = DETAIL);
            translate(v = [EYE_OFFSET, 0, EYE_DIAMETER / 2 - 1])
                sphere (r = IRIS_DIAMETER / 2, $fn = DETAIL);
        }
        difference()
        {
            translate(v = [-1 * EYE_OFFSET, 0, -1.5])
                sphere (r = EYE_DIAMETER / 2, $fn = DETAIL);
            translate(v = [-1 * EYE_OFFSET, 0, EYE_DIAMETER / 2 - 1])
                sphere (r = IRIS_DIAMETER / 2, $fn = DETAIL);
        }
    }


}

module eyes()
{
    difference()
    {
        eyeballs();
        translate(v = [-50, -50, -100])
            cube(size = [100, 100, 100]);
        peg_negatives();
    }
}
