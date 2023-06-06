FROM python:3-alpine3.15
WORKDIR /flasktest
COPY . /flasktest
RUN pip3 install -r requirements.txt
EXPOSE 5000
ENV FLASK_APP=app.py

ENTRYPOINT [ "python" ]
CMD [ "app.py" ]
