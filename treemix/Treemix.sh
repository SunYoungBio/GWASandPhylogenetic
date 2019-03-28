############################
##### Treemix pipeline #####
#License: GPLv3 or later
#Modification date: 2017-10-10
#Written by: Elia Vajana, Marco Milanesi
#Contact: Elia Vajana <vajana.elia@gmail.com>, Marco Milanesi <marco.milanesi.mm@gmail.com>
#Description: Run Treemix software
############################
infile=$1 		    ## binary plink file no extension
numk=$2 		    ## max number of migration you want to model
ncore=$3 		    ## max number of cores to use
blockk=$4 		    ## block size
outgroup=$5 	    ## name of the selected outgroup population (if you want to do an unrooted ML tree put here 'NoOutgroup' (without quotes))
plink=$6		    ## plink alias # only plink v1.9 is allow
chr=$7              ## number of autosomal chr
pathP2T=$8		    ## path where "plink2treemix.py" script is
f3=$9			    ## TRUE/FALSE
f4=${10}			## TRUE/FALSE
outname=${11}		## name for output file

##########################################################################################
#########################
##### Settings file #####
#########################
echo "Input file name = $1" > $outname"_Settings.txt"
echo "Output file name = ${10}" >> $outname"_Settings.txt"
echo "Max number of migrations modeled = $2" >> $outname"_Settings.txt"
echo "Number of SNPS per block = $4" >> $outname"_Settings.txt"
if [ $outgroup = "NoOutgroup" ]; then
	echo "Unrooted ML tree" >> $outname"_Settings.txt"
else
	echo "Outgroup = $5" >> $outname"_Settings.txt"
fi
echo "F stats --> f3 "$f3" ; f4 "$f4 >> $outname"_Settings.txt"
echo "Populations and consistencies" >> $outname"_Settings.txt"
cut -d" " -f1 $infile".fam" | sort | uniq -c >> $outname"_Settings.txt"
echo >> $outname"_Settings.txt"
echo >> $outname"_Settings.txt"



#####################################
##### 1. preparation input file #####
#####################################
echo "**** PREPARATION INPUT FILE ****"
$plink --noweb --chr-set $chr --silent --bfile $infile --freq --missing --family --out $outname"_freq"
gzip -f $outname"_freq.frq.strat"
python $pathP2T/plink2treemix.py $outname"_freq.frq.strat.gz" $outname"_Input_treemix.frq.gz"

echo "Check for missing SNPs per population" 
gunzip $outname"_Input_treemix.frq.gz"

echo "Number of SNPs before checking:" >> $outname"_Settings.txt"
tail -n +2 $outname"_Input_treemix.frq" | wc -l >> $outname"_Settings.txt"

echo "Missing SNPs identified"
grep " 0,0 " $outname"_Input_treemix.frq"
sed -i '/ 0,0 /d' $outname"_Input_treemix.frq"

echo "Number of SNPs after cheking:" >> $outname"_Settings.txt"
tail -n +2 $outname"_Input_treemix.frq" | wc -l >> $outname"_Settings.txt"
gzip $outname"_Input_treemix.frq" 

echo "**** PREPARATION INPUT FILE: DONE ****"



##############################
##### 2. running treemix #####
##############################

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### N.B. If you need to modify the treemix parameters please do it here ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

echo "**** RUNNING TREEMIX ****"
if [ $outgroup = "NoOutgroup" ]; then
	seq 0 $numk | parallel -j$ncore treemix -i $outname"_Input_treemix.frq.gz" -k $blockk -se -m {} -o $outname"_"{} > $outname"_logfile_treemix.log"
else
	seq 0 $numk | parallel -j$ncore treemix -i $outname"_Input_treemix.frq.gz" -root $outgroup -k $blockk -se -m {} -o $outname"_"{} > $outname"_logfile_treemix.log"
fi
echo "**** RUNNING TREEMIX: DONE ****"



###################################
##### 3. f3 and f4 statistics #####
###################################
echo "**** f STATISTICS ****"
# f3 statistics
if [ $f3 = "TRUE" ]; then
	threepop -i $outname"_Input_treemix.frq.gz" -k $blockk > $outname"_f3statistics.txt"
fi
# f4 statistics
if [ $f4 = "TRUE" ]; then
	fourpop -i $outname"_Input_treemix.frq.gz" -k $blockk > $outname"_f4statistics.txt"
fi

echo "**** f STATISTICS: DONE ****"


echo "TreeMix Analysis FINISHED"
