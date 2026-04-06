# Use Python 3.9 slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy service code
COPY service/ ./service/

# Create non-root user
RUN useradd --create-home theia

# Change ownership of app directory
RUN chown -R theia:theia /app

# Switch to non-root user
USER theia

# Expose port
EXPOSE 8080

# Run the application
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]