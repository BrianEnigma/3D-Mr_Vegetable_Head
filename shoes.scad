

PEG_NEGATIVE_LENGTH = 5;
PEG_WIDTH = 5;
PEG_THICKNESS = 1;
PEG_SPINE_HEIGHT = 3;
TOLERANCE = 0.3;
DETAIL = 100;

module peg_negative()
{
    // Main body
    translate(v = [(PEG_WIDTH + TOLERANCE * 2) / -2, 0, 0])
        cube(size = [PEG_WIDTH + TOLERANCE * 2, PEG_NEGATIVE_LENGTH + 1, PEG_THICKNESS + TOLERANCE * 2]);
    // Spine
    translate(v = [(PEG_THICKNESS + TOLERANCE * 2) / -2, 0, 0])
        cube(size = [PEG_THICKNESS + TOLERANCE * 2, PEG_NEGATIVE_LENGTH + 1, PEG_SPINE_HEIGHT + TOLERANCE]);
    
}

module shoes()
{
    difference()
    {
        // Two shoes, made from spheres
        union()
        {
            translate(v = [10, 0, 0])
                scale(v = [0.5, 1, 0.7])
                    sphere(r = 30, $fn = DETAIL);
            translate(v = [-10, 0, 0])
                scale(v = [0.5, 1, 0.7])
                    sphere(r = 30, $fn = DETAIL);
        }
        // "Below the ground"
        translate(v = [-50, -50, -100])
            cube(size = [100, 100, 100]);
        translate(v = [0, 8, 30])
            rotate(a = [0, 0, 90])
                scale(v = [0.5, 1, 0.7])
                    sphere(r = 30, $fn = DETAIL);
    }
}

difference()
{
    shoes();
    translate(v = [0, 9, 3.5])
        rotate(a = [90, 0, 0])
            peg_negative();
}