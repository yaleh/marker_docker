# Marker Docker

This repository contains a Dockerfile designed for creating a Docker image of the tool [Marker](https://github.com/VikParuchuri/marker), which enables quick and accurate conversion of PDF files to markdown format. The publicly hosted Docker image can be found on [Dockerhub](https://hub.docker.com/r/dibz15/marker_docker).

## Example

### Basic Usage

Use the following command for basic conversion:

```bash
docker run -i -t --rm --gpus '"device=0"' -v $PWD:/pdfs -v $PWD/local.env:/usr/src/app/marker/local.env yaleh/marker:latest poetry run python convert_single.py /pdfs/example.pdf /pdfs/example.md
```

### Customized Settings Example

To customize settings, create a `local.env` file with desired configurations:

```plaintext
~/work/pdf$ cat local.env
TESSDATA_PREFIX=/usr/share/tesseract-ocr/5/tessdata
OCR_ENGINE=tesseract
TORCH_DEVICE=cuda
DEFAULT_LANG=Chinese
```

Then, run the following command to utilize the customized settings:

```bash
~/work/pdf$ docker run -i -t --rm --gpus '"device=0"' -v $PWD:/pdfs -v $PWD/local.env:/usr/src/app/marker/local.env yaleh/marker:latest poetry run python convert_single.py /pdfs/example.pdf /pdfs/example.md
```