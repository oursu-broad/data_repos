
step=$1

gtf=/seq/regev_genome_portal/SOFTWARE/10X/refdata-cellranger-1.2.0/refdata-cellranger-GRCh38-1.2.0/genes/genes.gtf
DATA=/ahg/regevdata/projects/Cell2CellCommunication/data/genomes/hg38/promoters
promoters=${DATA}/hg38.TSS

if [[ ${step} == "get_promoters" ]];
then
    cd ${DATA}
    cp /seq/regev_genome_portal/SOFTWARE/10X/refdata-cellranger-1.2.0/refdata-cellranger-GRCh38-1.2.0/star/chrNameLength.txt ${DATA}/hg38.chrSizes
    zcat -f ${DATA}/hg38.chrSizes | awk '{print "chr"$0}' > ${DATA}/hg38.chrSizes.chr
    #get gtf on hg19 of the TSSs, convert to bed file of promoters
    zcat -f ${gtf} | grep -w gene | awk -F'\t' '{if ($7=="+") print "chr"$1"\t"$4"\t"($4+1)"\t"$9"\t0\t+"}' | sed 's/gene_name\ /\t/g' | sed 's/; gene_source/\t/g' | cut -f1,2,3,5,7,8 | sed 's/"//g' > ${promoters}.tmp
    zcat -f ${gtf} | grep -w gene | awk -F'\t' '{if ($7=="-") print "chr"$1"\t"($5-1)"\t"$5"\t"$9"\t0\t+"}' | sed 's/gene_name\ /\t/g' | sed 's/; gene_source/\t/g' | cut -f1,2,3,5,7,8 | sed 's/"//g' >> ${promoters}.tmp
    source /broad/software/scripts/useuse
    use BEDTools
    for promoter_size in 5000 10000 20000 50000 100000;
    do
        promoter_file=${promoters}.size${promoter_size}.bed.gz
        bedtools slop -l ${promoter_size} -r 0 -i ${promoters}.tmp -g ${DATA}/hg38.chrSizes.chr | gzip > ${promoter_file}
        zcat -f ${promoter_file} | wc -l
        echo ${promoter_file}
    done
    rm ${promoters}.tmp
fi

