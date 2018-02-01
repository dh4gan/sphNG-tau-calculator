module treedata

  !-----------------------------------------------------------------------
  ! Data module for saving data on rays and trees
  ! DHF 01/09/2009
  !-----------------------------------------------------------------------

  implicit none
  save


  !-------------------Single values---------------------------------------

  ! Integers

  integer ::  inode,n_node,nodemax,nray
  real :: hmin, xp,yp,zp,nxp,nyp,nzp	
  integer, parameter :: neighmax = 150
  real,parameter :: tolerance = 5.0 ! Number of smoothing lengths for search radius

  real :: meanneigh,sdneigh,neighcrit
  logical :: use_neighbourlist

  !----------------------Arrays---------------------------------------

  integer, allocatable, dimension(:) :: ray,n_occ,parent,n_child,nneigh,partbin
  integer, allocatable, dimension(:,:) :: child, occ, neighb		
  real,allocatable, dimension(:) :: b,t_min,t_sphere
  real, allocatable, dimension(:,:) :: r_node, dr_node,bbr_min, bbr_max


end module treedata
