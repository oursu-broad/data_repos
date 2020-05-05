step=$1

DATA=/ahg/regevdata/projects/Cell2CellCommunication/data/encode/2020_05_05
mkdir -p ${DATA}

if [[ ${step} == "download_peaks" ]];
then
    echo "go and select the datasets of interest from the ENCODE website at https://www.encodeproject.org/"
    echo "click download. use the top link to download the metadata file"
    f="https://www.encodeproject.org/metadata/?type=Experiment&status=released&replicates.library.biosample.donor.organism.scientific_name=Homo+sapiens&assay_title=Histone+ChIP-seq&assay_title=TF+ChIP-seq&files.file_type=bed+narrowPeak&assembly=GRCh38"
    echo "wget -O ${DATA}/ChIP.peaks.metadata.csv \"${f}\""
fi

if [[ ${step} == "download_optimal_IDR" ]];
then
    idr_metadata=${DATA}/ChIP.peaks.metadata.optimalIDR.csv
    #zcat -f ${DATA}/ChIP.peaks.metadata.csv | head -n1 > ${idr_metadata}
    zcat -f ${DATA}/ChIP.peaks.metadata.csv | grep optimal | grep IDR > ${idr_metadata}

    mkdir -p ${DATA}/chipseq/

    #loop through the lines in idr metadata, download and save with a nice name
    while IFS= read -r line
    do
	id=$(echo "${line}" | cut -f1)
	cell=$(echo "${line}" | cut -f10 | sed 's/ //g')
	TF=$(echo "${line}" | cut -f22 | cut -d "-" -f1)
	file2download=$(echo "${line}" | cut -f46)
	fname=${DATA}/chipseq/${cell}.${TF}.${id}.optimalIDR.bed.gz
	echo "${fname} from ${file2download}"
	cmd="wget -O ${fname} ${file2download}"
	${cmd}
    done < "${idr_metadata}"
fi
