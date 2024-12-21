all: push

push:
	git add -A
	git commit -m "."
	git push
