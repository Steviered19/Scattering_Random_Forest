module read_write
implicit none
private
public header, write_data, read_input

contains

subroutine header(file)
implicit none
integer, intent(in) :: file


write(file,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
&"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
&"normalization"

6 format(a6,a1,a16,a1,a18,a1,a17,a1,a13,a1,a10,a1,a16,a1,a13)
end subroutine header


subroutine write_data(file, lab_energy, scattering_angle, experimental_value, statistical_error &
&, reaction_type, observable, systematic_error, normalization)
implicit none
integer, intent(in) :: file
character(len=2), intent(in) :: reaction_type
character(len=7), intent(in) :: observable
real, intent(in) :: systematic_error, normalization
real , intent(in):: lab_energy, scattering_angle, experimental_value, statistical_error

write(file,5) lab_energy, ',', scattering_angle, ',',&
& experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
& systematic_error, ',', normalization

5 format(f10.6,a1,f10.6,a1,f11.5,a1,f9.5,a1,a2,a1,a7,a1,f6.3,a1,f6.3)
end subroutine write_data

subroutine read_input(file, lab_energy, scattering_angle, experimental_value, statistical_error)
implicit none
integer, intent(in) :: file
real :: lab_energy, scattering_angle, experimental_value, statistical_error!data points


read(file,4) lab_energy, scattering_angle, experimental_value, statistical_error !4 columns of data

4 format(2f13.6, 2f13.5)
end subroutine read_input

end module read_write
