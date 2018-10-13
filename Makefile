CODABASE := .codalab
.PHONY: run score pack get_data

all: run score

input/iris_train.data:
	if [[ ! -f input/data.zip ]] ; then \
		wget -O input/data.zip "https://lambda-yadro-cpu1.westeurope.cloudapp.azure.com:8080/my/datasets/download/e3a70c65-6798-46b3-a156-8153aabff191" ; \
	fi
	cd input ; unzip data.zip

clean:
	rm -rf input/* solution.zip *.pyc *.pickle output output_score

run: model.py input/iris_train.data
	python $(CODABASE)/ingestion_program/ingestion.py input output $(CODABASE)/ingestion_program .

score:
	python $(CODABASE)/scoring_program/score.py input output output_score

pack:
	zip solution.zip model.py metadata