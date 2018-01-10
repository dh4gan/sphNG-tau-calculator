	subroutine initial
    ! Set up calculation

    !             Display header
    print*, " "
    print*, "-----------------------------------------------"
    print*, "    CALCULATING OPTICAL DEPTHS IN sphNG DATA"
    print*, "     Created by D.Forgan, 8th January 2018       "
    print*, "-----------------------------------------------"
    print*, " "
    print*, "-----------------------------------------------"
    print*, " input parameters in ./sph_tau_calculator.params"

    ! Read in parameter file

    OPEN(10,file='sph_tau_calculator.params', status='unknown')

    read(10,*) sphfile
    read(10,*) outputfile

    close(10)

    ! Read in equation of state file (TODO)

    call eosread

    ! Set up SPH kernel (TODO)

    ! Read in SPH file (TODO)

    call rdump(sphfile)

    ! Compute EOS values for SPH data

	end subroutine initial
