[ -f summary.log ] && mv summary.log "old_summary_$(date +"%m_%d_%Y").log"
echo "# iteration, batch loss, average loss, learning rate, time, accumulated batch" >> summary.log
for file in $(ls | sort | grep job);do
  cat $file | grep images >> summary.log 
done
