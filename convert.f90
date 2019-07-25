program convert
!This program is designed to read the .txt data files so that they can be converted into .csv files

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
integer :: np_sgt, np_sgtl, np_sgtr, np_sgtt
integer :: pp_a, pp_alfa, pp_ap, pp_axx, pp_ayy, pp_azx, pp_azz, pp_ckp, pp_d, pp_dsg
integer :: pp_dt, pp_mskn, pp_mssn, pp_p, pp_r, pp_ref2, pp_ref3, pp_rp, pp_sgt, pp_sgte
integer :: pp_sgtl, pp_sgtr, pp_sgtt

!open input data files
open(newunit=np_dat_input, file="npnew3sig.dat.txt", status='unknown')
open(newunit=pp_dat_input, file="ppnew3sig.dat.txt", status='unknown')

!open new .csv data files to act as output
open(newunit=np_dat_output, file="np.dat.csv", status='unknown')
open(newunit=pp_dat_output, file="pp.dat.csv", status='unknown')
!upon further computation it was made clear that separating into different files for different observables would be useful.
!open observable-separated output files
open(newunit=np_a, file="np.a.csv", status='unknown')
open(newunit=np_alfa, file="np.alfa.csv", status='unknown')
open(newunit=np_at, file="np.at.csv", status='unknown')
open(newunit=np_ayy, file="np.ayy.csv", status='unknown')
open(newunit=np_azz, file="np.azz.csv", status='unknown')
open(newunit=np_d, file="np.d.csv", status='unknown')
open(newunit=np_dosk, file="np.dosk.csv", status='unknown')
open(newunit=np_dsg, file="np.dsg.csv", status='unknown')
open(newunit=np_dsg_star, file="np.dsg_star.csv", status='unknown')
open(newunit=np_dt, file="np.dt.csv", status='unknown')
open(newunit=np_dtrt, file="np.dtrt.csv", status='unknown')
open(newunit=np_nnkk, file="np.nnkk.csv", status='unknown')
open(newunit=np_nskn, file="np.nskn.csv", status='unknown')
open(newunit=np_nssn, file="np.nssn.csv", status='unknown')
open(newunit=np_p, file="np.p.csv", status='unknown')
open(newunit=np_r, file="np.r.csv", status='unknown')
open(newunit=np_ref2, file="np.ref2.csv", status='unknown')
open(newunit=np_ref3, file="np.ref3.csv", status='unknown')
open(newunit=np_rpt, file="np.rpt.csv", status='unknown')
open(newunit=np_rt, file="np.rt.csv", status='unknown')
open(newunit=np_sgt, file="np.sgt.csv", status='unknown')
open(newunit=np_sgtl, file="np.sgtl.csv", status='unknown')
open(newunit=np_sgtr, file="np.sgtr.csv", status='unknown')
open(newunit=np_sgtt, file="np.sgtt.csv", status='unknown')
open(newunit=pp_a, file="pp.a.csv", status='unknown')
open(newunit=pp_alfa, file="pp.alfa.csv", status='unknown')
open(newunit=pp_ap, file="pp.ap.csv", status='unknown')
open(newunit=pp_axx, file="pp.axx.csv", status='unknown')
open(newunit=pp_ayy, file="pp.ayy.csv", status='unknown')
open(newunit=pp_azx, file="pp.azx.csv", status='unknown')
open(newunit=pp_azz, file="pp.azz.csv", status='unknown')
open(newunit=pp_ckp, file="pp.ckp.csv", status='unknown')
open(newunit=pp_d, file="pp.d.csv", status='unknown')
open(newunit=pp_dsg, file="pp.dsg.csv", status='unknown')
open(newunit=pp_dt, file="pp.dt.csv", status='unknown')
open(newunit=pp_mskn, file="pp.mskn.csv", status='unknown')
open(newunit=pp_mssn, file="pp.mssn.csv", status='unknown')
open(newunit=pp_p, file="pp.p.csv", status='unknown')
open(newunit=pp_r, file="pp.r.csv", status='unknown')
open(newunit=pp_ref2, file="pp.ref2.csv", status='unknown')
open(newunit=pp_ref3, file="pp.ref3.csv", status='unknown')
open(newunit=pp_rp, file="pp.rp.csv", status='unknown')
open(newunit=pp_sgt, file="pp.sgt.csv", status='unknown')
open(newunit=pp_sgte, file="pp.sgte.csv", status='unknown')
open(newunit=pp_sgtl, file="pp.sgtl.csv", status='unknown')
open(newunit=pp_sgtr, file="pp.sgtr.csv", status='unknown')
open(newunit=pp_sgtt, file="pp.sgtt.csv", status='unknown')

!read input and write to output
!write header line on output files
write(np_dat_output,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_dat_output,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
!separated files
write(np_a,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_alfa,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_at,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_ayy,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_azz,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_d,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_dosk,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_dsg_star,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_dsg,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_dt,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_dtrt,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_nnkk,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_nskn,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_nssn,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_p,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_r,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_ref2,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_ref3,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_rpt,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_rt,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_sgt,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_sgtl,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_sgtr,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(np_sgtt,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_a,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_alfa,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_ap,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_axx,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_ayy,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_azx,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_azz,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_ckp,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_d,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_dsg,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_dt,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_mskn,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_mssn,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_p,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_r,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_ref2,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_ref3,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_rp,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_sgt,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_sgte,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_sgtl,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_sgtr,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"
write(pp_sgtt,6) "energy", ',', "scattering_angle", ',', "experimental_value", ',',&
    &"statistical_error", ',', "reaction_type", ',',"observable", ',', "systematic_error", ',',&
    &"normalization"

!np data
np_line=1 !initialize at line 1
do
    read(np_dat_input,3,end=25) base_lab_energy, collected_data_points, &
    & systematic_error, normalization, dummy_string, reaction_type, observable
    if (base_lab_energy > 350.0) exit
    read(np_dat_input,*) !bibliographic line
    do z=1, collected_data_points
        read(np_dat_input,4) lab_energy, scattering_angle, experimental_value, statistical_error !4 columns of data
        write(np_dat_output,5) lab_energy, ',', scattering_angle, ',', &
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', &
            & observable, ',', systematic_error, ',', normalization !ouput to .csv file
!if statements used to output to separated files depending on observable type
        if (observable == '   A  ') write(np_a,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   ALFA') write(np_alfa,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   AT  ') write(np_at,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   AYY ') write(np_ayy,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   AZZ ') write(np_azz,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   D   ') write(np_d,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   D0SK') write(np_dosk,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   DSG*') write(np_dsg_star,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   DSG ') write(np_dsg,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   DT  ') write(np_dt,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   DTRT') write(np_dtrt,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   NNKK') write(np_nnkk,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   NSKN') write(np_nskn,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   NSSN') write(np_nssn,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   P   ') write(np_p,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   R   ') write(np_r,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   REF2') write(np_ref2,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   REF3') write(np_ref3,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   RPT ') write(np_rpt,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   RT  ') write(np_rt,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   SGT ') write(np_sgt,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   SGTL') write(np_sgtl,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   SGTR') write(np_sgtr,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   SGTT') write(np_sgtt,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
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
        write(pp_dat_output,5) lab_energy, ',', scattering_angle, ',', experimental_value, ',', &
            & statistical_error, ',', reaction_type, ',', observable, ',', &
            & systematic_error, ',', normalization !ouput to .csv file
!if statements used to output to separated files depending on observable type
        if (observable == '   A  ') write(pp_a,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   ALFA') write(pp_alfa,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   AP  ') write(pp_ap,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   AXX ') write(pp_axx,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   AYY ') write(pp_ayy,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   AZX ') write(pp_azx,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   AZZ ') write(pp_azz,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   CKP ') write(pp_ckp,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   D   ') write(pp_d,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   DSG ') write(pp_dsg,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   DT  ') write(pp_dt,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   MSKN') write(pp_mskn,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   MSSN') write(pp_mssn,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   P   ') write(pp_p,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   R   ') write(pp_r,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   REF2') write(pp_ref2,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   REF3') write(pp_ref3,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   RP  ') write(pp_rp,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   SGT ') write(pp_sgt,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   SGTE') write(pp_sgte,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   SGTL') write(pp_sgtl,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   SGTR') write(pp_sgtr,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
        if (observable == '   SGTT') write(pp_sgtt,5) lab_energy, ',', scattering_angle, ',',&
            & experimental_value, ',', statistical_error, ',', reaction_type, ',', observable, ',',&
            & systematic_error, ',', normalization
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

end program convert
