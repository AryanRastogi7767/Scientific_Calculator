FROM python:3.9-slim
WORKDIR /app
COPY calculator.py /app/
CMD ["python", "calculator.py"]

