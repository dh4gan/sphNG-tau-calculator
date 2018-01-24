subroutine write_binary(ifile)
! Writes sphNG data to a binary format parseable by python routines
! for overplotting
  use sphdata

  implicit none

  integer, intent(in) :: ifile
  integer :: ipart,rcl
  character(100):: acc
  
  print*, 'Writing binary ', trim(outputfile(ifile))
!  open(90,file=outputfile(ifile),form='unformatted',access='stream',status='replace')
  open(90,file=outputfile(ifile), form='formatted') 
  write(90,*) "# id t x y z vx vy vz mass hsml rho T u pathlength tau Av\n"

  do ipart=1,npart
     if(iphase(ipart)==0) then
        write(90,*) real(ipart), gt, xyzmh(1:3,ipart),vxyzu(1:3,ipart),&
             xyzmh(4,ipart),xyzmh(5,ipart), rho(ipart), &
             vxyzu(4,ipart), vxyzu(4,ipart), &
             pathlength(1,ipart), tausink(1,ipart), Av(1,ipart)
     endif
  enddo

  close(90)

     
end subroutine write_binary
