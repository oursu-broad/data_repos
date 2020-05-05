step=$1

DATA=/ahg/regevdata/projects/Cell2CellCommunication/data/encode/2020_05_05/dhs
mkdir -p ${DATA}

#from https://www.meuleman.org/research/dhsindex/

if [[ ${step} == "1" ]];
then
    wget -O ${DATA}/DHS_Index_and_Vocabulary_hg38_WM20190703.txt.gz https://www.meuleman.org/DHS_Index_and_Vocabulary_hg38_WM20190703.txt.gz
fi

if [[ ${step} == "2" ]];
then
    wget -O ${DATA}/DHS_Index_and_Vocabulary_metadata.tsv https://www.meuleman.org/DHS_Index_and_Vocabulary_metadata.tsv
fi

if [[ ${step} == "3" ]];
then
    echo "download manually https://drive.google.com/uc?export=download&id=16wbuNmHnwsek3USWM04nR535vPavNZka and transfer over"
fi
