subroutine get_SPH_neighbours(ifile)
!
! Subroutine either reads SPH neighbour data from file, or
! computes it via a regular grid
!

use sphdata
use treedata, only: nneigh,neighb,neighmax

implicit none

integer,intent(in) :: ifile
integer :: j,check
real :: hmean
character(100) :: neighbourfile
logical :: existneigh,existgrav

! Check that the neighbours list exists - look for file

allocate(nneigh(npart))
allocate(neighb(npart,neighmax))

print*, 'Determining SPH neighbours'

!****************************************************************
! 1. Test to see if neighbour file exists: if it does, no need to
! calculate neighbours
!*****************************************************************

neighbourfile ="neighbours_"//TRIM(filename(ifile))

inquire(file=neighbourfile,exist = existneigh)

if(existneigh.eqv..true.) then

   print*, 'Neighbour file ',TRIM(neighbourfile), ' found: reading'
   call read_neighbours(neighbourfile)

else
   !***************************************************************
   ! 2. If no neighbour file found, then we must generate the list
   !***************************************************************

   print*, 'No neighbour file found, generating from scratch'

   nneigh(:) = 0
   neighb(:,:) = 0


   print*, 'Finding neighbours by brute force'
   CALL neighbours_brute

   ! Write the neighbour data to file
   call write_neighbours(neighbourfile)
endif

end subroutine get_SPH_neighbours
