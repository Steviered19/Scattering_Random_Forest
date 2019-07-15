program convert
!This program is designed to read the .txt data files so that they can be converted into .csv files

implicit none
!variables for array alloaction
integer :: n, dim, AllocateStatus, DeallocateStatus
real :: dummy
! useful variables
character(len=255), dimension (:), allocatable :: s1, s2, s3, s4, s5 !s denotes strings with no intrinsic numerical values, length is arbitrary to ensure there will always be excess length 
character(len=15) :: dummy_string
character(len=2) :: reaction_type
character(len=7) :: observable
real, dimension (:), allocatable :: r1, r2, r3, r4, r5, r6, r7, r8, r9
integer :: i1 !r denotes values of data points i denotes number of lines of data in data set
integer :: line, z, x !3 different notations for the line number
integer :: io

!open input data files
open(unit=20, file="npnew3sig.dat.txt", status='unknown')
open(unit=30, file="ppnew3sig.dat.txt", status='unknown')

!open new .csv data files to act as output
open(unit=40, file="np.dat.csv", status='unknown')
open(unit=50, file="pp.dat.csv", status='unknown')

!allocate arrays
n=0
do
    read(30,3,end=5000,iostat=io) dummy, dummy, dummy, dummy, dummy, dummy, dummy, dummy, dummy, dummy, dummy
    n=n+1
end do
5000 continue
dim=n
rewind(30)

allocate(s1(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(s2(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(s3(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(s4(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(s5(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(r1(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(r2(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(r3(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(r4(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(r5(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(r6(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(r7(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(r8(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
allocate(r9(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'
!allocate(i1(dim), stat=AllocateStatus); if (AllocateStatus/=0) STOP 'Not enough memory'

!read input and write to output
line=1 !initialize at line 1
do
    read(30,3,end=15) r1(line), i1, r2(line), r3(line), dummy_string, reaction_type, observable! r4(line), r5(line), s1(line), s2(line), s3(line), s4(line), s5(line)
    if (r1(line) > 350.0) exit 
    read(30,*)  
    print *, r1(line), i1, r2(line), r3(line), dummy_string, reaction_type, observable!, r4(line), r5(line), s1(line), s2(line), s3(line), s4(line), s5(line)
    line=line+2 !skip line of bibliographic info for data set
    x=line+i1-1 !this value will be the last line of data collected in a particular data set
    print *, line, x
    do z=1, i1
        read(30,4) r6(line), r7(line), r8(line), r9(line) !4 columns of data
        print *, r6(line), r7(line), r8(line), r9(line)
        write(50,5) r6(line), ', ', r7(line), ', ', r8(line), ', ', r9(line), ', ', reaction_type, ', ',&
        & observable, ', ', r2(line), ', ', r3(line) !ouput to .csv file
        !stop
    end do
    line=line+1 !move to next data set
end do
15 continue

!define format of lines in input data files
3 format(f10.6, i4, 2f7.3,a15,a2,a7)!!, f5.3, f5.3, a2, a4, a6, a4, a4)
4 format(2f13.6, 2f13.5)!, f9.6, f8.6)
!define format of lines in output data files
5 format(2(f13.6,a2), 2(f13.5,a2), 2a2, a7, a2, f7.3, a2, f7.3)

!release arrays from memory
if (dim>0) then
    deallocate(s1, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(s2, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(s3, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(s4, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(s5, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(r1, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(r2, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(r3, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(r4, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(r5, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(r6, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(r7, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(r8, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
    deallocate(r9, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
   ! deallocate(i1, stat=DeallocateStatus); if (DeAllocateStatus /= 0) STOP 'Deallocation not successful'
end if

!close all files
close(unit=20); close(unit=30); close(unit=40); close(unit=50)

end program convert
