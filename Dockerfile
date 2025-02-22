FROM ubuntu:latest
WORKDIR /app
COPY calculator.py /app/
RUN chmod +x /app/calculator.py
CMD ["python", "calculator.py"]

