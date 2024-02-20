# Marker Docker

A CUDA ready docker image for tool [Marker](https://github.com/VikParuchuri/marker), which enables quick and accurate conversion of PDF files to markdown format. The publicly hosted Docker image can be found on [GitHub](https://github.com/yaleh/marker_docker/pkgs/container/marker).

## Example

### Basic Usage

Use the following command for basic conversion:

```bash
docker run -i -t --rm --gpus '"device=0"' -v $PWD:/pdfs -v $PWD/local.env:/usr/src/app/marker/local.env ghcr.io/yaleh/marker:main poetry run python convert_single.py /pdfs/example.pdf /pdfs/example.md
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
~/work/pdf$ docker run -i -t --rm --gpus '"device=0"' -v $PWD:/pdfs -v $PWD/local.env:/usr/src/app/marker/local.env ghcr.io/yaleh/marker:main poetry run python convert_single.py /pdfs/example.pdf /pdfs/example.md
```