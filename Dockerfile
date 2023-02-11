FROM nginx:alpine
COPY ./webapp /usr/share/nginx/html
COPY ./webapp/images /usr/share/nginx/html/images
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

