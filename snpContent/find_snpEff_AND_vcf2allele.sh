IFS=$'\n'
for line in `cat target_segments.bed`
do
chr=`echo $line | cut -f 1`
from=`echo $line | cut -f 2 `
to=`echo $line | cut -f 3 `
#mkdir $chr'_'$from'_'$to
#vcftools --vcf ../381.irgsp1.1.ann.vcf --chr Chr$chr --from-bp $from --to-bp $to --out ./$chr'_'$from'_'$to/chr$chr'_'$from'_'$to --recode --recode-INFO-all &
#done
in=./$chr'_'$from'_'$to/chr$chr'_'$from'_'$to'.recode.vcf'	#input vcf file
python2 ~/bin/vcf2phylip.py -i $in -p -f
cat ${in%.vcf}.min4.fasta | paste - - | sed 's/>//' > ${in%.vcf}.allele
done
