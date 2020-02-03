docker build -t burrmit/multi-client:latest -t burrmit/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t burrmit/multi-server:latest -t burrmit/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t burrmit/multi-worker:latest -t burrmit/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push burrmit/multi-client:latest
docker push burrmit/multi-server:latest
docker push burrmit/multi-worker:latest
docker push burrmit/multi-client:$SHA
docker push burrmit/multi-server:$SHA
docker push burrmit/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=burrmit/multi-server:$SHA
kubectl set image deployments/client-deployment client=burrmit/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=burrmit/multi-worker:$SHA