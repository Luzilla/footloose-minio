NETWORK:=minio-cluster

.PHONY: start-cluster
start-cluster:
	#mkdir -p ./minio-data0 ./minio-data1 ./minio-data2 ./minio-data3
	docker network create $(NETWORK) || true
	footloose create

.PHONY: start
start: start-cluster install
	$(info Cluster started...)
	$(info Please wait, and proceed to `make debug`)

.PHONY: restart
restart: clean start

.PHONY: install
install:
	ansible-galaxy install -f -r ansible/requirements.yml
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES ansible-playbook ansible/playbook.yml

.PHONY: debug
debug:
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES ansible-playbook ansible/debug.yml

.PHONY: clean
clean:
	footloose delete
	docker network rm $(NETWORK) || true
	mc config host rm footloose-haproxy
	mc config host rm footloose-minio0-0
	mc config host rm footloose-minio1-0
	mc config host rm footloose-minio2-0
	mc config host rm footloose-minio3-0
	rm -rf ./minio-data*
