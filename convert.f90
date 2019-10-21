program convert
!This program is designed to read the .txt data files so that they can be converted into .csv files
use read_write, only : header, write_data, read_input
implicit none
character(len=15) :: dummy_string
character(len=2) :: reaction_type
character(len=7) :: observable
real :: base_lab_energy, systematic_error, normalization !header line
real :: lab_energy, scattering_angle, experimental_value, statistical_error!data points
integer :: collected_data_points !part of header line
integer :: pp_line, np_line, z, line!indexes for counting lines
integer :: np_dat_input, pp_dat_input, np_dat_output, pp_dat_output !file unit identifiers
!addition unit identifiers for observable-separated files
integer :: np_a, np_alfa, np_at, np_ayy, np_azz, np_d, np_dosk, np_dsg, np_dsg_star, np_dt
integer :: np_dtrt, np_nnkk, np_nskn, np_nssn, np_p, np_r, np_ref2, np_ref3, np_rpt, np_rt
integer :: np_sgt, np_sgtl, np_sgtr, np_sgtt, np_sgt_and_sgtt
integer :: pp_a, pp_alfa, pp_ap, pp_axx, pp_ayy, pp_azx, pp_azz, pp_ckp, pp_d, pp_dsg
integer :: pp_dt, pp_mskn, pp_mssn, pp_p, pp_r, pp_ref2, pp_ref3, pp_rp, pp_sgt, pp_sgte
integer :: pp_sgtl, pp_sgtr, pp_sgtt

!open input data files
open(newunit=np_dat_input, file="Raw_data_files/npnew3sig.dat.txt", status='unknown')
open(newunit=pp_dat_input, file="Raw_data_files/ppnew3sig.dat.txt", status='unknown')

!open new .csv data files to act as output
open(newunit=np_dat_output, file="CSV_files/np.dat.csv", status='unknown')
open(newunit=pp_dat_output, file="CSV_files/pp.dat.csv", status='unknown')
!upon further computation it was made clear that separating into different files for different observables would be useful.
!open observable-separated output files
open(newunit=np_a, file="CSV_files/np.a.csv", status='unknown')
open(newunit=np_alfa, file="CSV_files/np.alfa.csv", status='unknown')
open(newunit=np_at, file="CSV_files/np.at.csv", status='unknown')
open(newunit=np_ayy, file="CSV_files/np.ayy.csv", status='unknown')
open(newunit=np_azz, file="CSV_files/np.azz.csv", status='unknown')
open(newunit=np_d, file="CSV_files/np.d.csv", status='unknown')
open(newunit=np_dosk, file="CSV_files/np.dosk.csv", status='unknown')
open(newunit=np_dsg, file="CSV_files/np.dsg.csv", status='unknown')
open(newunit=np_dsg_star, file="CSV_files/np.dsg_star.csv", status='unknown')
open(newunit=np_dt, file="CSV_files/np.dt.csv", status='unknown')
open(newunit=np_dtrt, file="CSV_files/np.dtrt.csv", status='unknown')
open(newunit=np_nnkk, file="CSV_files/np.nnkk.csv", status='unknown')
open(newunit=np_nskn, file="CSV_files/np.nskn.csv", status='unknown')
open(newunit=np_nssn, file="CSV_files/np.nssn.csv", status='unknown')
open(newunit=np_p, file="CSV_files/np.p.csv", status='unknown')
open(newunit=np_r, file="CSV_files/np.r.csv", status='unknown')
open(newunit=np_ref2, file="CSV_files/np.ref2.csv", status='unknown')
open(newunit=np_ref3, file="CSV_files/np.ref3.csv", status='unknown')
open(newunit=np_rpt, file="CSV_files/np.rpt.csv", status='unknown')
open(newunit=np_rt, file="CSV_files/np.rt.csv", status='unknown')
open(newunit=np_sgt, file="CSV_files/np.sgt.csv", status='unknown')
open(newunit=np_sgtl, file="CSV_files/np.sgtl.csv", status='unknown')
open(newunit=np_sgtr, file="CSV_files/np.sgtr.csv", status='unknown')
open(newunit=np_sgtt, file="CSV_files/np.sgtt.csv", status='unknown')
open(newunit=pp_a, file="CSV_files/pp.a.csv", status='unknown')
open(newunit=pp_alfa, file="CSV_files/pp.alfa.csv", status='unknown')
open(newunit=pp_ap, file="CSV_files/pp.ap.csv", status='unknown')
open(newunit=pp_axx, file="CSV_files/pp.axx.csv", status='unknown')
open(newunit=pp_ayy, file="CSV_files/pp.ayy.csv", status='unknown')
open(newunit=pp_azx, file="CSV_files/pp.azx.csv", status='unknown')
open(newunit=pp_azz, file="CSV_files/pp.azz.csv", status='unknown')
open(newunit=pp_ckp, file="CSV_files/pp.ckp.csv", status='unknown')
open(newunit=pp_d, file="CSV_files/pp.d.csv", status='unknown')
open(newunit=pp_dsg, file="CSV_files/pp.dsg.csv", status='unknown')
open(newunit=pp_dt, file="CSV_files/pp.dt.csv", status='unknown')
open(newunit=pp_mskn, file="CSV_files/pp.mskn.csv", status='unknown')
open(newunit=pp_mssn, file="CSV_files/pp.mssn.csv", status='unknown')
open(newunit=pp_p, file="CSV_files/pp.p.csv", status='unknown')
open(newunit=pp_r, file="CSV_files/pp.r.csv", status='unknown')
open(newunit=pp_ref2, file="CSV_files/pp.ref2.csv", status='unknown')
open(newunit=pp_ref3, file="CSV_files/pp.ref3.csv", status='unknown')
open(newunit=pp_rp, file="CSV_files/pp.rp.csv", status='unknown')
open(newunit=pp_sgt, file="CSV_files/pp.sgt.csv", status='unknown')
open(newunit=pp_sgte, file="CSV_files/pp.sgte.csv", status='unknown')
open(newunit=pp_sgtl, file="CSV_files/pp.sgtl.csv", status='unknown')
open(newunit=pp_sgtr, file="CSV_files/pp.sgtr.csv", status='unknown')
open(newunit=pp_sgtt, file="CSV_files/pp.sgtt.csv", status='unknown')

open(newunit=np_sgt_and_sgtt, file="CSV_files/np.sgt_and_sgtt.csv", status='unknown')


!read input and write to output
!write header line on output files
call header(np_dat_output)
call header(pp_dat_output)
!separated files
call header(np_a)
call header(np_alfa)
call header(np_at)
call header(np_ayy)
call header(np_azz)
call header(np_d)
call header(np_dosk)
call header(np_dsg_star)
call header(np_dsg)
call header(np_dt)
call header(np_dtrt)
call header(np_nnkk)
call header(np_nskn)
call header(np_nssn)
call header(np_p)
call header(np_r)
call header(np_ref2)
call header(np_ref3)
call header(np_rpt)
call header(np_rt)
call header(np_sgt)
call header(np_sgtl)
call header(np_sgtr)
call header(np_sgtt)
call header(pp_a)
call header(pp_alfa)
call header(pp_ap)
call header(pp_axx)
call header(pp_ayy)
call header(pp_azx)
call header(pp_azz)
call header(pp_ckp)
call header(pp_d)
call header(pp_dsg)
call header(pp_dt)
call header(pp_mskn)
call header(pp_mssn)
call header(pp_p)
call header(pp_r)
call header(pp_ref2)
call header(pp_ref3)
call header(pp_rp)
call header(pp_sgt)
call header(pp_sgte)
call header(pp_sgtl)
call header(pp_sgtr)
call header(pp_sgtt)

call header(np_sgt_and_sgtt)

!np data
np_line=1 !initialize at line 1
do
    read(np_dat_input,3,end=25) base_lab_energy, collected_data_points, &
    & systematic_error, normalization, dummy_string, reaction_type, observable
    if (base_lab_energy > 350.0) exit
    read(np_dat_input,*) !bibliographic line
    do z=1, collected_data_points
        call read_input(np_dat_input, lab_energy, scattering_angle, experimental_value, statistical_error)
        call write_data(np_dat_output, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        !if statements used to output to separated files depending on observable type
        if (observable == '   A  ') call write_data(np_a, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   ALFA') call write_data(np_alfa, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   AT  ') call write_data(np_at, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   AYY ') call write_data(np_ayy, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   AZZ ') call write_data(np_azz, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   D   ') call write_data(np_d, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   D0SK') call write_data(np_dosk, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   DSG*') call write_data(np_dsg_star, lab_energy, scattering_angle, experimental_value &
        &, statistical_error, reaction_type, observable, systematic_error, normalization)
        if (observable == '   DSG ') call write_data(np_dsg, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   DT  ') call write_data(np_dt, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   DTRT') call write_data(np_dtrt, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   NNKK') call write_data(np_nnkk, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   NSKN') call write_data(np_nskn, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   NSSN') call write_data(np_nssn, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   P   ') call write_data(np_p, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   R   ') call write_data(np_r, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   REF2') call write_data(np_ref2, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   REF3') call write_data(np_ref3, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   RPT ') call write_data(np_rpt, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   RT  ') call write_data(np_rt, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   SGT ') call write_data(np_sgt, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   SGTL') call write_data(np_sgtl, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   SGTR') call write_data(np_sgtr, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   SGTT') call write_data(np_sgtt, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   SGT ' .or. observable == '   SGTT') call write_data(np_sgt_and_sgtt, lab_energy, scattering_angle, &
        & experimental_value, statistical_error, reaction_type, observable, systematic_error, normalization)
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
        call read_input(pp_dat_input, lab_energy, scattering_angle, experimental_value, statistical_error)
        call write_data(pp_dat_output, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        !if statements used to output to separated files depending on observable type
        if (observable == '   A  ') call write_data(pp_a, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   ALFA') call write_data(pp_alfa, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   AP  ') call write_data(pp_ap, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   AXX ') call write_data(pp_axx, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   AYY ') call write_data(pp_ayy, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   AZX ') call write_data(pp_azx, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   AZZ ') call write_data(pp_azz, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   CKP ') call write_data(pp_ckp, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   D   ') call write_data(pp_d, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   DSG ') call write_data(pp_dsg, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   DT  ') call write_data(pp_dt, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   MSKN') call write_data(pp_mskn, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   MSSN') call write_data(pp_mssn, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   P   ') call write_data(pp_p, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   R   ') call write_data(pp_r, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   REF2') call write_data(pp_ref2, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   REF3') call write_data(pp_ref3, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   RP  ') call write_data(pp_rp, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   SGT ') call write_data(pp_sgt, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   SGTE') call write_data(pp_sgte, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   SGTL') call write_data(pp_sgtl, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   SGTR') call write_data(pp_sgtr, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
        if (observable == '   SGTT') call write_data(pp_sgtt, lab_energy, scattering_angle, experimental_value, statistical_error &
        &, reaction_type, observable, systematic_error, normalization)
    end do
    pp_line=pp_line+1 !move to next data set
end do
15 continue

!define format of lines in input data files
3 format(f10.6, i4, 2f7.3,a14,a3,a7)
4 format(2f13.6, 2f13.5)
!define format of lines in output data files
5 format(f10.6,a1,f10.6,a1,f11.5,a1,f9.5,a1,a2,a1,a7,a1,f6.3,a1,f6.3)
6 format(a6,a1,a16,a1,a18,a1,a17,a1,a13,a1,a10,a1,a16,a1,a13)

!close all files
close(np_dat_input)
close(pp_dat_input)
close(np_dat_output)
close(pp_dat_output)
close(np_a)
close(np_alfa)
close(np_at)
close(np_ayy)
close(np_azz)
close(np_d)
close(np_dosk)
close(np_dsg)
close(np_dsg_star)
close(np_dt)
close(np_dtrt)
close(np_nnkk)
close(np_nskn)
close(np_nssn)
close(np_p)
close(np_r)
close(np_ref2)
close(np_ref3)
close(np_rpt)
close(np_rt)
close(np_sgt)
close(np_sgtl)
close(np_sgtr)
close(np_sgtt)
close(pp_a)
close(pp_alfa)
close(pp_ap)
close(pp_axx)
close(pp_ayy)
close(pp_azx)
close(pp_azz)
close(pp_ckp)
close(pp_d)
close(pp_dsg)
close(pp_dt)
close(pp_mskn)
close(pp_mssn)
close(pp_p)
close(pp_r)
close(pp_ref2)
close(pp_ref3)
close(pp_rp)
close(pp_sgt)
close(pp_sgte)
close(pp_sgtl)
close(pp_sgtr)
close(pp_sgtt)

close(np_sgt_and_sgtt)

end program convert
