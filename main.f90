program sph_tau_calculator
! Written 9/1/18 by dh4gan
! Code reads in an sphNG file, and then computes optical depth (Av)
! from all SPH particles to all sinks


! Read in parameters, data and set up run

call initial

! Compute optical depths

call compute_optical_depths

! Write SPH data to ASCII file (ID, tau, Av)

call write_tau_data



end program sph_tau_calculator

