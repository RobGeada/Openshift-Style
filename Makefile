USERNAME=$(shell docker info | sed '/Username:/!d;s/.* //')

build:
	docker build -t $(USERNAME)/style:$(tag) .
	docker push $(USERNAME)/style:$(tag)
	oc new-app --docker-image $(USERNAME)/style:$(tag) --name style-$(tag)

clean:
	oc delete dc style-$(tag)
	oc delete imagestream style-$(tag)
	docker rmi $(USERNAME)/style:$(tag)