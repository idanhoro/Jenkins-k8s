FROM python:3.11

WORKDIR /app

COPY . .

RUN pip3 install --no-cache-dir -r src/requirements.txt

ENV FLASK_APP=app

EXPOSE 5001

CMD ["python", "src/app.py"]