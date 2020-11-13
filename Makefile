CNT_NAME=gobgp
IMAGE=pierky/gobgp

.PHONY: run
run:
	docker run -it --rm \
		--name $(CNT_NAME) \
		-v $(PWD)/conf:/etc/gobgp:rw \
		--privileged \
		$(IMAGE) \
		gobgpd -p -t yaml -f /etc/gobgp/gobgp.conf

.PHONY: shell
shell:
	docker exec -it $(CNT_NAME) bash
