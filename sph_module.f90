      module sphdata

!-----------------------------------------------------------------------
! Data module for saving data from sph, grav and pot files
! PJC 20/05/2008
! DHF 01/09/2009
!-----------------------------------------------------------------------

      implicit none
      save

!-------------------Single values---------------------------------------
! Integers
      integer :: npart,naccrete,n1,n2,nreassign,nkill, iprint,scheme
      integer(kind=8) :: nptmass
      integer, dimension(8) :: nums
! Reals
      real :: gt, gamma, dtmaxdp,rhozero,RK2,escap,tkin,tgrav,tterm
      real :: anglostx,anglosty,anglostz,specang,ptmassin
      real :: xmax, ymax, zmax, rmax,gridmass
      real :: udist,umass,utime,udens,uergg,uopac,ulum  ! Code units
	  real :: pbinsize,logbinmin,logbinmax
! Characters

	character(100) :: fileident		      
		      
!-------------------Array values----------------------------------------
! Integers
      integer,allocatable,dimension(:) :: tphase,uphase,isteps,listpm
      integer(kind=1),allocatable,dimension(:) :: iphase,iorig,isort
! Reals
      real,allocatable,dimension(:) :: spinx,spiny,spinz
	  real,allocatable,dimension(:) :: p_vr, p_vz,vr,vz
      real,allocatable,dimension(:) :: angaddx,angaddy,angaddz
      real,allocatable,dimension(:) :: spinadx,spinady,spinadz
      real,allocatable,dimension(:,:) :: xyzmh,vxyzu
      real, allocatable,dimension(:,:) :: tausink,Av, gammamuT
      real(kind=4),allocatable,dimension(:) :: rho,dgrav,cs,Tpart
	  real, allocatable, dimension(:,:,:) :: OPTABLE
      end module sphdata
