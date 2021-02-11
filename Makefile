CNT_NAME=gobgp
IMAGE=pierky/gobgp

.PHONY: run
run:
	docker run -it --rm \
		--name $(CNT_NAME) \
		-v $(PWD)/conf:/etc/gobgp:rw \
		--network host \
		--privileged \
		$(IMAGE) \
		gobgpd -p -t yaml -f /etc/gobgp/gobgp.conf

.PHONY: shell
shell:
	docker exec -it $(CNT_NAME) bash

BVIEW = latest-bview.gz

.PHONY: load-global
load-global: $(BVIEW)
	docker cp $(BVIEW) $(CNT_NAME):/
	docker exec -it $(CNT_NAME) bash -lc '/go/bin/gobgp mrt inject global <(zcat /latest-bview.gz)'

$(BVIEW):
	curl --output $@ http://data.ris.ripe.net/rrc16/latest-bview.gz
