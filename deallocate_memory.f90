SUBROUTINE deallocate_memory
! Subroutine simply deallocates all memory used in loop

use sphdata

implicit none

   print*, 'Deallocating Memory'

     deallocate(iphase,isteps,isort)
     if(allocated(iorig)) deallocate(iorig)
     deallocate(xyzmh,vxyzu,rho)	
     deallocate(listpm,spinx,spiny,spinz)
     deallocate(angaddx,angaddy,angaddz)
     deallocate(spinadx,spinady,spinadz)

     if(allocated(dgrav)) deallocate(dgrav)
     if(allocated(alphaMM)) deallocate(alphaMM)
     if(allocated(gradh)) deallocate(gradh)
     if(allocated(gradhsoft)) deallocate(gradhsoft)

     print*, 'SPH memory deallocated'

     deallocate(tausink,Av)

END SUBROUTINE deallocate_memory
