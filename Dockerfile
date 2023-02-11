#using nginx webserver as base image with alpine linux
FROM nginx:alpine

#copying the webapp folder to the nginx webserver

COPY ./webapp /usr/share/nginx/html

#copying the images folder to the nginx webserver

COPY ./webapp/images /usr/share/nginx/html/images

#exposing the port 80 to the host machine

EXPOSE 80

#running the nginx webserver in  foreground mode to keep the container running without exiting

CMD ["nginx", "-g", "daemon off;"]

