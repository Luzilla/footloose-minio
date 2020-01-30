.PHONY: start-cluster
start-cluster:
	docker network create minio-cluster || true
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
