source package 094d7aa4-fcb1-4cb6-aaaa-60e8a1c33a3b (bigWigToBedGraph 366)


ei-medium

bash /ei/software/cb/rapid_curation_sanger/x86_64/bin/rc_suite.sh -p gap,repeat -t UrochloaDecumbens -w /ei/.project-scratch/d/df141853-c5bd-4514-96f5-dbced5c97fd0/results/022023_data_for_Sanger -d /ei/.project-scratch/d/df141853-c5bd-4514-96f5-dbced5c97fd0/results/022023_data_for_Sanger

cat UrochloaDecumbens/gap/UrochloaDecumbens_gap.bedgraph | singularity exec ~/software_workshop/images/pretextgraph.img /opt/miniconda3/bin/PretextGraph -i pretext_q30_r1000.TXT -n "gap track"
bigWigToBedGraph UrochloaDecumbens_repeat_density.bw /dev/stdout | singularity exec ~/software_workshop/images/pretextgraph.img /opt/miniconda3/bin/PretextGraph -i pretext_q30_r1000.TXT -n "repeat track"
