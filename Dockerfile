FROM node:16-alpine as npm-install
WORKDIR /src
# copia apenas os package.json e package-lock.json
COPY src/package*.json .
RUN npm install --silent
#Copia o resto da aplicação
COPY src/. .

FROM npm-install as npm-run
WORKDIR /src
EXPOSE 8080
ENTRYPOINT [ "npm" ]
CMD [ "start" ]
HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
    CMD wget -nv -t1 --spider 'http://localhost:8080/health' || exit 1
