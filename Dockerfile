FROM python:3.9
COPY ./ ./mission2
WORKDIR /mission2/
CMD ["python", "src/main.py"]
