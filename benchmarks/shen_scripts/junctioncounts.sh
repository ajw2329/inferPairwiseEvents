##create event gtf

topdir=/public/groups/sanfordlab/people/anjowall/projects/rtpcr_validated/shen_2014/
stringtie_dir=$topdir/stringtie/
stringtie_merged_path=$stringtie_dir/all_merged.gtf
bamdir=$topdir/bam/
junctioncountsdir=$topdir/junctioncounts/

mkdir -p $junctioncountsdir

python2.7 ~/repos/multiSpeciesAS/infer_pairwise_events.py --transcript_gtf $stringtie_merged_path --outdir $stringtie_dir


for i in $bamdir/*.bam; do python2.7 ~/repos/multiSpeciesAS/junctionCounts_WIP_bam.py --event_gtf $stringtie_dir/splice_lib_events.gtf --bam "$i" --forward_read unstranded --outdir $junctioncountsdir --event_ioe $stringtie_dir/splice_lib_events.ioe --calc_gene_frac --sample_name $(echo "$i" | awk -F\/ '{ print $NF}' | awk -F"_" '{ print $1}') & done > $junctioncountsdir/stdout.txt 2> $junctioncountsdir/stderr.txt
