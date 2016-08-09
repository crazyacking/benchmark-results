#!/bin/bash

# files for the short benchmarks: sysbench-ssd-wt-uniform-48-oltp.txt
echo "engine,disk,distribution,"$(env _ONLYHEADER=1 csv_from_sysbench.sh ../raw/sysbench-ssd-inmemory-uniform-256-oltp.txt wt_vs_im 20000000 256) > ../data-short-benchmarks.csv

for disk in hdd ssd; do
    for engine in inmemory wt; do
	for workload in oltp insert write_only; do # maybe add insert too
	    for distribution in uniform pareto; do
		for threads in 256 128 48; do
		    env _NOHEADER=1 csv_from_sysbench.sh ../raw/sysbench-$disk-$engine-$distribution-$threads-$workload.txt $workload 20000000 $threads | while read l; do
																			echo $engine,$disk,$distribution,$l
																			done >> ../data-short-benchmarks.csv
		done # for threads in ...
	    done # for distribution in ...
	done # for workload in ...
    done # for engine in ...
done #for disk in ...

# benchmarks emulating sysbench-mongodb: sysbench-ssd-inmemory-pareto-16-oltp.txt

echo "engine,distribution,"$(env _ONLYHEADER=1 csv_from_sysbench.sh ../raw/sysbench-ssd-inmemory-pareto-16-oltp.txt wt_vs_im 20000000 512) > ../data-sysbench-mongodb-benchmarks.csv
for engine in inmemory wt; do
    for threads in 32 24 16; do
	for distribution in uniform pareto; do
	    env _NOHEADER=1 csv_from_sysbench.sh ../raw/sysbench-ssd-$engine-$distribution-$threads-oltp.txt oltp 20000000 $threads | while read l; do
																	  echo $engine,$distribution,$l >> ../data-sysbench-mongodb-benchmarks.csv
																	  done
	done # for distribution in ...
    done # for threads in ...
done # for engine in ...


# files for the long benchmarks: sysbench-long-inmemory-pareto-128-oltp.txt

# echo "engine,distribution,"$(env _ONLYHEADER=1 csv_from_sysbench.sh ../raw/sysbench-long-inmemory-pareto-128-oltp.txt wt_vs_im 20000000 512) > ../data-long-benchmarks.csv
# 
# for engine in inmemory wt; do
# 	for distribution in uniform pareto; do
# 	        threads=128; workload=oltp
# 		env _NOHEADER=1 csv_from_sysbench.sh ../raw/sysbench-long-$engine-$distribution-$threads-$workload.txt $workload 20000000 $threads | while read l; do
# 																		    echo $engine,$distribution,$l
# 																		     done >> ../data-long-benchmarks.csv
# 	done # for distribution in ...
# done # for engine in ...


echo "engine,distribution,"$(env _ONLYHEADER=1 csv_from_sysbench.sh ../raw/sysbench-ssd-inmemory-pareto-24-oltp.txt wt_vs_im 20000000 24) > ../data-long-benchmarks.csv

for engine in inmemory wt; do
	for distribution in uniform pareto; do
	    for workload in oltp insert write_only; do
	        threads=24
		env _NOHEADER=1 csv_from_sysbench.sh ../raw/sysbench-ssd-$engine-$distribution-$threads-$workload.txt $workload 20000000 $threads | while read l; do
																		    echo $engine,$distribution,$l
																		     done >> ../data-long-benchmarks.csv
	    done # for workload in ...
	done # for distribution in ...
done # for engine in ...
