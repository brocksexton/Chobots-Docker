FROM webratio/ant:1.10.1 AS builder
COPY . /client
WORKDIR /client
RUN chmod +x flex/bin/fcsh
RUN ant

FROM nginx:1.15-alpine

COPY --from=builder /client/bin/* /client/bin/
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./website /usr/share/nginx/html/

CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80