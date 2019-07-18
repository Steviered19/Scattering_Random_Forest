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
integer :: np_dat_input, pp_dat_input, np_dat_output, pp_dat_output !file unit identifiers

!open input data files
open(newunit=np_dat_input, file="npnew3sig.dat.txt", status='unknown')
open(newunit=pp_dat_input, file="ppnew3sig.dat.txt", status='unknown')

!open new .csv data files to act as output
open(newunit=np_dat_output, file="np.dat.csv", status='unknown')
open(newunit=pp_dat_output, file="pp.dat.csv", status='unknown')

!read input and write to output
!write header line on output files
write(np_dat_output,6) "energy", "scattering angle", "experimental value", "statistical error", "reaction type", &
    & "observable", "systematic error", "normalization"
write(pp_dat_output,6) "energy", "scattering angle", "experimental value", "statistical error", "reaction type", &
& "observable", "systematic error", "normalization"

!np data
np_line=1 !initialize at line 1
do
    read(np_dat_input,3,end=25) base_lab_energy, collected_data_points, &
    & systematic_error, normalization, dummy_string, reaction_type, observable
    if (base_lab_energy > 350.0) exit
    read(np_dat_input,*) !bibliographic line
    do z=1, collected_data_points
        read(np_dat_input,4) lab_energy, scattering_angle, experimental_value, statistical_error !4 columns of data
        write(np_dat_output,5) lab_energy, ', ', scattering_angle, ', ', &
            & experimental_value, ', ', statistical_error, ', ', reaction_type, ', ', &
            & observable, ', ', systematic_error, ', ', normalization !ouput to .csv file
    end do
np_line=np_line+1 !move to next data set
end do
25 continue

!pp data
pp_line=1 !initialize at line 1
do
    read(pp_dat_input,3,end=15) base_lab_energy, collected_data_points, &
    systematic_error, normalization, dummy_string, reaction_type, observable
    if (base_lab_energy > 350.0) exit
    read(pp_dat_input,*) !bibliographic line
    do z=1, collected_data_points
        read(pp_dat_input,4) lab_energy, scattering_angle, experimental_value, statistical_error !4 columns of data
        write(pp_dat_output,5) lab_energy, ', ', scattering_angle, ', ', experimental_value, ', ', &
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
5 format(f13.6,a2,f13.6,a2,8x,f13.5,a2,2x,f13.5,a2,9x,a2,a2,8x,a7,a2,4x,f7.3,a2,10x,f7.3)
6 format(7x,a6,5x,a16,2x,a18,2x,a17,2x,a13,2x,a10,2x,a16,2x,a13)

!close all files
close(np_dat_input)
close(pp_dat_input)
close(np_dat_output)
close(pp_dat_output)

end program convert
