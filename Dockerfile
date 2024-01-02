FROM nginx:alpine

COPY ./index.html /usr/share/nginx/html/index.html

COPY ./cpu_intensive_task.html /usr/share/nginx/html/cpu_intensive_task.html
