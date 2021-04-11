FROM python:3.8.5
WORKDIR /app
COPY . .
RUN python3 -m pip install --upgrade pip \
    && pip install -r requirements.txt --no-cache-dir \
    && python3 manage.py collectstatic --no-input \
