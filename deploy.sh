docker build -t arunreddy2786/multi-client:latest -t arunreddy2786/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arunreddy2786/multi-worker:latest -t arunreddy2786/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t arunreddy2786/multi-server:latest -t arunreddy2786/multi-server:$SHA -f ./server/Dockerfile ./server

docker push arunreddy2786/multi-client:latest
docker push arunreddy2786/multi-server:latest
docker push arunreddy2786/multi-worker:latest

docker push arunreddy2786/multi-server:$SHA
docker push arunreddy2786/multi-client:$SHA
docker push arunreddy2786/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment fibonacci-server=arunreddy2786/multi-server:$SHA
kubectl set image deployments/worker-deployment fibonacci-worker=arunreddy2786/multi-worker:$SHA
kubectl set image deployments/client-deployment fibonacci-client=arunreddy2786/multi-client:$SHA