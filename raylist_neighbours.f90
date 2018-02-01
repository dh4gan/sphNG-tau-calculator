subroutine raylist_neighbours(ipart,iptmass,n,tmax)
!********************************************
! Given a particle, ray vector and maximum distance
! subroutine creates a list of all particles intersected
! by ray 
! This subroutine navigates a neighbour list
!*******************************************

use sphdata
use treedata

implicit none

integer, intent(in) :: ipart,iptmass
real,intent(in) :: tmax
real,dimension(3),intent(in) :: n

integer :: nlong,ntest
integer, allocatable,dimension(:) :: longlist

integer :: jpart,k,kpart
real :: t_try

nray = 0

!******************************************************************
! 1. Navigate along neighbour lists
!******************************************************************


! Make a list of potential intersectors
allocate(longlist(npart))
longlist(:) = 0
nlong = 0

! First members of list: neighbours of ipart

do kpart = 1,nneigh(ipart)
   nlong = nlong +1
   longlist(nlong) = neighb(ipart,kpart)
enddo

print*, 'Initially testing ',nlong, ' neighbours of ',ipart


! Keep testing particles on the list until we run out
ntest = 0
do while(ntest < nlong)
   ntest = ntest + 1
   jpart = longlist(ntest)

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

      ! Add neighbours of particle to longlist for checking
      do kpart=1,nneigh(jpart)
         nlong = nlong+1
         longlist(nlong) = neighb(ipart,kpart)
      enddo

   endif

enddo
    ! End of loop over jpart

print*, 'ntest, nray: ',ntest,nray
deallocate(longlist)

end subroutine raylist_neighbours
