# ==============================
# Base Image (CUDA Enabled)
# ==============================
FROM pytorch/pytorch:2.2.2-cuda11.8-cudnn8-runtime

# ==============================
# Set Working Directory
# ==============================
WORKDIR /app

# ==============================
# Install System Dependencies
# ==============================
RUN apt-get update && apt-get install -y \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# ==============================
# Copy Project Files
# ==============================
COPY train.py .
COPY evaluate.py .
COPY setB.pth .
COPY data.zip .
COPY requirements.txt .

# ==============================
# Install Python Dependencies
# ==============================
RUN pip install --no-cache-dir -r requirements.txt

# ==============================
# Extract Dataset
# ==============================
RUN unzip data.zip && rm data.zip

# ==============================
# Default Command
# ==============================
CMD ["python", "train.py"]
