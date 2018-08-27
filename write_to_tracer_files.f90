subroutine write_to_tracer_files(tracerID,listID, first)
!
! Writes SPH particle data for a given timestep to npart individual files 
! (written on tracerID)
!
! Also writes a list of filenames to listID
!


use sphdata
use eosdata
implicit none

integer, intent(in) :: tracerID,listID
logical, intent(in) :: first

  real, parameter :: pi = 3.141592653
  real, parameter :: twopi = 2.0*pi

integer :: ipart,k,nzeros
character(1) :: zerostring
character(10) :: tracernum
character(30) :: tracerfile, fmt

!***********************************
! 1. Create formatting for filenames
!**********************************


nzeros = int(log10(real(npart))) +2
write(zerostring, '(I1)')nzeros

fmt = "(I"//zerostring//"."//zerostring//")"

!***********************************
! 2. Write Particle Data to Individual Tracer Files
!***********************************
      
do ipart = 1,npart

   if(iphase(ipart)<0) cycle
   write(tracernum,fmt) ipart
   
   tracerfile = "trace."//TRIM(tracernum)
   !print*, TRIM(tracerfile)
   
   ! If this is the first file, then open rather than append the file
   if(first) then
      open(tracerID, file=tracerfile, form="formatted")
      write(listID,*) tracerfile ! Write filename to list file
   else
      open(tracerID, file=tracerfile, form="formatted", position='append')
   endif
   
   write(tracerID,*) ipart, gt/twopi, (xyzmh(k,ipart),k=1,3), &
        pathlength(1,ipart), tausink(1,ipart), Av(1,ipart)
   
   close(11)
enddo

end subroutine write_to_tracer_files
