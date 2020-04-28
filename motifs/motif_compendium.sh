step=$1

DATA=/ahg/regevdata/projects/Cell2CellCommunication/data
DATA_MOTIFS=${DATA}/motifs/hg38/altius_archetypes/
mkdir -p ${DATA_MOTIFS}

if [[ ${step} == "get_vierstra_motif_scans" ]];
then
    
    bgzip_file="https://resources.altius.org/~jvierstra/projects/motif-clustering/releases/v1.0/hg38.all_motifs.v1.0.bed.gz"
    tabix_file="https://resources.altius.org/~jvierstra/projects/motif-clustering/releases/v1.0/hg38.all_motifs.v1.0.bed.gz.tbi"
    bigbed_file="https://resources.altius.org/~jvierstra/projects/motif-clustering/releases/v1.0/hg38.all_motifs.v1.0.bb"

    bgzip_arch="https://resources.altius.org/~jvierstra/projects/motif-clustering/releases/v1.0/hg38.archetype_motifs.v1.0.bed.gz"
    tabix_arch="https://resources.altius.org/~jvierstra/projects/motif-clustering/releases/v1.0/hg38.archetype_motifs.v1.0.bed.gz.tbi"
    bigbed_arch="https://resources.altius.org/~jvierstra/projects/motif-clustering/releases/v1.0/hg38.archetype_motifs.v1.0.bb"
    for li in bgzip_file tabix_file bigbed_file bgzip_arch tabix_arch bigbed_arch;
    do
	cd ${DATA_MOTIFS}
	wget ${li}
    done
fi
