docker build -t acdnilaprasad/multi-client:latest -t acdnilaprasad/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t acdnilaprasad/multi-server:latest -t acdnilaprasad/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t acdnilaprasad/multi-worker:latest -t acdnilaprasad/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push acdnilaprasad/multi-client:latest
docker push acdnilaprasad/multi-server:latest
docker push acdnilaprasad/multi-worker:latest

docker push acdnilaprasad/multi-client:$SHA
docker push acdnilaprasad/multi-server:$SHA
docker push acdnilaprasad/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=acdnilaprasad/multi-server:$SHA
kubectl set image deployments/client-deployment client=acdnilaprasad/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=acdnilaprasad/multi-worker:$SHA