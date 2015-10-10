#!/bin/bash
echo "Building image"
docker build -t crawler_bench .

N=5

containers=()

echo "Creating containers"
for i in $(seq "$N")
do
    containers+=($(docker create crawler_bench))
done

pids=()
echo "Starting containers"
time (
for c in ${containers[@]}
do
    echo "Starting $c"
    docker start "$c"
    docker attach "$c" &
    pids+=($!)
done

for pid in ${pids[@]}
do
    echo "started-> $pid"
    wait $pid
    echo "done-> $pid"
done)

docker rm $(docker ps -a | grep crawler_bench | awk '{print $1}')

exit 0
