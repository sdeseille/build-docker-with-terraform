# Start from the official Python base image.
FROM python:3.9

# Set the current working directory to /code. This is where we'll put the requirements.txt file and the app directory.
WORKDIR /code

# Copy the file with the requirements to the /code directory. Copy only the file with the requirements first, not the rest of the code.
COPY ./requirements.txt /code/requirements.txt

# Install the package dependencies in the requirements file.
# The --no-cache-dir option tells pip to not save the downloaded packages locally, as that is only if pip was going to be run again to install the same packages, but that's not the case when working with containers.
# The --upgrade option tells pip to upgrade the packages if they are already installed.
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Copy the ./app directory inside the /code directory.
# As this has all the code which is what changes most frequently the Docker cache won't be used for this or any following steps easily.
COPY ./app /code/app

# Set the command to run the uvicorn server.
# If you are running your container behind a TLS Termination Proxy (load balancer) like Nginx or Traefik, add the option --proxy-headers, this will tell Uvicorn to trust the headers sent by that proxy telling it that the application is running behind HTTPS, etc.
CMD ["uvicorn", "app.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "80"]
