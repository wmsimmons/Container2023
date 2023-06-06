FROM python:3-alpine3.15
WORKDIR /flasktest
RUN apk add git
# uncomment line when testing solution and everything is on repo
# RUN git -c http.sslVerify=false clone "https://mike_automation:SHA256:fWUzaegJJnlvA4qfylPphVLLDMfR4vxDLlcVH3ZxecI@github.com/wmsimmons/Container2023.git" 
# uncomment this line if all code is hosted locally (not in git)
COPY . /flasktest
RUN pip3 install -r requirements.txt
EXPOSE 3000 5000 80
ENTRYPOINT [ "python" ]
CMD ["app.py"]
