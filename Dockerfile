FROM python:3.9-slim
WORKDIR /app
COPY calculator.py /app/
RUN chmod +x /app/calculator.py
CMD ["python", "calculator.py"]

