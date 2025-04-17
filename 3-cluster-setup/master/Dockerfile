FROM nginx:stable

# custom config 넣을 디렉토리 생성
RUN mkdir -p /etc/nginx 

COPY nginx-stream-30080-30443.conf /etc/nginx/nginx.conf

EXPOSE 80 443

