SUBROUTINE deallocate_memory
! Subroutine simply deallocates all memory used in loop

use sphdata
use treedata
use eosdata

implicit none

   print*, 'Deallocating Memory'

     deallocate(iphase,isteps,isort)
     if(allocated(iorig)) deallocate(iorig)
     deallocate(xyzmh,vxyzu,rho)	
     deallocate(listpm,spinx,spiny,spinz)
     deallocate(angaddx,angaddy,angaddz)
     deallocate(spinadx,spinady,spinadz)

     ! Deallocate EOS and neighbour memory as well
     if(allocated(gammamuT)) deallocate(gammamuT)
     if(allocated(nneigh)) deallocate(nneigh,neighb)

     if(allocated(dgrav)) deallocate(dgrav)
     if(allocated(alphaMM)) deallocate(alphaMM)
     if(allocated(gradh)) deallocate(gradh)
     if(allocated(gradhsoft)) deallocate(gradhsoft)
     print*, 'SPH memory deallocated'

     if(allocated(tausink)) then
        deallocate(tausink,pathlength,av)
        deallocate(b,t_sphere, t_min,ray)
     endif

     print*, 'Optical depth memory deallocated'


END SUBROUTINE deallocate_memory
