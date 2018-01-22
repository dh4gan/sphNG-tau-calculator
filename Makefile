##############################################################
###                                                        ###
###               Make File for sph_tau_calculator         ###
###               Written by Duncan Forgan	           ###
###                      January 2018                      ###
###                                                        ###
###                                                        ###
##############################################################

.KEEP_STATE:

FC = gfortran
RENAMES = 

# For files generated from stacpolly use these flags
FFLAGS = -O3 -frecord-marker=4 -fdefault-real-8

# For big-endian files generated from stacpolly use these flags
#FFLAGS = -O3 -fPIC -frecord-marker=4 -fdefault-real-8 -fconvert=swap

# For files generated on desktops use these flags
#FFLAGS = -O3 -frecord-marker=4

# Create object files:
%.o: %.f
	$(FC) $(FFLAGS) -c $<
%.o: %.f90
	$(FC) $(FFLAGS) -c $<

SOURCESAF90 = sph_module.f90 eos_module.f90 tree_module.f90 main.f90 \
	calc_tau.f90 compute_optical_depths.f90 \
	eos.f90 eosread.f90 initial.f90 \
	rdump_sph.f90 write_tau_data.f90

OBJECTSA    = $(SOURCESAF90:.f90=.o)

# Create executable files:
build: sph_tau_calculator

sph_tau_calculator:  $(OBJECTSA)
	$(FC) $(FFLAGS) -o $@ $(OBJECTSA)

# Clean statements:
clean: 
	\rm *.o *.mod sph_tau_calculator

# End Makefile
