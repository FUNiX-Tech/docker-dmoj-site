# Dmoj docker compose cho phần site

--- :blush: :blush: :blush: ---

## Thư mục, file

1. `problems`: chứa problem test case data. 
2. `db`: database.
3. `example.db.env`: environment variables cho container mariadb. 
4. `example.db.env`: environemt variables cho dmoj site. 
5. `compose.yml`: file docker compose.
6. `site`: 
    - `bridged.conf`, `celery.conf`, `site.conf`, `wsevent.conf`: các file config cho supervisor để manage django site. Không sửa các file này.
    - `dmoj.nginx`: file nginx config. Không sửa file này.
    - `Dockerfile`: tạo image cho dmoj site. 
    - `start-dmoj.sh`: các commands được chạy khi tạo container site xong. 
    - `uwsgi.ini`: file config uwsgi. Sửa file này để tối ưu performance. 
    - `https`: key và cert cho https. Nếu đổi file thì nhớ đặt tên như cũ: `cert.crt`, `private.key`.


---

## Cài đặt

1. Config: 

Tạo folder `problems`, `uploads` và `db` cho volume ở thư mục gốc.

Sửa `example.db.env` và `example.site.env` thành `db.env` và `site.env`.

Sửa các config trong `site.env`, `db.env`, `uwsgi.ini`.

> *__NOTE:__* `BRIDGED_JUDGE_ADDRESS`và `BRIDGED_DJANGO_ADDRESS` ở `site.env`, các address cách nhau bởi `;`, host và port cách nhau bởi `,`, kết thúc không có `;`. VD: "example1.com,9998" hoặc "example1.com,9998;example2.com,9996;example3.com,9993".

2. Build image

Chạy `docker compose build --no-cache` để build image.

3. Khởi chạy các container

Sau khi build xong, chạy `docker compose up -d`.

4. Restore data

Copy các file, thư mục đã backup và `uploads`, `problems`.

---

**Restore database:** 

Giả sử bạn lưu file backup ở `/mybackup/backup.sql`.

```shell copy
docker cp /mybackup/backup.sql dmoj-mariadb:/backup.sql
docker exec -it dmoj-mariadb /bin/bash
apt update
apt-get install mysql-client
mysql -u dmoj -p dmoj < /backup.sql
# Enter password
exit
```

Restart dmoj site sau khi load data vào database: 
```shell copy
docker exec dmoj-site supervisorctl restart all
```
