# build environment
FROM node:12 as builder
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN npm install
RUN npm run build

# production environment
FROM nginx:alpine-perl
RUN rm -rf /etc/nginx/conf.d
COPY /etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /usr/src/app/dist/demo-app /usr/share/nginx/html
CMD sed -i -e "s/ENV_PORT/$PORT/g" /etc/nginx/nginx.conf && nginx -g "daemon off;"
