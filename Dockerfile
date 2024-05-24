# Use an official CUDA runtime as a parent image
#FROM docker.io/nvidia/cuda:12.4.1-cudnn-runtime-ubuntu22.04
FROM docker.io/nvidia/cuda:11.6.1-cudnn8-runtime-ubuntu20.04

# Set environment variables to configure tzdata non-interactively
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Set the working directory in the container
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python3 -m venv venv

# Activate the virtual environment and install dependencies
RUN . venv/bin/activate && pip install --upgrade pip
COPY requirements.txt .
RUN . venv/bin/activate && pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app

# Make port 7860 available to the world outside this container
EXPOSE 7860

# Run app.py when the container launches
CMD ["sh", "-c", ". venv/bin/activate && python3 app.py"]

