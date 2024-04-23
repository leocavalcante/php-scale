.PHONY: default
default: nginx php apply open

.PHONY: nginx
nginx:
	docker build -t php-scale-nginx -f nginx.Dockerfile .
	minikube image load php-scale-nginx

.PHONY: php
php:
	docker build -t php-scale -f Dockerfile .
	minikube image load php-scale

.PHONY: apply
apply:
	minikube kubectl -- create namespace php-scale --dry-run=client -o yaml | minikube kubectl -- apply -f -
	minikube kubectl -- -n php-scale apply -f $(TARGET).yaml

.PHONY: open
open:
	open $$(minikube service -n php-scale $(TARGET) --url)

.PHONY: load
load:
	ab -c $$(sysctl -n hw.logicalcpu) -n 100 $$(minikube service -n php-scale $(TARGET) --url)/ > results/$(TARGET)-100.txt
	ab -c $$(sysctl -n hw.logicalcpu) -n 1000 $$(minikube service -n php-scale $(TARGET) --url)/ > results/$(TARGET)-1000.txt
	ab -c $$(sysctl -n hw.logicalcpu) -n 10000 $$(minikube service -n php-scale $(TARGET) --url)/ > results/$(TARGET)-10000.txt

.PHONY: clean
clean:
	minikube kubectl -- delete namespace php-scale
	minikube image rm php-scale
	minikube image rm php-scale-nginx
