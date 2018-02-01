subroutine initial

  use sphdata
  use treedata, only: use_neighbourlist
  character(100) :: suffix
  character(1) :: useneigh


  ! Set up calculation

  !             Display header
  print*, " "
  print*, "-----------------------------------------------"
  print*, "    CALCULATING OPTICAL DEPTHS IN sphNG DATA"
  print*, "     Created by D.Forgan, 8th January 2018       "
  print*, "-----------------------------------------------"
  print*, " "
  print*, "-----------------------------------------------"
  print*, " input parameters in ./",trim(paramfile)
  print*, ""

  ! Read in parameter file

  open(10,file=paramfile, status='old')
  read(10,*) listfile ! File containing list of dumps to analyse
  read(10,*) fileformat ! sphNG_wkmr, sphNG_iab
  read(10,*) useneigh ! Use neighbour lists? (y/n)

  close(10)

  use_neighbourlist = .false.
  if(useneigh=='y' .or. useneigh=='Y') use_neighbourlist = .true.

  ! Read listfile and generate array of filenames

  open(20, file=listfile, form='formatted')

  read(20,*) nfiles

  allocate(filename(nfiles))
  do ifile=1,nfiles
     read(20,*) filename(ifile)
  enddo

  allocate(outputfile(nfiles))

  do ifile=1,nfiles

     write(suffix, '("_",A)') trim(filename(ifile))
     write(outputfile(ifile),'("tau",A)') trim(suffix)
  enddo

  ! Read in equation of state file

  call eosread



end subroutine initial
