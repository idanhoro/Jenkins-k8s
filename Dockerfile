FROM python:3.9
COPY ./ ./mission2
WORKDIR /src/
CMD ["python", "src/main.py"]
