	(base) [xjdang@login m4]$ cat ~/script/bootstrap.sh 
	migNum=$1
	root=$2
	#out=$root"_bsp1k_m"$migNum
	#echo $out
	~/software/treemix_scripts/Treemix_bootstrap.sh ../treemix.frq.gz $migNum 20 1000 $root 1000 ~/software/phylip-3.697/exe/consense $root"root_bsp1k_m"$migNum
	
	(base) [xjdang@login m3]$ bsub -e bootstrap.err -o bootstrap.log sh ~/script/bootstrap.sh 3 W
