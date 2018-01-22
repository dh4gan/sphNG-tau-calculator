subroutine initial

  use sphdata

  character(100) :: suffix

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

  OPEN(10,file=paramfile, status='unknown')
  read(10,*) listfile
  read(10,*) fileformat

  close(10)


  open(10,file=paramfile, status='old')
  read(10,*) listfile ! File containing list of dumps to analyse
  read(10,*) fileformat ! sphNG_wkmr, sphNG_iab

  close(10)

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
     write(outputfile(ifile),'("trimmedbinary",A)') trim(suffix)
  enddo

  ! Read in equation of state file

  call eosread



end subroutine initial
