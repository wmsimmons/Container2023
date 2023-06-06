FROM python:3-alpine3.15
WORKDIR /flasktest
RUN apk add git
RUN git clone "https://wmsimmons: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@github.com/wmsimmons/Container2023.git" 
COPY . /flasktest
RUN pip3 install -r requirements.txt
EXPOSE 3000 5000 80
ENTRYPOINT [ "python" ]
CMD ["app.py"]
