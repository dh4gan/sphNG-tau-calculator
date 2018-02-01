subroutine compute_optical_depths
! Calculates optical depth from every particle to every sink/pointmass particle


use sphdata
use treedata
use eosdata, only: gammamuT
implicit none

integer :: iray,ipart,jpart,iptmass,k
real :: tauparticle,tmax
real :: percent,increment
real, dimension(3) :: n,rsink

allocate(tausink(nptmass,npart))
allocate(pathlength(nptmass,npart))
allocate(av(nptmass,npart))
allocate(b(npart), t_sphere(npart))
allocate(t_min(npart))
allocate(ray(npart))

tausink(:,:) = 0.0
av(:,:) = 0.0
pathlength(:,:) = 0.0

print*, 'Computing optical depths'

! Loop over all sinks
do iptmass=1,nptmass

   rsink = xyzmh(1:3,listpm(iptmass))

   print*, 'Computing optical depths to sink ',iptmass
   percent = 0.0
   increment = 1.0

! Loop over all particles
   do ipart = 1,npart

      call particle_percent_complete(ipart,npart,percent,increment)
      ! sinks and dead particles get zero tau
      if(iphase(ipart)/=0) then
         tausink(iptmass,ipart) = 0.0
         cycle
      endif


      ! Find direction vector of ray back to sink
        
        n(:) = 0.0
         do k=1,3
            n(k) = rsink(k)-xyzmh(k,ipart)
            pathlength(iptmass,ipart) = pathlength(iptmass,ipart) + n(k)*n(k)
         enddo

      pathlength(iptmass,ipart) = sqrt(pathlength(iptmass,ipart))

      ! n must be a unit vector
      n(:) = n(:)/pathlength(iptmass,ipart)

      ! Ray halts at tmax = star location
      tmax = pathlength(iptmass,ipart)

      ! Create list of all particles intersected by ray (raylist)
      ! Launching point is the location of particle ipart

      if(use_neighbourlist) then
         call raylist_neighbours(ipart,iptmass,n,tmax)
      else
         call raylist_brute(ipart,iptmass,n,tmax)
      endif

      ! loop over raylist and calculate optical depths
    
      do iray = 1,nray

         jpart = ray(iray)
         tauparticle = 0.0
       
         call calc_tau(jpart,gammamuT(4,jpart),t_sphere(jpart),tauparticle)

         ! print*, iray,nray, ipart, jpart,gammamuT(3,jpart),gammamuT(4,jpart), b(jpart)/xyzmh(5,jpart),tauparticle
         tausink(iptmass,ipart) = tausink(iptmass,ipart) + tauparticle
        
      enddo
      print*, ipart, nray, tausink(iptmass,ipart)
   enddo
   ! End of loop over particles

enddo
! End of loop over sinks

! Av = log10(e) tau 
Av(:,:) = 1.086*tausink(:,:)

print*, 'Optical depths computed'

end subroutine compute_optical_depths
