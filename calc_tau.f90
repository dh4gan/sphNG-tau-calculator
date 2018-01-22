	SUBROUTINE calc_tau(ipart,kap,xi,tau)
!	Calculates the optical depth through a distance xi in a smoothing volume
!	This routine is kernel dependent

	use sphdata	

	real(kind=8) ::  m,h,xi,x,b_i,tau,kap
	real(kind=8) ::  b_norm, r_f,s
	real(kind=8) ::  rf1,rf2,b1,b2, sigma
	real,parameter  :: pi = 3.141596253d0
	real, parameter :: cnormk = 1.0/pi
			
!	Calc normalised values of parameters, and s
	
	m = xyzmh(4,ipart)
	h = xyzmh(5,ipart)
	b_i= b(ipart)
			
	b_norm = b_i/h
	sigma = 0.0d0
	s = 2.0d0*DSQRT(4.0d0*h*h - b_i*b_i)

!	Prevent calculating outside the smoothing volume
	IF(xi>s) x=s
	IF(xi<=s) x=xi
			
!	Calc final limit of integral (normalise it)

	r_f = DSQRT(((s/2.0d0)-x)**2 + b_i*b_i)
	r_f = r_f/h
					
!	Calc sigma (decide on which case to use for integral)

	rf1 = r_f - 0.5*r_f*r_f*r_f + (3.0d0*r_f**4)/16.0d0
	rf2 = ((2.0d0-r_f)**4)/16.0d0

	
	b1 = b_norm - 0.5*b_norm**3 + (3.0d0*b_norm**4)/16.0d0
	b2 = ((2.0d0-b_norm)**4)/16.0d0
			
	IF(x<=s/2.0d0) THEN

		IF(r_f.ge.1.0d0) THEN
			sigma = rf2
		ELSE
			sigma =0.75d0 - rf1
		ENDIF
	ELSE
					
		IF(b_norm.ge.1.0d0) THEN
			sigma =	2.0d0*b2 - rf2			
		ELSE
			IF(r_f<=1.0d0) THEN
				sigma = 0.75d0 -2.0d0*b1 + rf1
			ELSE
				sigma = 33.0d0/16.0d0 - 2.0d0*b1 + rf2
			ENDIF
		ENDIF
	ENDIF
    
!	Calc tau = m*sigma*kappa

	tau = m*sigma*kap/(h*h)

	CALL FLUSH(iprint)
	RETURN
	END subroutine calc_tau
