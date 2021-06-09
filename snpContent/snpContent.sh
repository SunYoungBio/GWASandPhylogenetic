vcffile=$1
class=$2
grep -P 'missense_variant|#CHROM' $vcffile | sed 's/AC.*\(ANN\)/\1/' | sed -e 's/0\/0:[^\t]*/Ref/g' -e 's/0\/1:[^\t]*/Het/g' -e 's/1\/1:[^\t]*/Hom/g' -e 's/\.\/\.:[^\t]*/Mis/g' > ${vcffile%.vcf}.targetSNPcontent.txt
numf=`head -n1 ${vcffile%.vcf}.targetSNPcontent.txt | awk '{print NF}'`
echo "you have column "$numf
for i in `seq 1 $numf`;do cut -f $i ${vcffile%.vcf}.targetSNPcontent.txt | paste -s; done > ${vcffile%.vcf}.targetSNPcontent.tr.txt
awk 'NR==FNR{a[$1]=$0;next}a[$1]{print a[$1]"\t"$2}' ${vcffile%.vcf}.targetSNPcontent.tr.txt $class > ${vcffile%.vcf}.targetSNPcontent.tr.class.txt
cut -f 1-2,4-5 ${vcffile%.vcf}.targetSNPcontent.txt | sed -e '1d' -e 's/\t/_/g' > snpName.txt
n=2
cat snpName.txt | while read snp; do awk '{print "'$snp'\t"$NF"\t"$'$n'}' ${vcffile%.vcf}.targetSNPcontent.tr.class.txt; let n++; done > ${vcffile%.vcf}.targetSNPcontent.plot.txt
