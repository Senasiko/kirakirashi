FROM rust:latest

WORKDIR /app

EXPOSE 8080

RUN apt-get update && apt-get install nginx -y

RUN echo "server { listen 8080; root /app/book; absolute_redirect off; location / { add_header 'Access-Control-Allow-Origin' '*'; if ($request_method = 'OPTIONS') { return 204; } } }"> /etc/nginx/conf.d/default.conf

COPY . /app

RUN cargo install mdbook
RUN mdbok build

CMD [ "service", "nginx", "start" ]
