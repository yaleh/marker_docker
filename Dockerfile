# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory in the container
WORKDIR /usr/src/app

# Install Tesseract
RUN apt-get update && \
    apt-get install -y lsb-release apt-transport-https wget ghostscript nano && \
    wget -qO - https://notesalexp.org/debian/alexp_key.asc | apt-key add - && \
    echo "deb https://notesalexp.org/tesseract-ocr5/$(lsb_release -cs)/ $(lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/notesalexp.list > /dev/null && \
    apt-get update -oAcquire::AllowInsecureRepositories=true && \
    apt-get install -y notesalexp-keyring --allow-unauthenticated && \
    apt-get update && \
    apt-get install -y tesseract-ocr libtesseract-dev libmagic1 ocrmypdf && \
    rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir poetry

# Clone the repository
RUN git clone https://github.com/VikParuchuri/marker.git
WORKDIR /usr/src/app/marker

# Install system requirements
# Note: Scripted installation of tesseract and ghostscript may need adjustments
RUN apt-get update && \
    apt-get install -y $(cat scripts/install/apt-requirements.txt) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Find the tessdata directory and create a local.env file with the TESSDATA_PREFIX
RUN tessdata_path=$(find / -name tessdata -print -quit) && \
    echo "TESSDATA_PREFIX=${tessdata_path}" > local.env

# Install Python dependencies
RUN poetry lock --no-update && poetry install --no-cache && rm -rf /root/.cache/pypoetry/artifacts

COPY . .

# Test converting and cache models
RUN poetry run python convert_single.py test.pdf test.md

# The command to run the application
ENV SHELL "/bin/bash"
CMD ["poetry", "shell"]
