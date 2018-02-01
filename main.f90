program sph_tau_calculator
! Written 9/1/18 by dh4gan
! Code reads in an sphNG file, and then computes optical depth (Av)
! from all SPH particles to all sinks

use sphdata,only:nfiles
implicit none

logical :: skipdump
integer :: ifile

! Read in parameters, data and set up run

call initial

do ifile=1,nfiles

     ! *********************
     ! 1. Read in data file
     ! *********************

     call read_dump(ifile,skipdump)

     if(skipdump.eqv..true.) cycle
    
     ! Compute opacities etc for this dump
     call eos

     ! If neighbour lists are needed, get them
     call get_SPH_neighbours(ifile)

     ! Compute optical depths

     call compute_optical_depths

     ! Write SPH data to binary

     call write_binary(ifile)

     ! Deallocate memory ready for the next file
     call deallocate_memory

  enddo

end program sph_tau_calculator

