# Computing optical depths in sphNG simulations of star formation #

This FORTRAN 90 repository reads in sphNG simulation data, and computes the optical depth of each SPH particle to 
any pointmass particle.  This can then be used in post-processing of the simulation (for example, to investigate local chemistry).

The code is a repurposing of algorithms first published in:

Forgan & Rice (2010), Monthly Notices of the Royal Astronomical Society, Volume 406, Issue 4, pp. 2549-2558

This code can read both modern sphNG files, as well as the historic sphNG files that I have used for the last twelve years.  I apologise for the lack of user-friendly touches - I haven't had much time to finesse them!

## How it works ##

Optical depths are computed by "backtracing".  A ray is drawn from the SPH particle to the pointmass, and intersections 
between the ray and SPH smoothing volumes are computed.

The impact parameter between the SPH particle and the ray defines the column density of the ray as it 
moves through the SPH particle's smoothing volume.

The optical depth through the smoothing volume is this column density multiplied by the particle's opacity,
which is determined by an equation of state stored in `paramfiles/myeos.dat` 

(details of the equation of state can be found in Forgan et al 2009, Monthly Notices of the Royal Astronomical Society, Volume 394, Issue 2, pp. 882-891)


## Compilation and Execution ##

This code was developed and tested on gfortran 8.2.0, and compiled with standard Makefile software.

The code is compiled using `src/Makefile` contained within the repo, i.e. to compile
`> cd src/`

`> make`

Which produces the `sph_tau_calculator` executable.  The code is then run with the command

`> ./sph_tau_calculator `

The code will attempt to read `myeos.dat`, and `sph_tau_calculator.params`, both of which must reside in the same directory.  
Both can be found in the `paramfiles/` directory.  The code will also read in a list of sphNG simulations from file (one sphNG file per line).  Said file is to be specified by the user in `sph_tau_calculator.params`.

## Outputs ##

The code can produce two types of output:

1) One tracer file per particle (t), to easily plot particle properties vs time

2) Snapshot files (s), where all particle data at a single timestep is recorded
  
