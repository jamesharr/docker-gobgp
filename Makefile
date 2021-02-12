CNT_NAME=gobgp
IMAGE=pierky/gobgp

.PHONY: run
run:
	docker run -it --rm \
		--name $(CNT_NAME) \
		-v $(PWD)/conf:/etc/gobgp:rw \
		--network host \
		-e GOMAXPROCS=2 \
		$(IMAGE) \
		gobgpd -p -t yaml -f /etc/gobgp/gobgp.conf
		#--privileged \

.PHONY: shell
shell:
	docker exec -it $(CNT_NAME) bash

BVIEW = latest-bview.gz

.PHONY: load-global
load-global: $(BVIEW)
	docker cp $(BVIEW) $(CNT_NAME):/
	docker exec -it $(CNT_NAME) bash -lc 'gunzip /latest-bview.gz'
	docker exec -e GOMAXPROCS=1 -it $(CNT_NAME) bash -lc '/go/bin/gobgp mrt inject global /latest-bview'

$(BVIEW):
	curl --output $@ http://data.ris.ripe.net/rrc16/latest-bview.gz
