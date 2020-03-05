program converter
  implicit none
  real :: E, k, val, sigma
  integer :: sgt_input, sgtt_input, sgt_output, sgtt_output, total_output

  !open input files
  open(newunit=sgt_input, file="random_sgt.dat", status="unknown")
  open(newunit=sgtt_input, file="random_sgtt.dat", status="unknown")
  !open output
  open(newunit=total_output, file="CSV_files/random.sgt_and_sgtt.csv", status="unknown")
  open(newunit=sgt_output, file="CSV_files/random.sgt.csv", status="unknown")
  open(newunit=sgtt_output, file="CSV_files/random.sgtt.csv", status="unknown")
  !write header line
  write(total_output,*) "energy", ",", "k", ",", "experimental_value", ",", "sigma", ",",&
  & "reaction_type", ",", "observable"
  write(sgt_output,*) "energy", ",", "k", ",", "experimental_value", ",", "sigma", ",",&
  & "reaction_type", ",", "observable"
  write(sgtt_output,*) "energy", ",", "k", ",", "experimental_value", ",", "sigma", ",",&
  & "reaction_type", ",", "observable"

  !read and write data
  read(sgt_input,*) !header line
  do
    read(sgt_input, 5, end=25) E, k, val, sigma
    write(total_output, 6) E, ",", k, ",", val, ",", sigma, ",", "NP",", ","   SGT "
    write(sgt_output, 6) E, ",", k, ",", val, ",", sigma, ",", "NP",", ","   SGT "
  enddo
  25 continue

  read(sgtt_input,*) !header line
  do
    read(sgtt_input, 5, end=35) E, k, val, sigma
    write(total_output, 6) E, ",", k, ",", val, ",", sigma, ",", "NP",", ","   SGTT"
    write(sgtt_output, 6) E, ",", k, ",", val, ",", sigma, ",", "NP",", ","   SGTT"
  enddo
  35 continue

  5 format(e15.8, 3e21.8)
  6 format(e15.8, 3(a1, e18.8), a1, a2, a1, a7)
end program converter
