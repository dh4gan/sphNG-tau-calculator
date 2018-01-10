subroutine compute_optical_depths



allocate(tausink(nptmass,npart))
allocate(av(nptmass,npart))

tausink(:,:) = 0.0
av(:,:) = 0.0

! Loop over all sinks
do iptmass=1,nptmass

   rsink = xyzmh(1:3,listpm(iptmass))

! Loop over all particles
   do ipart = 1,npart

      ! sinks and dead particles get zero tau
      if(iphase(ipart)/=0) then
         tausink(iptmass,ipart) = 0.0
      else


      ! Find direction vector of ray back to sink

        nmag = 0.0
        n(:) = 0.0
         do k=1,3
            n(k) = rsink(k)-xyzmh(k,ipart)
            nmag = nmag + n(k)*n(k)
         enddo

      n(:) = n(:)/nmag

      ! Ray halts at tmax = star location
      tmax = nmag
      ! Create list of all particles intersected by ray (raylist)
      ! Launching point is the location of particle ipart


      ! Now loop over jpart particles

      do jpart = 1,npart

        if(ipart==jpart) cycle


      ! Calculate t_min

    t_try = 0.0

    do k=1,3
        t_try = t_try + n(k)*(xyzmh(k,jpart)-xyzmh(k,ipart))
    enddo

        ! t must be less than tmax: t such that ray hits sink location
    if(t_try>tmax) cycle


    ! Calculate b

    b(jpart) = 0.0
    do k=1,3
        b(jpart) = b(jpart) + (xyzmh(k,ipart) + t_try*n(k) - xyzmh(k,jpart))**2 +&
    enddo

    b(jpart) = SQRT(b(jpart))

    t_sphere(jpart) = 2.0d0*SQRT(4.0d0*xyzmh(5,jpart)**2 - b(jpart)*b(jpart))

    ! If t -ve and sufficiently distant, particle is behind ray, should be excluded
    if(t_try<0.0d0.and.ABS(t_try)>t_sphere/2.0d0) cycle


    ! If b < 2*h_i, then add to list

    if(b(jpart) < 2.0*xyzmh(5,jpart)) then

    ! Add particle to raylist

    ray(nray) = ipart
    t_min(nray) = t_try

    nray = nray+1
    endif

    enddo
    ! End of loop over jpart

    ! loop over raylist and calculate optical depths

    do iray = 1,nray

        jpart = ray(iray)
        tauparticle = 0.0
        call calc_tau(jpart,gammamuT(4,jpart),tsphere(jpart),tauparticle)

        tau(ipart) = tau(ipart) + tauparticle

      endif

    ! Av = log10(e) tau 
        Av = 1.086*tau(ipart)
      ! TODO - Convert optical depth to Av
   enddo
enddo



end subroutine compute_optical_depths
