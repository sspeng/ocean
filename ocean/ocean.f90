program ocean
    use mod_data
    use mpdata_adiff
    implicit none
    integer start_time, stop_time, clock_rate, clock_max
    integer ierr, myrank
    real*8 t1

! General procedure.
! *************************************************************
    write (*,*) "[INIT] Initializing data..."
    call allocate_init_data()

    write (*,*) "[INIT] Done!"
    write (*,*) 

    write (*,*) "[RUN]  Start calculation..."
    call system_clock(start_time,clock_rate,clock_max)

    call mpdata_adiff_tile(LBi, UBi, LBj, UBj, MYDATA%oHz, MYDATA%Huon, MYDATA%Hvom, MYDATA%W, MYDATA%Ta, &
                         & MYDATA%Uind, MYDATA%Dn, MYDATA%Dm, MYDATA%Ua)

    call system_clock(stop_time,clock_rate,clock_max)
    t1 = real(stop_time - start_time)/real(clock_rate)

    write(*,'(a,f11.3,a)') '        Calculation time:',t1,'(s)'

    write (*,*) "[RUN]  Done!"
    write (*,*) 


    !OPEN(3,FILE='UA.dat',FORM='unformatted')
    !WRITE(3)MYDATA%Ua(LBi : UBi, LBj : UBj, 1 : N)
    !CLOSE(3)

    write (*,*) "[VERIFY] Start verification."
    call verify_data()
    write (*,*) "[VERIFY] Done!"
    call deallocate_data()

end program
