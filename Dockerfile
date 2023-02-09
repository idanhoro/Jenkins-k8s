FROM python:3.9
COPY main.py /src/
WORKDIR /src/
CMD ["python", "src/main.py"]
