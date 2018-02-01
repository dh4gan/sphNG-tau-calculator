subroutine raylist_brute(ipart,iptmass,n,tmax)
!********************************************
! Given a particle, ray vector and maximum distance
! subroutine creates a list of all particles intersected
! by ray 
! This subroutine is a brute force calculation O(N^2)
!*******************************************

use sphdata
use treedata

implicit none

integer, intent(in) :: ipart,iptmass
real,intent(in) :: tmax
real,dimension(3),intent(in) :: n

integer :: jpart,k
real :: t_try

nray = 0

do jpart=1,npart

   if(jpart==ipart .or.jpart==listpm(iptmass)) cycle ! Ignore self and sink
   
 ! Calculate t_min

        t_try = 0.0

        do k=1,3
           t_try = t_try + n(k)*(xyzmh(k,jpart)-xyzmh(k,ipart))
        enddo

        ! t must be less than tmax, otherwise goes past sink
        if(t_try>tmax) cycle

        ! Calculate b - impact parameter with ray

        b(jpart) = 0.0

        do k=1,3
           b(jpart) = b(jpart) + &
                (xyzmh(k,ipart) + t_try*n(k) - xyzmh(k,jpart))**2
        enddo

        b(jpart) = SQRT(b(jpart))

        t_sphere(jpart) = 2.0d0*SQRT(4.0d0*xyzmh(5,jpart)**2 - b(jpart)*b(jpart))

        ! If t -ve and sufficiently distant, jpart is behind ray 
        ! should not be counted
        if(t_try<0.0d0 .and. ABS(t_try)>0.5*t_sphere(jpart)) cycle

        ! If b < 2*h_i, then add to list

        if(b(jpart) < 2.0*xyzmh(5,jpart)) then

           ! Add particle to raylist
           nray = nray +1
           ray(nray) = jpart
           t_min(nray) = t_try
        endif

     enddo
    ! End of loop over jpart

end subroutine raylist_brute
