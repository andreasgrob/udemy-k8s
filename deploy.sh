docker build -t andreasgrob/multi-client:latest -t andreasgrob/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t andreasgrob/multi-server:latest -t andreasgrob/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t andreasgrob/multi-worker:latest -t andreasgrob/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push andreasgrob/multi-client:latest
docker push andreasgrob/multi-server:latest
docker push andreasgrob/multi-worker:latest

docker push andreasgrob/multi-client:$GIT_SHA
docker push andreasgrob/multi-server:$GIT_SHA
docker push andreasgrob/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andreasgrob/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=andreasgrob/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=andreasgrob/multi-worker:$GIT_SHA