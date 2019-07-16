program convert
!This program is designed to read the .txt data files so that they can be converted into .csv files

implicit none
character(len=15) :: dummy_string
character(len=2) :: reaction_type
character(len=7) :: observable
real :: base_lab_energy, systematic_error, normalization !header line
real :: lab_energy, scattering_angle, experimental_value, statistical_error!data points
integer :: collected_data_points !part of header line
integer :: pp_line, np_line, z !indexes for counting lines

!open input data files
open(unit=20, file="npnew3sig.dat.txt", status='unknown')
open(unit=30, file="ppnew3sig.dat.txt", status='unknown')

!open new .csv data files to act as output
open(unit=40, file="np.dat.csv", status='unknown')
open(unit=50, file="pp.dat.csv", status='unknown')

!read input and write to output

!np data
np_line=1 !initialize at line 1
do
    read(20,3,end=25) base_lab_energy, collected_data_points, &
    & systematic_error, normalization, dummy_string, reaction_type, observable
    if (base_lab_energy > 350.0) exit
    read(20,*) !bibliographic line
    do z=1, collected_data_points
        read(20,4) lab_energy, scattering_angle, experimental_value, statistical_error !4 columns of data
        write(40,5) lab_energy, ', ', scattering_angle, ', ', experimental_value, ', ', &
            & statistical_error, ', ', reaction_type, ', ', observable, ', ', &
            & systematic_error, ', ', normalization !ouput to .csv file
    end do
np_line=np_line+1 !move to next data set
end do
25 continue

!pp data
pp_line=1 !initialize at line 1
do
    read(30,3,end=15) base_lab_energy, collected_data_points, &
    systematic_error, normalization, dummy_string, reaction_type, observable
    if (base_lab_energy > 350.0) exit
    read(30,*) !bibliographic line
    do z=1, collected_data_points
        read(30,4) lab_energy, scattering_angle, experimental_value, statistical_error !4 columns of data
        write(50,5) lab_energy, ', ', scattering_angle, ', ', experimental_value, ', ', &
            & statistical_error, ', ', reaction_type, ', ', observable, ', ', &
            & systematic_error, ', ', normalization !ouput to .csv file
    end do
    pp_line=pp_line+1 !move to next data set
end do
15 continue


!define format of lines in input data files
3 format(f10.6, i4, 2f7.3,a15,a2,a7)
4 format(2f13.6, 2f13.5)
!define format of lines in output data files
5 format(2(f13.6,a2), 2(f13.5,a2), 2a2, a7, a2, f7.3, a2, f7.3)

!close all files
close(unit=20); close(unit=30); close(unit=40); close(unit=50)

end program convert
