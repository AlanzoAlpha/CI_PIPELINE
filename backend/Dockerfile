#Use Python Image
FROM python:3.7
#Make working directory and store it in image called "app"
WORKDIR /app
# Install apt dependencies

# Copy contents into image
COPY . .
# run pip dependencies
RUN pip3 install -r requirements.txt
# Expose correct port
EXPOSE 5001
# Create an entrypoint
ENTRYPOINT ["python3", "app.py"]
