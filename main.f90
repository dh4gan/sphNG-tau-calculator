program sph_tau_calculator
! Written 9/1/18 by dh4gan
! Code reads in an sphNG file, and then computes optical depth (Av)
! from all SPH particles to all sinks

use sphdata,only:nfiles, write_tracer
use treedata, only:use_neighbourlist
implicit none

logical :: skipdump, first
integer :: ifile, listID, tracerID

! Read in parameters, data and set up run

call initial

if(write_tracer.eqv..true.) then
   tracerID = 11
   listID = 99
   first = .true.
   ! Open List file for writing complete list
   OPEN(listID,file='tracerfiles.list', form='formatted')
endif

do ifile=1,nfiles

     ! *********************
     ! 1. Read in data file
     ! *********************

     call read_dump(ifile,skipdump)

     if(skipdump.eqv..true.) cycle
    
     ! Compute opacities etc for this dump
     call eos

     ! If neighbour lists are needed, get them
     if(use_neighbourlist) call get_SPH_neighbours(ifile)

     ! Compute optical depths

     call compute_optical_depths

     ! Write SPH data to binary

     if(write_tracer.eqv..true.)then

        first = .false.
        if(ifile==1) first=.true.
        call write_to_tracer_files(tracerID,listID,first)        
     else
        call write_binary(ifile)
     endif

     ! Deallocate memory ready for the next file
     call deallocate_memory

  enddo

end program sph_tau_calculator

